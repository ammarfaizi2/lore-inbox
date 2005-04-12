Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262984AbVDLUty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbVDLUty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVDLUrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:47:12 -0400
Received: from smtp04.auna.com ([62.81.186.14]:7151 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S262155AbVDLUpl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:45:41 -0400
Date: Tue, 12 Apr 2005 20:45:25 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: What does 'WrongLevel' mean in RAID0 ?
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.3.0
Message-Id: <1113338725l.7969l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have a RAID0 setup on top of three IDE drives.
mdadm monitor sends me mesages with:

DeviceDisappeared
/dev/md0
Wrong-Level

The RAID seems to be working well. Any pointer on what does this mean ?

PD: I know it is a bit strange raid, see:

annwn:~# cat /proc/partitions
major minor  #blocks  name

   3     0  245117376 hda
   3     1  245111706 hda1
  22     0  117220824 hdc
  22     1  117218241 hdc1
  22    64  117220824 hdd
  22    65  117218241 hdd1

annwn:~# mdadm -D /dev/md0
/dev/md0:
        Version : 00.90.01
  Creation Time : Mon Sep 13 17:57:08 2004
     Raid Level : raid0
     Array Size : 479547968 (457.33 GiB 491.06 GB)
   Raid Devices : 3
  Total Devices : 3
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Mon Sep 13 17:57:08 2004
          State : clean
 Active Devices : 3
Working Devices : 3
 Failed Devices : 0
  Spare Devices : 0

     Chunk Size : 64K

           UUID : c7c5ec26:ae5a99f9:49fec7a1:7e0dcc69
         Events : 0.12

    Number   Major   Minor   RaidDevice State
       0       3        1        0      active sync   /dev/hda1
       1      22        1        1      active sync   /dev/hdc1
       2      22       65        2      active sync   /dev/hdd1


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Limited Edition 2005) for i586
Linux 2.6.11-jam14 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-7mdk)) #3


