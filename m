Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbTCORZY>; Sat, 15 Mar 2003 12:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261359AbTCORZY>; Sat, 15 Mar 2003 12:25:24 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:16652 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261358AbTCORZX>; Sat, 15 Mar 2003 12:25:23 -0500
Message-ID: <3E736505.2000106@aitel.hist.no>
Date: Sat, 15 Mar 2003 18:38:13 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm7 - dies on smp with raid
References: <20030315011758.7098b006.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm7 crashed where mm2 works.
The machine is a dual celeron with two scsi disks with
some raid-1 & raid-0 partitions.

deadline or anicipatory scheduler does not make a difference.
It dies anyway, attempting to kill init.

Here's what I managed to  write down before the 30 second reboot
kicked in:

EIP is at md_wakeup_thread

stack:
do_md_run
autorun_array
autorun_devices
autostart_arrays
md_ioctl
dentry_open
kmem_cache_free
blkdev_ioctl
sys_ioctl
init
init

This happened during the boot process. The kernel is compiled
with gcc 2.95.4 from debian testing. The machine uses devfs

Helge Hafting

