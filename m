Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318933AbSHEXh2>; Mon, 5 Aug 2002 19:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318935AbSHEXh2>; Mon, 5 Aug 2002 19:37:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:42210 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318933AbSHEXh1>;
	Mon, 5 Aug 2002 19:37:27 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200208052340.g75NesD13179@eng2.beaverton.ibm.com>
Subject: /proc/partitions problem in 2.5.30 ?
To: linux-kernel@vger.kernel.org
Date: Mon, 5 Aug 2002 16:40:54 -0700 (PDT)
Cc: pbadari@us.ibm.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I am having problems with /proc/partitions NOT being correct for 2.5.30.
It does not seem to show the correct number of blocks. Any ideas on
how to fix this ? 2.5.29 seems to work fine.

# sfdisk -l /dev/sda

Disk /dev/sda: 2212 cylinders, 255 heads, 63 sectors/track
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls   #blocks   Id  System
/dev/sda1   *      0+      5       6-    48163+  83  Linux
/dev/sda2          6    1256    1251  10048657+  83  Linux
/dev/sda3       1257    1510     254   2040255   82  Linux swap
/dev/sda4       1511    2211     701   5630782+   f  Win95 Ext'd (LBA)
/dev/sda5       1511+   2129     619-  4972086   83  Linux
/dev/sda6       2130+   2178      49-   393561   83  Linux
/dev/sda7       2179+   2211      33-   265041   83  Linux

# grep sda /proc/partitions
   8     0   71096640 sda
   8     1     192654 sda1
   8     2   40194630 sda2
   8     3    8161020 sda3
   8     4          4 sda4
   8     5   19888344 sda5
   8     6    1574244 sda6
   8     7    1060164 sda7

As you can see, #blocks does not seem to match.


Thanks,
Badari

