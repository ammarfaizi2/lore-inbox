Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUGLPcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUGLPcj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUGLPcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:32:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42133 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266876AbUGLPcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:32:24 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mark Watts <m.watts@eris.qinetiq.com>
Subject: Re: HDIO_SET_DMA failed on a Dell Latitude C400 Laptop
Date: Mon, 12 Jul 2004 17:37:34 +0200
User-Agent: KMail/1.5.3
References: <200407121407.14428.m.watts@eris.qinetiq.com> <200407121422.00841.m.watts@eris.qinetiq.com>
In-Reply-To: <200407121422.00841.m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407121737.34189.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make sure that you have the driver for your IDE chipset compiled-in or
(if you are using IDE as module) that you load it and not ide-generic.

On Monday 12 of July 2004 15:22, Mark Watts wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> > I've just burnt a cd for the first time on a Dell Latitude C400 laptop
> > and I noticed that the system was quite sluggish while the burn was
> > happening. (mouse pointer erratic, window redraw slow etc).
> >
> > Remembering a similar issue with a desktop system, I did the following to
> > enable DMA on the hard drive (hdparm was giving ~3MB/sec read)
> >
> > # hdparm -c1 -d1 /dev/hda
> >
> > /dev/hda
> >  setting 32-bit IO_support flag to 1
> >  setting using_dma to 1 (on)
> >  HDIO_SET_DMA failed: Operation not permitted
> >  IO_support   =  1 (32-bit)
> >  using_dma   =  0 (off)
> >
> >
> > hdparm now reports ~7MB/sec which is better but still prety poor.
> >
> >
> > Any ideas why I couldn't set DMA on the drive?
> >
> >
> > CPU = Mobile Pentum 3 @1.2GHz (800MHz when booted with no power cord)
> > Ram = 256MB
> > HDD = IBM Travelstar (IC25N020ATDA04-0) 20GB
> > BIOS Rev = A12
>
> Kernel is a 2.6.7 kernel...

