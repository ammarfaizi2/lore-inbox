Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264961AbSJaF0e>; Thu, 31 Oct 2002 00:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbSJaF0d>; Thu, 31 Oct 2002 00:26:33 -0500
Received: from netrealtor.ca ([216.209.85.42]:4370 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S264961AbSJaF0d>;
	Thu, 31 Oct 2002 00:26:33 -0500
Date: Thu, 31 Oct 2002 00:33:10 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Rasmus Andersen <rasmus@jaquet.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031053310.GB4780@mark.mielke.cc>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031011002.GB28191@opus.bloom.county>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 06:10:02PM -0700, Tom Rini wrote:
> On Thu, Oct 31, 2002 at 01:53:14AM +0100, Adrian Bunk wrote:
> > could you try to use "-Os" instead of "-O2" as gcc optimization option
> > when CONFIG_TINY is enabled? Something like the following (completely
> > untested) patch:
> -Os can produce larger binaries, keep in mind.  If we're going to go
> this route, how about something generally useful, and allow for general
> optimization level / additional CFLAGS to be added.

Sure CFLAGS should be configurable, but CONFIG_TINY should always prefer
-Os over -O2. From 'man gcc':

       -Os Optimize for size.  -Os enables all -O2 optimizations that do not
           typically increase code size.  It also performs further optimiza-
           tions designed to reduce code size.

If gcc regularly generates larger code with -Os the answer is to talk to
the gcc people, not to avoid using -Os...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

