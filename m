Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVIMQSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVIMQSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVIMQSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:18:06 -0400
Received: from ispmxmta09-srv.alltel.net ([166.102.165.170]:53949 "EHLO
	ispmxmta09-srv.alltel.net") by vger.kernel.org with ESMTP
	id S964844AbVIMQSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:18:04 -0400
Date: Tue, 13 Sep 2005 12:18:02 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@postal
To: linux-kernel@vger.kernel.org
Subject: SCSI issue with 2.6.14-rc1
Message-ID: <Pine.LNX.4.63.0509131202170.1684@postal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dell Poweredge 1300, MegaRAID SCSI with hardware RAID1. With 2.6.13, 
system was fine, but on 2.6.14-rc1, it sees the RAID array as a 0mb drive 
with 1 512-byte sector, and seems to have a bit of a problem mounting /

2.6.13:
megaraid: found 0x8086:0x1960:bus 0:slot 13:func 1
scsi0:Found MegaRAID controller at 0xf8802000, IRQ:185
megaraid: [1.06:1p00] detected 1 logical drives.
megaraid: channel[0] is raid.
megaraid: channel[1] is raid.
scsi0 : LSI Logic MegaRAID 1.06 254 commands 16 targs 5 chans 7 luns
scsi0: scanning scsi channel 0 for logical drives.
   Vendor: MegaRAID  Model: LD0 RAID1  8568R  Rev: 1.06
   Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0: scanning scsi channel 4 [P0] for physical devices.
scsi0: scanning scsi channel 5 [P1] for physical devices.
st: Version 20050501, fixed bufsize 32768, s/g segs 256
SCSI device sda: 17547264 512-byte hdwr sectors (8984 MB)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
sda: asking for cache data failed
sda: assuming drive cache: write through
SCSI device sda: 17547264 512-byte hdwr sectors (8984 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
  sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

2.6.14-rc1:
megaraid: found 0x8086:0x1960:bus 0:slot 13:func 1
scsi0:Found MegaRAID controller at 0xf8802000, IRQ:185
megaraid: [1.06:1p00] detected 1 logical drives.
megaraid: channel[0] is raid.
megaraid: channel[1] is raid.
scsi0 : LSI Logic MegaRAID 1.06 254 commands 16 targs 5 chans 7 luns
scsi0: scanning scsi channel 0 for logical drives.
   Vendor: MegaRAID  Model: LD0 RAID1  8568R  Rev: 1.06
   Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0: scanning scsi channel 4 [P0] for physical devices.
scsi0: scanning scsi channel 5 [P1] for physical devices.
st: Version 20050830, fixed bufsize 32768, s/g segs 256
sda : sector size 0 reported, assuming 512.
SCSI device sda: 1 512-byte hdwr sectors (0 MB)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
sda: asking for cache data failed
sda: assuming drive cache: write through
sda : sector size 0 reported, assuming 512.
SCSI device sda: 1 512-byte hdwr sectors (0 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
  sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0



Linux RTIX-NM-003 2.6.13 #8 SMP Wed Aug 31 16:38:12 EDT 2005 i686 
GNU/Linux

Gnu C                  2.95.4
Gnu make               3.80
binutils               2.16.1
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1

CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_LOGGING=y
CONFIG_MEGARAID_LEGACY=y


-- 
Burton Windle                           bwindle@fint.org

