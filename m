Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbVJMNRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbVJMNRT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 09:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbVJMNRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 09:17:19 -0400
Received: from bgs.hu ([195.228.254.245]:44714 "HELO mail.bgs.hu")
	by vger.kernel.org with SMTP id S1751525AbVJMNRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 09:17:19 -0400
Message-ID: <434E5E2B.8030206@bgs.hu>
Date: Thu, 13 Oct 2005 15:16:27 +0200
From: Bgs <bgs@bgs.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920 MultiZilla/1.8.1.0a
X-Accept-Language: en-us, en, hu, it, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: strange ramdrive behaviour
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi all,

  I have a ramdrive set up at boot time. The script is very simple, sets 
up the filesystem and mounts the ramdrive. The interesting part is that 
at first it doesn't work, but run a second time it is fine.

At first the mkfs part is ok, but mount reports no fs.
The second time, mkfs part is ok again and mount works as well.

I sent to syslog the output of the first run:

Oct 13 02:26:28 wh-db02 ramdisk: Guessing about desired format.. Kernel 
2.6.13.4 is running.
Oct 13 02:26:28 wh-db02 ramdisk: Format 3.6 with standard journal
Oct 13 02:26:28 wh-db02 ramdisk: Count of blocks on the device: 16368
Oct 13 02:26:28 wh-db02 ramdisk: Number of blocks consumed by mkreiserfs 
formatting process: 8212
Oct 13 02:26:28 wh-db02 ramdisk: Blocksize: 4096
Oct 13 02:26:28 wh-db02 ramdisk: Hash function used to sort names: "r5"
Oct 13 02:26:28 wh-db02 ramdisk: Journal Size 8193 blocks (first block 18)
Oct 13 02:26:28 wh-db02 ramdisk: Journal Max transaction length 1024
Oct 13 02:26:28 wh-db02 ramdisk: inode generation number: 0
Oct 13 02:26:28 wh-db02 ramdisk: UUID: 2a989bfb-8380-4c28-b3d9-db57fc0049ec
Oct 13 02:26:28 wh-db02 ramdisk: Initializing journal - 
0%....20%....40%....60%....80%....100%
Oct 13 02:26:28 wh-db02 ramdisk: Syncing..ok
Oct 13 02:26:28 wh-db02 ramdisk:
Oct 13 02:26:28 wh-db02 ramdisk: Tell your friends to use a kernel based 
on 2.4.18 or later, and especially not a
Oct 13 02:26:28 wh-db02 ramdisk: kernel based on 2.4.9, when you use 
reiserFS. Have fun.
Oct 13 02:26:28 wh-db02 ramdisk:
Oct 13 02:26:28 wh-db02 ramdisk: ReiserFS is successfully created on 
/dev/ram0.
Oct 13 02:26:28 wh-db02 kernel: ReiserFS: ram0: warning: sh-2011: 
read_super_block: can't find a reiserfs filesystem on (dev ram0, block 
16, size 4096)
Oct 13 02:26:28 wh-db02 kernel:
Oct 13 02:26:28 wh-db02 kernel: ReiserFS: ram0: warning: sh-2021: 
reiserfs_fill_super: can not find reiserfs on ram0

Any ideas about the hysteresis? :)

Bye
Bgs

