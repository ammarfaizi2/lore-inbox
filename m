Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTD2BFD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 21:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbTD2BFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 21:05:03 -0400
Received: from adsl-68-74-104-142.dsl.klmzmi.ameritech.net ([68.74.104.142]:33547
	"EHLO tabriel.tabris.net") by vger.kernel.org with ESMTP
	id S261428AbTD2BFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 21:05:01 -0400
From: Tabris <tabris@sbcglobal.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc1-ac2 Promise IDE DMA won't work
Date: Mon, 28 Apr 2003 21:12:46 -0400
User-Agent: KMail/1.5
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304282112.47061.tabris@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked thru marc's archives, and i'm not finding anything specific to 
this problem, tho I do believe it is probably a known issue.

ASUS A7v266-E
PDC20265
LITE-ON LTR-32123S

only device on the Promise IDE is the cd-rw drive. have four hard drives 
on the VIA IDE.

running kernel 2.4.21-rc1-ac2 + preempt + rmap15g + i2c-sensors

burning now works using cdrecord ATAPI (previous was 2.4.21-pre5-ac3 
where the ide-scsi was too unstable)

at present, reading the cd drive takes 80+% of CPU system time...

I would like to be able to enable DMA. i tried doing it manually with 
hdparm. enabling 32-bit IO or enabling DMA would both make it just not 
work.
[root@tabriel root]# hdparm /dev/hdg

/dev/hdg:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  1 (on)
 readahead    =  8 (on)
 HDIO_GETGEO failed: Invalid argument
[root@tabriel root]#
[root@tabriel root]# hdparm -I /dev/hdg

/dev/hdg:

ATAPI CD-ROM, with removable media
        Model Number:       LITE-ON LTR-32123S
        Serial Number:
        Firmware Revision:  XS0R
Standards:
        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
        Supported: CD-ROM ATAPI-2
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(cannot be disabled)
        DMA: *mdma0 mdma1 mdma2 udma0 udma1 udma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=227ns  IORDY flow control=120ns
[root@tabriel root]#


any more info needed, just ask. any help much appreciated.


-- 
"Ignorance is the soil in which belief in miracles grows."
-- Robert G. Ingersoll

