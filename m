Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbTABSVF>; Thu, 2 Jan 2003 13:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbTABSVF>; Thu, 2 Jan 2003 13:21:05 -0500
Received: from linux.kappa.ro ([194.102.255.131]:25236 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S266297AbTABSVE>;
	Thu, 2 Jan 2003 13:21:04 -0500
Date: Thu, 2 Jan 2003 20:29:32 +0200
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: UDMA 133 on a 40 pin cable
Message-ID: <20030102182932.GA27340@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Today i mounted a HDD on my secondary IDE on a 40 pin cable and surprise
the kernel set it up on UDMA 133:

hdd: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=119150/16/63, UDMA(133)

I wouldn't have notice this unless I got some errors:

Jan  2 20:20:40 theo kernel: hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Jan  2 20:20:40 theo kernel: hdd: dma_intr: error=0x84 { DriveStatusError BadCRC }
Jan  2 20:20:40 theo kernel: hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Jan  2 20:20:40 theo kernel: hdd: dma_intr: error=0x84 { DriveStatusError BadCRC }
Jan  2 20:20:40 theo kernel: hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Jan  2 20:20:40 theo kernel: hdd: dma_intr: error=0x84 { DriveStatusError BadCRC }
Jan  2 20:20:40 theo kernel: hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Jan  2 20:20:40 theo kernel: hdd: dma_intr: error=0x84 { DriveStatusError BadCRC }
Jan  2 20:20:40 theo kernel: ide1: reset: success


This box is running kernel: 2.4.18-18.8.0 ( redhat 8.0 )

Teo
