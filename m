Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbUBYLlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 06:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbUBYLlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 06:41:44 -0500
Received: from witte.sonytel.be ([80.88.33.193]:65531 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261271AbUBYLlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 06:41:40 -0500
Date: Wed, 25 Feb 2004 12:41:25 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Otto Solares <solca@guug.org>
cc: James Simmons <jsimmons@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
In-Reply-To: <20040225031553.GC17390@guug.org>
Message-ID: <Pine.GSO.4.58.0402251240140.24169@waterleaf.sonytel.be>
References: <20040224214106.GA17390@guug.org>
 <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
 <20040225031553.GC17390@guug.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Otto Solares wrote:
> On Wed, Feb 25, 2004 at 01:21:39AM +0000, James Simmons wrote:
> > > On the other side i see a lot of effort in the fbdev acceleration,
> > > it is nice but that effort should be better spent on fixing the layer,
> > > imo, the only user for acceleration is fbcon, any userland app that
> > > use fbdev disables that acceleration so it can map the vmem and ioregs,
> > > and do it's own voodoo if it wants acceleration.  That acceleration
> > > is not "exported" to user space.  I am working in a open source project
> > > that uses mesa-solo with fbdev and many limitations from the layer
> > > itself have been seen.
> >
> > That is true so far for fillrect and copyarea functions. Imageblit will be
> > used for read and writes on /dev/fbX. Also it is used for software
> > cursors.
>
> But if acceleration is not disabled you can't map the vmem and io regions.

I don't expect an app that mmap()s mmio to read/write from /dev/fb* at the same
time. So I see no problem disabling accelerated read/write while mmio is
mapped.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
