Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUJBQoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUJBQoE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUJBQoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:44:03 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:40563 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267334AbUJBQoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:44:00 -0400
Message-ID: <58cb370e04100209432ec9c9ee@mail.gmail.com>
Date: Sat, 2 Oct 2004 18:43:59 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Adam Sherman <adam@sherman.ca>
Subject: Re: DMA timeout error
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cjmk3s$gjs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <cjmk3s$gjs$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2004 14:56:42 -0400, Adam Sherman <adam@sherman.ca> wrote:
> I have a VIA M6000 board with an ATA CompactFlash adaptor containing a
> 512MB SanDisk card.
> 
> I get the following error during boot:
> 
> hdb: dma_timer_expiry: dma status == 0x41
> hdb: DMA timeout error
> hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hdb: drive not ready for command
> hdb: dma_timer_expiry: dma status == 0x41
> hdb: DMA timeout error
> hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hdb: drive not ready for command
> 
> Any ideas?

If this is a new CF capable of DMA but CF-to-IDE adapter doesn't support
DMA (most don't) then "ide=nodma" kernel command line parameter should
do the job.  It might be also bug in via82cxxx host driver.

Maybe DMA should be off by default for CF but it requires fixing almost
every IDE host driver and why punish good hardware.
