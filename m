Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131973AbRDAEVI>; Sat, 31 Mar 2001 23:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDAEU6>; Sat, 31 Mar 2001 23:20:58 -0500
Received: from ecstasy.ksu.ru ([193.232.252.41]:43197 "EHLO ecstasy.ksu.ru")
	by vger.kernel.org with ESMTP id <S131973AbRDAEUq>;
	Sat, 31 Mar 2001 23:20:46 -0500
X-Pass-Through: Kazan State University network
Message-ID: <3AC6AC1C.4090706@ksu.ru>
Date: Sun, 01 Apr 2001 08:18:36 +0400
From: Art Boulatov <art@ksu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10-pre5-reiserfs-3.6.18-acpi-i2c i686; en-US; 0.7) Gecko/20010203
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "device or resource busy" - why??
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

could you please help me figure out why is that happenning:

After succesfull pivot_root & chroot from initrd,
I *do* unmount /initrd, (no directories, no mapped files...),
but I can *not* free the memory:

"blockdev --flushbufs /dev/rd/0" returns "BLKFLSBUF: Device or resource 
busy".
---------------------------------------------------------------------------------------------------------------
What is keeping it busy? I got really stuck with that.


This is linux-2.4.3-pre6 SMP with devfs and blockdev from 
util-linux-2.11a and cramfs on initrd.


I have the following processes running at that moment:
---------------------
1 0 /bin/bash
2 1 [keventd]
3 1 [kswapd]
4 1 [kreclaimd]
5 1 [bdflush]
6 1 [kupdated]
137 1 [mdrecoveryd]
160 1 [kreiserfsd]
-------------------------------------

And the following modules loaded:
-------------
reiserfs
raid0
md
sd_mod
sym53c8xx
scsi_mod
-----------------

I thought I've checked everything I could, but with no luck.
Could that be a cramfs issue?

Thank you,
Art.

