Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270441AbTG1Sac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270444AbTG1Sac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:30:32 -0400
Received: from windsormachine.com ([206.48.122.28]:61704 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S270441AbTG1Sab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:30:31 -0400
Date: Mon, 28 Jul 2003 14:45:44 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA not supported with Intel ICH4 I/O controller?
In-Reply-To: <PMEMILJKPKGMMELCJCIGCEIHCDAA.kfrazier@mdc-dayton.com>
Message-ID: <Pine.LNX.4.56.0307281443300.8747@router.windsormachine.com>
References: <PMEMILJKPKGMMELCJCIGCEIHCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Kathy Frazier wrote:

> I just read on an Intel site
> (http://64.143.3.64/downloads/drivers/845/perform/linux/udma.htmthat) "ICH4
> requires kernel 2.5.12 or later to enable any DMA mode".  Can you guys
> support or refute this?  No wonder I'm having problems with my DMA device on
> the ASUS P4PE (using Intel 845PE and ICH4 chipsets)!  Are there any patches,
> by chance, against a 2.4.20-8 that will give our system DMA support?  Or
> maybe a patch for 2.4.21?  kernel.org shows that the latest (albeit beta)
> kernel is 2.6.0-test2 . . . I hestiate to use that, because we would like
> something more stable to ship with our product.

I'm running 2.4.21 on this particular machine, and know it worked under
2.4.20.

  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 1).
      IRQ 10.
      I/O at 0xf000 [0xf00f].
      Non-prefetchable 32 bit memory at 0x20000000 [0x200003ff].

mike:~# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)

mike:~# hdparm -Tt /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.37 seconds =345.95 MB/sec
 Timing buffered disk reads:  64 MB in  1.88 seconds = 34.04 MB/sec

ASUS P4B533 here, and other similar machines work as well.

Mike
