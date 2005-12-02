Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVLBIjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVLBIjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 03:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVLBIja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 03:39:30 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:36794 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932147AbVLBIja convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 03:39:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=alYGiH1gnVko+FPFpTaFY3FGLEJxWjBLb8YdFZdA8cEsESqaIPoGN/P5LIOkKX/Zw9TuA/QseFA0LGZF05gD6AXKwVS5Op7JKU1QwxUnX7vlaNGDiRVZ8/Kk7VAxy38TEYT7fyoya7HCJl7MAlnAayRkJFGu0FqvhMT1BG1q1Zo=
Message-ID: <ee0ae26a0512020039k1a28da61y@mail.gmail.com>
Date: Fri, 2 Dec 2005 17:39:21 +0900
From: Yanggun <yang.geum.seok@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14 + SATAII150 TX2Plus does not recognize
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i am currently using linux kernel version 2.6.14 on x86 with Promise
SATAII150 TX2Plus(250G SATA HDD Disk x 2).

But, SATA HDD disk does not become. program execute result of "fdisk
/dev/sda" is  "Unable to read /dev/sda".

Work well in linux kernel version 2.6.13.2.

Do not act below since change as result that do debugging.
       "[SCSI] use scatter lists for all block pc requests and
simplify hw handlers"
       -  http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=392160335c798bbe94ab3aae6ea0c85d32b81bbc

What should I do?

Test Enviroment
--------------
Kernel version: 2.6.14
SATA Controller: Promise SATAII150 TX2Plus
SATA HDD: Western Digital 250G x 2
SATA Driver: http://www.promise.com/support/download/download2_eng.asp?productID=126&category=all&os=100#

Log
----------------
Nov 24 18:08:27 sentry24 kernel: ulsata2:[info] Drive 1/0: WDC
WD2500JS-22MHB0    488397167s 250059MB  UDMA6
Nov 24 18:08:27 sentry24 kernel: ulsata2:[info] Drive 3/0: WDC
WD2500JS-22MHB0    488397167s 250059MB  UDMA6
Nov 24 18:08:27 sentry24 kernel: scsi0 : ulsata2
Nov 24 18:08:27 sentry24 kernel:   Vendor:           Model:           
       Rev:
Nov 24 18:08:27 sentry24 kernel:   Type:   Direct-Access              
       ANSI SCSI revision: 00
Nov 24 18:08:27 sentry24 kernel: sda : sector size 0 reported, assuming 512.
Nov 24 18:08:27 sentry24 kernel: SCSI device sda: 1 512-byte hdwr sectors (0 MB)
Nov 24 18:08:27 sentry24 kernel: sda: asking for cache data failed
Nov 24 18:08:27 sentry24 kernel: sda: assuming drive cache: write through
Nov 24 18:08:27 sentry24 kernel: sda : sector size 0 reported, assuming 512.
Nov 24 18:08:27 sentry24 kernel: SCSI device sda: 1 512-byte hdwr sectors (0 MB)
Nov 24 18:08:27 sentry24 kernel: sda: asking for cache data failed
Nov 24 18:08:27 sentry24 kernel: sda: assuming drive cache: write through
Nov 24 18:08:27 sentry24 kernel:  sda: sda1
Nov 24 18:08:27 sentry24 kernel: sd 0:0:0:0: Attached scsi disk sda
Nov 24 18:08:27 sentry24 kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Nov 24 18:08:27 sentry24 kernel:   Vendor:           Model:           
       Rev:
Nov 24 18:08:27 sentry24 kernel:   Type:   Direct-Access              
       ANSI SCSI revision: 00
Nov 24 18:08:27 sentry24 kernel: sdb : sector size 0 reported, assuming 512.
Nov 24 18:08:27 sentry24 kernel: SCSI device sdb: 1 512-byte hdwr sectors (0 MB)
Nov 24 18:08:27 sentry24 kernel: sdb: asking for cache data failed
Nov 24 18:08:27 sentry24 kernel: sdb: assuming drive cache: write through
Nov 24 18:08:27 sentry24 kernel: sdb : sector size 0 reported, assuming 512.
Nov 24 18:08:27 sentry24 kernel: SCSI device sdb: 1 512-byte hdwr sectors (0 MB)
Nov 24 18:08:27 sentry24 kernel: sdb: asking for cache data failed
Nov 24 18:08:27 sentry24 kernel: sdb: assuming drive cache: write through
Nov 24 18:08:27 sentry24 kernel:  sdb: sdb1
Nov 24 18:08:27 sentry24 kernel: sd 0:0:2:0: Attached scsi disk sdb
Nov 24 18:08:27 sentry24 kernel: sd 0:0:2:0: Attached scsi generic sg1 type 0


[root@test root]# lsmod
Module                  Size  Used by
snd_pcm_oss            48288  0
snd_pcm                80520  1 snd_pcm_oss
snd_timer              21508  1 snd_pcm
snd_page_alloc          8456  1 snd_pcm
snd_mixer_oss          17024  1 snd_pcm_oss
lp                      9412  0
parport                31816  1 lp
snd                    47076  4 snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore               7776  1 snd
sr_mod                 15268  0
sg                     34208  0
i810                   20480  0
i830                   24832  0
odcap                  21488  2
button                  5008  0
sbp2                   21252  0
ohci1394               31540  0
ieee1394               87224  2 sbp2,ohci1394
pl2303                 18948  0
usbserial              27368  1 pl2303
usb_storage            53696  0
uhci_hcd               30096  0
ide_scsi               14468  0
raid1                  17920  0
md_mod                 59088  1 raid1
ehci_hcd               29960  0
usbcore               106880  6 pl2303,usbserial,usb_storage,uhci_hcd,ehci_hcd
e1000                  99892  0
sd_mod                 15888  0
ulsata2               132060  0
scsi_mod              122984  7
sr_mod,sg,sbp2,usb_storage,ide_scsi,sd_mod,ulsata2



[root@sentry24 root]# sfdisk -l

Disk /dev/hda: 1007 cylinders, 16 heads, 63 sectors/track
Units = cylinders of 516096 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/hda1   *      0+   1006    1007-    507496+  83  Linux
/dev/hda2          0       -       0          0    0  Empty
/dev/hda3          0       -       0          0    0  Empty
/dev/hda4          0       -       0          0    0  Empty

Disk /dev/sda: 0 cylinders, 64 heads, 32 sectors/track
Warning: The partition table looks like it was made
  for C/H/S=*/255/63 (instead of 0/64/32).
For this listing I'll assume that geometry.
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/sda1          0+  30400   30401- 244196001   83  Linux
/dev/sda2          0       -       0          0    0  Empty
/dev/sda3          0       -       0          0    0  Empty
/dev/sda4          0       -       0          0    0  Empty

Disk /dev/sdb: 0 cylinders, 64 heads, 32 sectors/track
Warning: The partition table looks like it was made
  for C/H/S=*/255/63 (instead of 0/64/32).
For this listing I'll assume that geometry.
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/sdb1          0+  30400   30401- 244196001   83  Linux
/dev/sdb2          0       -       0          0    0  Empty
/dev/sdb3          0       -       0          0    0  Empty
/dev/sdb4          0       -       0          0    0  Empty
[root@sentry24 root]#



[root@sentry24 root]# sg_map -i -x
/dev/sg0  0 0 0 0  0  /dev/sda    WDC WD2500JS-00M
/dev/sg1  0 0 2 0  0  /dev/sdb    WDC WD2500JS-00M
[root@sentry24 root]#



[root@sentry24 root]# fdisk -l /dev/sda
[root@sentry24 root]# fdisk /dev/sda

Unable to read /dev/sda
[root@sentry24 root]#

[root@sentry24 root]# !parted
parted --script /dev/sda mklabel msdos
Error: Can't have a partition outside the disk!
Error: Operation not permitted during read on /dev/sda
Error: Operation not permitted during write on /dev/sda
