Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbTBQWEo>; Mon, 17 Feb 2003 17:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTBQWEo>; Mon, 17 Feb 2003 17:04:44 -0500
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:12174 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S267612AbTBQWEo>;
	Mon, 17 Feb 2003 17:04:44 -0500
Date: Mon, 17 Feb 2003 14:14:43 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-pre4] IDE hangs box after timeout
Message-ID: <20030217221443.GA16646@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't think this happened on older kernels (< 2.4.18ish), but it may
have happened on 2.4.20 (though I have other problems with 2.4.20 on this
box that makes testing more difficult -- it tends to Oops fairly often).

Anyway, this box has a massive collection of old (and new) drives to make
a large storage area, using MD linear.  The box has two SCSI cards, two
promise cards (PDC20269), and onboard IDE (PIIX4).  Because the box has
so many drives, I had to use a number of power splitters which are, of
course, cheap and thus unreliable, and occasionally a few drives will
fall off of the bus.  This is the real problem, yes, but it seems to be
triggering a lockup bug in 2.4.21-pre4.  When hda falls off the bus due
to power loss, I see this on the console:

hda: dma_timer_expiry: dma status == 0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting

...followed by a complete lockup where sysreq does not appear to work.

dmesg and config available here:

	http://blue.netnation.com/sim/ref/alfie.dmesg
	http://blue.netnation.com/sim/ref/alfie.config

( Yes, a new power supply is on order. :) )

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
