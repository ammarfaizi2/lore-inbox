Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbUBZTnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbUBZTnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:43:17 -0500
Received: from opensource-ca.org ([168.234.203.30]:64903 "EHLO
	guug.galileo.edu") by vger.kernel.org with ESMTP id S262964AbUBZTkP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:40:15 -0500
Date: Thu, 26 Feb 2004 13:40:20 -0600
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
Message-ID: <20040226194020.GF17390@guug.org>
References: <20040224214106.GA17390@guug.org> <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org> <20040225031553.GC17390@guug.org> <Pine.GSO.4.58.0402251240140.24169@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402251240140.24169@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 12:41:25PM +0100, Geert Uytterhoeven wrote:
> On Tue, 24 Feb 2004, Otto Solares wrote:
> > On Wed, Feb 25, 2004 at 01:21:39AM +0000, James Simmons wrote:
> > > > On the other side i see a lot of effort in the fbdev acceleration,
> > > > it is nice but that effort should be better spent on fixing the layer,
> > > > imo, the only user for acceleration is fbcon, any userland app that
> > > > use fbdev disables that acceleration so it can map the vmem and ioregs,
> > > > and do it's own voodoo if it wants acceleration.  That acceleration
> > > > is not "exported" to user space.  I am working in a open source project
> > > > that uses mesa-solo with fbdev and many limitations from the layer
> > > > itself have been seen.
> > >
> > > That is true so far for fillrect and copyarea functions. Imageblit will be
> > > used for read and writes on /dev/fbX. Also it is used for software
> > > cursors.
> >
> > But if acceleration is not disabled you can't map the vmem and io regions.
> 
> I don't expect an app that mmap()s mmio to read/write from /dev/fb* at the same
> time. So I see no problem disabling accelerated read/write while mmio is
> mapped.

Exactly, that's the whole point, if you want userland accel you must disable
kernel land accel.  That's was my question against acceleration work inside
the kernel.  Nobody use it in userland and is the stability devil in fbdev.
If you want acceleration in userland there is mesa-solo or directfb or console-sdl.

In short acceleration belongs to specialized libs not the kernel.

Why accel it is needed for font drawing?, i am pretty sure my 8bit video old
sparc doesn't have any accel and is pretty capable for drawing fonts.

-otto

