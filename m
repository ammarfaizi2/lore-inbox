Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbUBYOC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 09:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbUBYOC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 09:02:27 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:30188 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261328AbUBYOCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 09:02:25 -0500
Date: Wed, 25 Feb 2004 15:01:21 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Otto Solares <solca@guug.org>, James Simmons <jsimmons@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
Message-ID: <20040225140121.GA13029@lambda>
References: <20040224214106.GA17390@guug.org> <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org> <20040225031553.GC17390@guug.org> <Pine.GSO.4.58.0402251240140.24169@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402251240140.24169@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Sven Luther <sven.luther@wanadoo.fr>
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

I wonder about X though. It uses mmio for accels (in the non fbdev case
though) and needs to map the memory area for fallback case, like the non
supported bressenham lines on permedia 2/3 for example. Altough it is
possible that the fact that X does its own mapping, and anyway, has very
little interaction with fbcon and fbdev anyway.

Friendly,

Sven Luther

