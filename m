Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262454AbSJaO1Y>; Thu, 31 Oct 2002 09:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSJaO1Y>; Thu, 31 Oct 2002 09:27:24 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:25001 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S262454AbSJaO1X>; Thu, 31 Oct 2002 09:27:23 -0500
Date: Thu, 31 Oct 2002 07:33:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Adrian Bunk <bunk@fs.tum.de>, Rasmus Andersen <rasmus@jaquet.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031143301.GC28191@opus.bloom.county>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031053310.GB4780@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 12:33:10AM -0500, Mark Mielke wrote:
> On Wed, Oct 30, 2002 at 06:10:02PM -0700, Tom Rini wrote:
> > On Thu, Oct 31, 2002 at 01:53:14AM +0100, Adrian Bunk wrote:
> > > could you try to use "-Os" instead of "-O2" as gcc optimization option
> > > when CONFIG_TINY is enabled? Something like the following (completely
> > > untested) patch:
> > -Os can produce larger binaries, keep in mind.  If we're going to go
> > this route, how about something generally useful, and allow for general
> > optimization level / additional CFLAGS to be added.
> 
> Sure CFLAGS should be configurable, but CONFIG_TINY should always prefer
> -Os over -O2. From 'man gcc':
> 
>        -Os Optimize for size.  -Os enables all -O2 optimizations that do not
>            typically increase code size.  It also performs further optimiza-
>            tions designed to reduce code size.
> 
> If gcc regularly generates larger code with -Os the answer is to talk to
> the gcc people, not to avoid using -Os...

It's not that it does regularly, it's that it can, and if it does, it's
not really a gcc bug from what I recall.  So I don't think CONFIG_TINY
should prefer -Os over -O2 but instead we should just ask the user what
level of optimization they want.  Remember, one of the real important
parts of embedded systems is flexibility.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
