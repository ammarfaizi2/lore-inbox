Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSLCRvf>; Tue, 3 Dec 2002 12:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSLCRvf>; Tue, 3 Dec 2002 12:51:35 -0500
Received: from [203.167.79.9] ([203.167.79.9]:35337 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S262796AbSLCRvc>; Tue, 3 Dec 2002 12:51:32 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
From: Antonino Daplas <adaplas@pol.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1038930464.11426.1.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org> 
	<1038917280.1228.7.camel@localhost.localdomain> 
	<1038930464.11426.1.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1038948479.1040.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 01:50:12 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 20:47, Alan Cox wrote:
> On Tue, 2002-12-03 at 12:22, Antonino Daplas wrote:
> > >   Things I like to get done for the vga16fb driver. 
> > > 
> > >   1) Its own read and write functions to fake a linear framebuffer.
> > Should be doable with fb_write and fb_read, but with mmap, the app still
> > needs to know the VGA format.
> 
> I question whether thats something that belongs anywhere near the
> kernel. Ben Pfaff wrote a fine library for vga16 hackery (BOGL) and it
> combines very nicely with the fb driver.
I kinda agree with this.  Most fb apps use mmap to access the
framebuffer, so it's almost impossible to fake a linear framebuffer from
a planar one.  

> 
> > >   2) The ability to go back to vga text mode on close of /dev/fb. 
> > >      Yes fbdev/fbcon supports that now. 
> > 
> > I'll take a stab at writing VGA save/restore routines which hopefully is
> > generic enough to be used by various hardware.  No promises though, VGA
> > programming gives me a headache :(
> 
> You can pull the code out of the old svgalib library. Since its not
> doing any card specific stuff the generic vga->text restore ought to do
> the right thing.
> 
Thanks for the info.  I think I'll review this one to see what I missed.

Tony



