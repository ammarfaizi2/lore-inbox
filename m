Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbUAYRoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUAYRoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:44:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19119 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264981AbUAYRoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:44:18 -0500
Date: Sun, 25 Jan 2004 18:44:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Charles Shannon Hendrix <shannon@widomaker.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.1 and cdrecord on ATAPI bus
Message-ID: <20040125174413.GU2734@suse.de>
References: <20040117031925.GA26477@widomaker.com> <20040117042208.GA8664@merlin.emma.line.org> <20040117154905.GB26248@widomaker.com> <jevfna5vg7.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jevfna5vg7.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17 2004, Andreas Schwab wrote:
> Charles Shannon Hendrix <shannon@widomaker.com> writes:
> 
> > Sat, 17 Jan 2004 @ 05:22 +0100, Matthias Andree said:
> >
> >> Interesting. I use dev=/dev/hdc and it works fine for me (Plextor 48X),
> >> but then again, I'm also running the latest cdrecord alpha.
> >
> > % cdrecord -version
> > Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
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

ppc pmac ide has known problems withe residual data counts for dma
transfers. basically it's a limitation in the ide dma api.

-- 
Jens Axboe

