Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbUBYCSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 21:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbUBYCSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 21:18:00 -0500
Received: from guug.org ([168.234.203.30]:43398 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S262357AbUBYCR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 21:17:57 -0500
Date: Tue, 24 Feb 2004 20:18:08 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
Message-ID: <20040225021808.GB17390@guug.org>
References: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org> <1077672591.978.49.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077672591.978.49.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 12:29:52PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2004-02-25 at 12:21, James Simmons wrote:
> > > Sure, hopefully fbdev drivers became more 'intelligent', with just a
> > > 
> > > echo "1024x768x16-75" > /sys/class/fbdev/0/geometry
> > > 
> > > they will compute internally the timings or get it from EDID and
> > > glad the user with something correct for the hardware.
> > > 
> > > cat /sys/class/fbdev/0/modes
> > > 
> > > will give you the modes supported by the card.
> > 
> > Yes.
> 
> Note that "the modes supported by the card" means nothing.
> 
> They depend on something fundamentally dynamic, which is what is
> connected to what output, mixed with some card-spcific limitations
> (like bandwidth limitations when using 2 very big monitors, vram
> limitations, etc...)
> 
> You can not really know a-priori what modes will be available for
> sure. You can provide a list of modes that are considered as valid
> for a given output, but the whole mode setting scheme cannot be
> anything else but non-deterministic. You setup a global configuration,
> send it down the driver, and obtain a new configuration which may or
> may not be what you asked for.

Hmm, how does winxp and macosx get their respectives video modes,
what is missing in fbdev for that? MacOSX always gives you valid modes
including refresh rates per adaptor/monitor, WinXP always give you valid
modes and valid refresh rates for the video card, you actually
'Apply' to test, most of the time it simply works.

> I'm trying to address the API issues as part of the userland library
> I'm talking about in the other email. The actual interface to the
> kernel driver should ultimately be hidden, and eventually private
> between card-specific kernel driver and card-specific module in
> the userland API.

Great! i think your idea is great, does that library will be xserver
dependant or will be an independent lib so others projects like mine
could benefit from it?  Any bits somewhere?  This alone could boom
and revolutionize the graphics solutions for linux.  A step in the
right direction for "World Domination" in the desktop field.

-otto

