Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRIOEe6>; Sat, 15 Sep 2001 00:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRIOEes>; Sat, 15 Sep 2001 00:34:48 -0400
Received: from forge.redmondlinux.org ([209.81.49.42]:26581 "EHLO
	forge.redmondlinux.org") by vger.kernel.org with ESMTP
	id <S268017AbRIOEeo>; Sat, 15 Sep 2001 00:34:44 -0400
Date: Fri, 14 Sep 2001 21:36:26 -0700 (PDT)
From: Joseph Cheek <joseph@cheek.com>
To: linux-kernel@vger.kernel.org
Subject: [ide-]scsi timeouts while writing cdrom
Message-ID: <Pine.LNX.4.10.10109142131030.28176-100000@forge.redmondlinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all,

my shiny new cdrw hangs the system when i try to burn a cdrom.  i've got a
a completely IDE system.  hda and hdb are hard drives while hdc is a
standard cdrom and hdd is a cdrw.

while burning cdrecord writes a couple of tracks and then the whole system
freezes [i need to hard power off].  i can blank cdrw's in the drive just
fine, however.  i'm running 2.4.9-ac10 SMP [on a single-proc system] and
all partitions are ext3.  ide-scsi is loaded as a module at boot.

here's what /var/log/messages shows:

Sep 14 21:12:45 sanfrancisco kernel: scsi : aborting command due to
timeout : pid 0, scsi0, channel 0, id 1, lun 0 0x00 00 00 00 00 00
Sep 14 21:12:54 sanfrancisco kernel: Device not ready.  Make sure there is
a disc in the drive.
Sep 14 21:12:55 sanfrancisco last message repeated 2 times
Sep 14 21:13:20 sanfrancisco kernel: hdb: timeout waiting for DMA
Sep 14 21:13:20 sanfrancisco kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
Sep 14 21:13:26 sanfrancisco kernel: scsi : aborting command due to
timeout : pid 0, scsi0, channel 0, id 1, lun 0 0x43 00 00 00 00 00 00 00
0c 00
Sep 14 21:13:37 sanfrancisco kernel: scsi : aborting command due to
timeout : pid 0, scsi0, channel 0, id 0, lun 0 0x2a 00 00 00 05 92 00 00
1f 00
Sep 14 21:13:37 sanfrancisco kernel: hdc: timeout waiting for DMA
Sep 14 21:13:37 sanfrancisco kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
Sep 14 21:13:37 sanfrancisco kernel: hdd: status timeout: status=0xd8 {
Busy }
Sep 14 21:13:37 sanfrancisco kernel: hdd: DMA disabled
Sep 14 21:13:37 sanfrancisco kernel: hdd: drive not ready for command
Sep 14 21:13:41 sanfrancisco kernel: hdd: ATAPI reset complete
Sep 14 21:13:41 sanfrancisco kernel: hdd: irq timeout: status=0xd0 { Busy
}
Sep 14 21:13:42 sanfrancisco kernel: hdd: ATAPI reset complete
Sep 14 21:13:42 sanfrancisco kernel: hdd: irq timeout: status=0x80 { Busy
}
Sep 14 21:13:42 sanfrancisco kernel: scsi0 channel 0 : resetting for
second half of retries.
Sep 14 21:13:42 sanfrancisco kernel: SCSI bus is being reset for host 0
channel 0.

any guesses?

thanks!

joe

