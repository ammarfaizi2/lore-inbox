Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132887AbRDJAdf>; Mon, 9 Apr 2001 20:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132888AbRDJAdZ>; Mon, 9 Apr 2001 20:33:25 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:20740
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132887AbRDJAdQ>; Mon, 9 Apr 2001 20:33:16 -0400
Date: Mon, 9 Apr 2001 17:33:13 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: ide.2.2.19.04092001.patch
Message-ID: <Pine.LNX.4.10.10104091720030.1878-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is up with some updates

Short notice development for Promise Ultra100 TX2 sponsored by
Penguin Computer and again little/no help from Promise.

This is a unique chipset that does setfeatures sensing of the transfer
rates and thus it is counter to the standard Promise design.  It does
still use the pdc202xx.c chipset code, but much of it is skipped over to
preserve the hidden settings calls.  The one issue for this chipset is
that it may not be ideal for hotswap as the unknown states are issues.

DiskPerf /dev/hde
Device: IBM-DTLA-307075 Serial Number: YSDYSFA5874
LBA 0 DMA Read Test                      = 63.35 MB/Sec (3.95 Seconds)
Outer Diameter Sequential DMA Read Test  = 35.89 MB/Sec (6.97 Seconds)
Inner Diameter Sequential DMA Read Test  = 17.64 MB/Sec (14.17 Seconds)

CR3's adjusted:	for kernel transfer rates and conservative
LBA 0 DMA Read Test                      = 85.52 MB/Sec
Outer Diameter Sequential DMA Read Test  = 48.45 MB/Sec
Inner Diameter Sequential DMA Read Test  = 23.81 MB/Sec

There is about a 35%-40% under reporting of performance from kernel to
user-space ioctl calls.

Cheers,

Andre Hedrick
Linux ATA Development



