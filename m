Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVAOUZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVAOUZm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 15:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVAOUZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 15:25:42 -0500
Received: from zasran.com ([198.144.206.234]:65152 "EHLO jojda.zasran.com")
	by vger.kernel.org with ESMTP id S262317AbVAOUZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 15:25:34 -0500
Message-ID: <41E97C3D.3020104@bigfoot.com>
Date: Sat, 15 Jan 2005 12:25:33 -0800
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SATA disk dead? ATA: abnormal status 0x59 on port 0xE407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I got these errors when accessing SATA disk (via scsi):

Jan 15 11:56:50 jojda kernel: ata2: command 0x25 timeout, stat 0x59 
host_stat 0x21
Jan 15 11:56:50 jojda kernel: ata2: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Jan 15 11:56:50 jojda kernel: ata2: error=0x40 { UncorrectableError }
Jan 15 11:56:50 jojda kernel: scsi1: ERROR on channel 0, id 0, lun 0, 
CDB: Read (10) 00 00 00 01 26 00 00 29 00
Jan 15 11:56:50 jojda kernel: Current sda: sense key Medium Error
Jan 15 11:56:50 jojda kernel: Additional sense: Unrecovered read error - 
auto reallocate failed
Jan 15 11:56:50 jojda kernel: end_request: I/O error, dev sda, sector 294
Jan 15 11:56:50 jojda kernel: Buffer I/O error on device sda1, logical 
block 57
Jan 15 11:56:50 jojda kernel: ATA: abnormal status 0x59 on port 0xE407
Jan 15 11:56:50 jojda last message repeated 2 times

   when the disk was mounted I got it only when accessing certain 
directories but now any disk access generates these errors and processes 
that touch the disk are in disk wait state (I tried fsck, mount, 
dd_rescue), looks like some of them get out if it after very long time 
(1h+).

   I have another SATA drive (pretty much same, both are Maxtor 
DiamondMax 9, 250GB) and that one works when I connect it to same SATA 
and power cables so I think there is a problem with disk (not my setup 
or cables etc.).

   Since I didn't see any read error before I think it might be the 
electronics being dead, not the disk itself - considering that I have 
another disk of same model is it possible to swap the disks (right now I 
can't try it because I don't have funny screwdriver to fit the screws on 
the disk).

   my system: kernel 2.6.9, debian unstable, SATA disks seen as scsi 
disks (CONFIG_SCSI_SATA=y).

   Is there anything I can do to rescue (some of) the data on the disk?

   TIA,

	erik
