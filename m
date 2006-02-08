Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWBHCOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWBHCOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWBHCOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:14:47 -0500
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:46281 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1030447AbWBHCOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:14:47 -0500
Message-ID: <43E95415.40501@comcast.net>
Date: Tue, 07 Feb 2006 21:14:45 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: libata pata atapi  errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, been spending the day using libata's pata interface to my plextor 
dvd writer.   All is good, it's burning dvdr's at their rated speed and 
using dma and everything works perfectly.   Apparently, after some 
amount of disks I got the following error.

Assertion failed! qc->n_elem > 
0,drivers/scsi/libata-core.c,ata_fill_sg,line=2586
   (repeated many times)
ata6: command 0xa0 timeout, stat 0xd0 host_stat 0x60
ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ATA: abnormal status 0xD0 on port 0x177
ATA: abnormal status 0xD0 on port 0x177
ATA: abnormal status 0xD0 on port 0x177
Device not ready. Make sure there is a disc in the drive.


Now, i used sg3-utils (from debian unstable amd64) and reset the device 
(using sg_reset) because it was stuck in a "writing" state.  I had to 
then use the "eject" utility to get the door to open because it was 
stuck in a locked state.  After all that, the device responds again, but 
is now making a strange vibration noise like the lens motor is trying to 
seek beyond where it's supposed to go.   and produces the errors again.  
Eventually the drive gets stuck in an active state and wont respond to 
any commands except spew errors when commands are attempted. 


this is with the amd/nvidia pata and sata drivers loaded on an smp 
athlon dual core system in 64bit mode.   Any additional info, just ask.
