Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265982AbTIJXHy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265984AbTIJXHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:07:54 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:41268 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S265982AbTIJXHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:07:22 -0400
Subject: [2.4.22] umount usb memory card fails
From: Harm Verhagen <h.verhagen@chello.nl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1063235214.5729.14.camel@i141046.upc-i.chello.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Sep 2003 01:06:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

When I upgraded my kernel version from 2.4.20-19.9(RedHat) to 2.4.22
vanilla, unmounting my smartmedia cardreader (apacer combo reader)
stopped working.


[/home/harm]$umount /mnt/usbreader
umount: /mnt/usbreader: device is busy

$fuser /mnt/usbreader shows  its not in use at all.

Mounting and writing/reading does work.

weird thing:
This only happens when the PC boots with the card reader connected.
If I actually unplug the device and plug it back in, then
mounting/unmounting does work.

Anyone an idea ?

Regards,
Harm Verhagen


usb reader info (from /proc/usb/devices)
T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0d7d ProdID=0240 Rev= 1.00
S:  Manufacturer=
S:  Product=USB Reader
S:  SerialNumber=032702000797
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA

dmesg info when I plugin the device:

USB Mass Storage device found at 3
sda: Unit Not Ready, sense:
Current 00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.
sda: Write Protect is off
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
sdb: Unit Not Ready, sense:
Current 00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : block size assumed to be 512 bytes, disk size 1GB.
sdb: Write Protect is off
 sdb: I/O error: dev 08:10, sector 0
 I/O error: dev 08:10, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Current 00:00: sense key Not Ready
Additional sense indicates Medium not present
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdc : block size assumed to be 512 bytes, disk size 1GB.
sdc: Write Protect is on
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
sdc: Unit Not Ready, sense:
Current 00:00: sense key Not Ready
Additional sense indicates Medium not present
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdc : block size assumed to be 512 bytes, disk size 1GB.
sdc: Write Protect is on
 sdc: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table



-- 
Harm Verhagen <h.verhagen@chello.nl>

