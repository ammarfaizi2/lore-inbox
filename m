Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSLJNzP>; Tue, 10 Dec 2002 08:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSLJNzP>; Tue, 10 Dec 2002 08:55:15 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:52683 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261305AbSLJNzO>; Tue, 10 Dec 2002 08:55:14 -0500
Date: Tue, 10 Dec 2002 14:03:01 +0000
From: Dave Jones <davej@suse.de>
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
Message-ID: <20021210140301.GC26361@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Antonino Daplas <adaplas@pol.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1039522886.1041.17.camel@localhost.localdomain> <20021210131143.GA26361@suse.de> <1039538881.2025.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039538881.2025.2.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 09:47:24PM +0500, Antonino Daplas wrote:

 > >  > 2.  The i810 driver for Xfree86 will also fail to load because of
 > >  > version mismatch (0.99 vs 1.0).  Rolling back the version corrects the
 > >  > problem.
 > > Ugh, that's great. So X has to be patched every time the agpgart code
 > > gets a new revision ? That sounds really unpleasant.
 > Actually, X is complaining that the kernel version was too old, crazy
 > no?

Very much so. I'm grabbing the X source right now to find out exactly
what games they're playing. Hopefully I'll not regret it too much.

 > >  > No patches because I don't want to uglify the code :-)
 > > I'll ping you when I have something to test.
 > Ok.

btw, iirc you were the guy who wanted agpgart initialised sooner
due to the way the i810 framebuffer worked ?
How much sooner are we talking ? What puzzles me, is looking
at the link order in the makefiles, agpgart should already be
getting initialised before the framebuffer code, but doesn't
seem to be for reasons unknown..

Another issue on this same case, is that for this to work out,
we'll need some kconfig magick so that if the framebuffer is 'Y'
rather than 'M' the i810 gart module must be forced to 'Y' too.

        Dave

