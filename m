Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265233AbSJaQgT>; Thu, 31 Oct 2002 11:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSJaQfQ>; Thu, 31 Oct 2002 11:35:16 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:16295 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP
	id <S265222AbSJaQei>; Thu, 31 Oct 2002 11:34:38 -0500
Date: Thu, 31 Oct 2002 10:08:55 -0700
From: Matt Porter <porter@cox.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031100855.A3407@home.com>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc> <20021031143301.GC28191@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021031143301.GC28191@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Oct 31, 2002 at 07:33:01AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 07:33:01AM -0700, Tom Rini wrote:
> On Thu, Oct 31, 2002 at 12:33:10AM -0500, Mark Mielke wrote:
> > On Wed, Oct 30, 2002 at 06:10:02PM -0700, Tom Rini wrote:
> > > On Thu, Oct 31, 2002 at 01:53:14AM +0100, Adrian Bunk wrote:
> > > > could you try to use "-Os" instead of "-O2" as gcc optimization option
> > > > when CONFIG_TINY is enabled? Something like the following (completely
> > > > untested) patch:
> > > -Os can produce larger binaries, keep in mind.  If we're going to go
> > > this route, how about something generally useful, and allow for general
> > > optimization level / additional CFLAGS to be added.
> > 
> > Sure CFLAGS should be configurable, but CONFIG_TINY should always prefer
> > -Os over -O2. From 'man gcc':
> > 
> >        -Os Optimize for size.  -Os enables all -O2 optimizations that do not
> >            typically increase code size.  It also performs further optimiza-
> >            tions designed to reduce code size.
> > 
> > If gcc regularly generates larger code with -Os the answer is to talk to
> > the gcc people, not to avoid using -Os...
> 
> It's not that it does regularly, it's that it can, and if it does, it's
> not really a gcc bug from what I recall.  So I don't think CONFIG_TINY
> should prefer -Os over -O2 but instead we should just ask the user what
> level of optimization they want.  Remember, one of the real important
> parts of embedded systems is flexibility.

Thank you.  This is exactly why in the last CONFIG_TINY thread I made
it clear that a one-size-fits-all option is not all that helpful for
serious embedded systems designers.

Collecting these parameters in a single tweaks.h file and perhaps using
things like CONFIG_TINY, CONFIG_DESKTOP, CONFIG_FOO as profile selectors
into tweaks.h would be a lot more effective.  His collection of
(hopefully) size-optimizing tweaks can all be selected via CONFIG_TINY,
but have them collected at a single point like tweaks.h such that they
can be individually modified by an end system integrator.

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
