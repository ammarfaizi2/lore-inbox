Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTDPSSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTDPSSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:18:52 -0400
Received: from h77n1fls31o996.telia.com ([213.65.229.77]:57753 "EHLO
	gw.dio.net") by vger.kernel.org with ESMTP id S264515AbTDPSSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:18:47 -0400
From: "Anders Larsson" <anders@dio.jll.se>
To: linux-kernel@vger.kernel.org
Subject: bio too big device
Date: Wed, 16 Apr 2003 19:32:15 +0100
Message-Id: <20030416183139.M18348@gw>
In-Reply-To: <20030416181944.M32238@gw>
References: <20030416172122.M65357@gw> <20030416181944.M32238@gw>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 192.168.100.2 (anders)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi got this probb with this 

Apr 16 16:31:23 cab kernel: bio too big device ide3(34,65) (256 > 255)
Apr 16 16:38:44 cab kernel: bio too big device ide3(34,1) (256 > 255)
Apr 16 16:55:49 cab kernel: bio too big device ide3(34,1) (256 > 255)
Apr 16 17:05:02 cab kernel: bio too big device ide3(34,1) (256 > 255)
Apr 16 17:19:20 cab kernel: bio too big device ide3(34,65) (256 > 255)
Apr 16 17:30:42 cab kernel: bio too big device ide3(34,65) (256 > 255)
Apr 16 17:40:28 cab kernel: bio too big device ide3(34,1) (256 > 255)
Apr 16 17:51:54 cab kernel: bio too big device ide3(34,65) (256 > 255)
Apr 16 18:02:55 cab kernel: bio too big device ide3(34,1) (256 > 255)
Apr 16 18:27:42 cab kernel: bio too big device ide3(34,65) (256 > 255)
Apr 16 18:32:09 cab kernel: bio too big device ide3(34,65) (256 > 255)
Apr 16 18:39:12 cab kernel: bio too big device ide3(34,1) (256 > 255)
Apr 16 18:49:54 cab kernel: bio too big device ide3(34,1) (256 > 255)
Apr 16 18:57:49 cab kernel: bio too big device ide3(34,65) (256 > 255)

im using kernel 2.5.65

hdg: WDC WD1200JB-00DUA0, ATA DISK drive  
hdg: host protected area => 1
hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63,       
UDMA(100)

hdh: WDC WD1200JB-75CRA0, ATA DISK drive
hdh: host protected area => 1
hdh: setmax LBA 234441648, native  234375000
hdh: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=232514/16/63,       
UDMA(100)

cab:/usr/src/linux# cat /var/log/dmesg |grep ide3
    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:pio, hdh:pio
ide3 at 0xb000-0xb007,0xb402 on irq 10

its a raid

cab:/usr/src/linux# mdadm -D /dev/md1
/dev/md1:
        Version : 00.90.01
  Creation Time : Sat Mar 22 14:49:14 2003
     Raid Level : raid0
     Array Size : 234405120 (223.55 GiB 240.03 GB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 1
    Persistence : Superblock is persistent

    Update Time : Wed Apr  9 10:01:34 2003
          State : clean, no-errors
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0

     Chunk Size : 128K

    Number   Major   Minor   RaidDevice State
       0      34        1        0      active sync   /dev/hdg1
       1      34       65        1      active sync   /dev/hdh1
           UUID : 7306e352:f30ad89d:cc501073:4102f241
         Events : 0.6

cab:/usr/src/linux# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5]
md1 : active raid0 hdh1[1] hdg1[0]
      234405120 blocks 128k chunks

what can i do ?

Anders Larsson
------- End of Forwarded Message -------

Anders Larsson
------- End of Forwarded Message -------


Anders Larsson
