Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUAQTnt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUAQTnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:43:49 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:19985 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S266134AbUAQTnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:43:46 -0500
Date: Sat, 17 Jan 2004 13:54:39 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.1 and cdrecord on ATAPI bus
Message-ID: <20040117185439.GB4496@widomaker.com>
References: <20040117031925.GA26477@widomaker.com> <20040117042208.GA8664@merlin.emma.line.org> <20040117154905.GB26248@widomaker.com> <jevfna5vg7.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jevfna5vg7.fsf@sykes.suse.de>
X-Message-Flag: Microsoft Loves You!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, 17 Jan 2004 @ 18:36 +0100, Andreas Schwab said:

> > % cdrecord -version
> > Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
> >
> > I can try an alpha version, but from running strace on cdrecord, it
> > seems like Linux is the problem.  Several ioctl() calls are failing just
> > before cdrecord prints an error message and exits.
> 
> I see similar problems on ppc, with these messages in the log:
> 
> Jan 17 16:15:43 whitebox kernel: ide0, timeout waiting for dbdma command stop
> Jan 17 16:15:43 whitebox kernel: ide-cd: dma error
> Jan 17 16:15:43 whitebox kernel: hdb: DMA disabled
> Jan 17 16:15:43 whitebox kernel: hdb: dma error: status=0x50 { DriveReady SeekComplete }
> Jan 17 16:15:43 whitebox kernel: hdb: dma error: error=0x00
> Jan 17 16:15:43 whitebox kernel: cdrom_newpc_intr: 180 residual after xfer

That's odd because it wasn't that way in 2.4 and the beta 2.6 kernels.

I did see an error trying to load sr_mod when cdrecord runs, presumably
because it is trying to scan my external SCSI burner, which is turned
off.

But "modprobe sr_mod" works fine.

In case it matters, I have a VIA 82Cxxx chipset and an Asus K7V
motherboard, one of those KT133 Pro models.


-- 
UNIX/Perl/C/Pizza____________________s h a n n o n@wido !SPAM maker.com
