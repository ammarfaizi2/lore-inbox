Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290063AbSAYCh7>; Thu, 24 Jan 2002 21:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290509AbSAYCht>; Thu, 24 Jan 2002 21:37:49 -0500
Received: from [216.70.178.182] ([216.70.178.182]:7042 "EHLO mail.xinetd.com")
	by vger.kernel.org with ESMTP id <S290063AbSAYChd>;
	Thu, 24 Jan 2002 21:37:33 -0500
Date: Thu, 24 Jan 2002 18:37:31 -0800 (PST)
From: Glendon Gross <gross@xinetd.com>
To: linux-kernel@vger.kernel.org
Subject: Swap problems with 2.5.2B
Message-ID: <Pine.LNX.4.21.0201241835590.5104-100000@mail.xinetd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
I've been running 2.5.2 for a couple of days, with the low-latency patch.
Is there a patch available to fix the problem with swap?  See below:

Script started on Thu Jan 24 18:35:22 2002
root@mail:~ > uname -a
Linux mail 2.5.2 #18 SMP Wed Jan 23 22:05:39 PST 2002 i686 unknown
root@mail:~ > free
             total       used       free     shared    buffers     cached
Mem:        189752     184540       5212          0      19224     100060
-/+ buffers/cache:      65256     124496
Swap:            0          0          0
root@mail:~ > fdisk /dev/hdb

The number of cylinders for this disk is set to 1247.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hdb: 255 heads, 63 sectors, 1247 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdb1             1         3     24066   83  Linux
/dev/hdb2             4        20    136552+  82  Linux swap
/dev/hdb3            21      1247   9855877+  83  Linux

Command (m for help): q

root@mail:~ > swapon /dev/hdb2
swapon: /dev/hdb2: No such file or directory
root@mail:~ > exit

Script done on Thu Jan 24 18:35:41 2002

