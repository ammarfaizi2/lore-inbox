Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267801AbUHZIYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267801AbUHZIYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267806AbUHZIYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:24:14 -0400
Received: from mail.linicks.net ([217.204.244.146]:53252 "EHLO
	Linux233.linicks.net") by vger.kernel.org with ESMTP
	id S267801AbUHZIYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:24:09 -0400
From: Nick Warne <nick@linicks.net>
Subject: CD drive packet command errors.
Date: Thu, 26 Aug 2004 09:24:04 +0100
User-Agent: KMail/1.6.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408260924.04424.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have a strange problem here, and after 2 days trying everything I can't
seem to resolve.

Running Slackware 10 - with handrolled 2.4.27 kernel.

/dev/hdc ==

ATAPI CD-ROM, with removable media
        Model Number:       R/RW 8x4x32
        Serial Number:      4VO5045DM02453
        Firmware Revision:  2,0


/dev/hdd ==

ATAPI CD-ROM, with removable media
        Model Number:       CRD-8520B
        Serial Number:      2000/05/08
        Firmware Revision:  1.00

dmesg:

Aug 22 13:00:59 linuxamd kernel: hdc: R/RW 8x4x32, ATAPI CD/DVD-ROM drive
Aug 22 13:00:59 linuxamd kernel: hdd: CRD-8520B, ATAPI CD/DVD-ROM drive

Aug 22 13:00:59 linuxamd kernel: hdd: attached ide-cdrom driver.

Aug 22 13:00:59 linuxamd kernel: hdc: attached ide-scsi driver.
Aug 22 13:00:59 linuxamd kernel:   Vendor: IDE-CD    Model: R/RW 8x4x32
Rev:  2,0
Aug 22 13:00:59 linuxamd kernel:   Type:   CD-ROM
ANSI SCSI revision: 02



/dev/hdc I use the scsi emulation with boot append="hdc=ide-scsi"
/dev/cdrom -> /dev/hdd

The /dev/hdc writer is fine, and functions perfectly.

But with the normal cd drive on /dev/hdd, any time I open KFM, or do a
mount/umount from console, I get this in syslogs:

Aug 25 15:53:33 linuxamd kernel: hdd: packet command error: status=0x51
{ DriveReady SeekComplete Error }
Aug 25 15:53:33 linuxamd kernel: hdd: packet command error: error=0xa0

But the drive will mount OK, and all works as it should.  Just these logs
all the time.

I have changed cables, I have turned off dma on hdd, I have messed with DMA
and PIO modes - tried everything.

Has anybody any ideas whatever causes this?

TIA,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
