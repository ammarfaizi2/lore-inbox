Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317960AbSGWGGI>; Tue, 23 Jul 2002 02:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317961AbSGWGGI>; Tue, 23 Jul 2002 02:06:08 -0400
Received: from [196.26.86.1] ([196.26.86.1]:3008 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317960AbSGWGGE>; Tue, 23 Jul 2002 02:06:04 -0400
Date: Tue, 23 Jul 2002 08:27:06 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Jens Axboe <axboe@suse.de>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.25-dj2-ide24 and lost interrupts
Message-ID: <Pine.LNX.4.44.0207230826200.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre, Jens,
	This box can boot 2.4.19-pre-ac fine and handle an IDE disk load 
but can't go multiuser in 2.5.25-dj2 w/ 2.4 IDE. It is only capable of PIO.

# ATA/IDE/MFM/RLL support
CONFIG_IDE=y
CONFIG_IDE_24=y
# CONFIG_IDE_25 is not set
# IDE, ATA and ATAPI Block devices
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_BLK_DEV_IDE_MODES is not set

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: Generic 1234, ATA DISK drive
hdb: Generic 1234, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: task_no_data_intr: status=0x41 { DriveReady Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 1125936 sectors (576 MB) w/256KiB Cache, CHS=558/32/63
hdb: task_no_data_intr: status=0x41 { DriveReady Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError }
hdb: 1023120 sectors (524 MB) w/256KiB Cache, CHS=1015/16/63
 hda: hda1
 hdb: hdb1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 256 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2730)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 88k freed
INIT: version 2.78 booting
hda: lost interrupt
hda: lost interrupt
ad inifinitum...

with 2.4.19-rc2:
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: Generic 1234, ATA DISK drive
hdb: Generic 1234, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 1125936 sectors (576 MB) w/256KiB Cache, CHS=558/32/63
hdb: 1023120 sectors (524 MB) w/256KiB Cache, CHS=1015/16/63
Partition check:
 hda: hda1
 hdb: hdb1


-- 
function.linuxpower.ca

