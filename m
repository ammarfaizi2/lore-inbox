Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262822AbRFMKQB>; Wed, 13 Jun 2001 06:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262835AbRFMKPv>; Wed, 13 Jun 2001 06:15:51 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:29458 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S262822AbRFMKPl>;
	Wed, 13 Jun 2001 06:15:41 -0400
Date: Wed, 13 Jun 2001 11:57:05 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: DVD RAM partitions
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B2738F1.E12496B4@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Somebody is trying to use a DVD RAM in linux,
using a DVD ROM drive ( that can read DVD RAM ).

Here are some info :

zen:/usr/src/linux# fdisk -l /dev/hdd

Disk /dev/hdd: 1 heads, 4875840 sectors, 1 cylinders
Units = cylinders of 681536 * 512 bytes

   Device Boot   Start      End   Blocks   Id  System
/dev/hdd1            1        2   609478+   7  OS/2 HPFS
Partition 1 has different physical/logical endings:
     phys=(595, 12, 16) logical=(0, 0, 1218960)
Partition 1 does not end on cylinder boundary:
     phys=(595, 12, 16) should be (595, 0, 4875840)

zen:/home/terminus# cat /proc/partitions 
major minor  #blocks  name

   3     0   19925880 hda
   3     1    9960268 hda1
   3     2    9831780 hda2
   3     3     128520 hda3
  22    64    2437920 hdd


The problem is that the kernel did not recognize
and "install" the hdd1 partition.

Any suggestions ?

sfdisk -R ?
addpart ?

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
