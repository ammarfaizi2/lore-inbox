Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752007AbWISOp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbWISOp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWISOp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:45:59 -0400
Received: from dvhart.com ([64.146.134.43]:3558 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1752007AbWISOp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:45:58 -0400
Message-ID: <45100272.505@mbligh.org>
Date: Tue, 19 Sep 2006 07:45:06 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-rc7-mm1
References: <20060919012848.4482666d.akpm@osdl.org>
In-Reply-To: <20060919012848.4482666d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - It took maybe ten hours solid work to get this dogpile vaguely
>   compiling and limping to a login prompt on x86, x86_64 and powerpc. 
>   I guess it's worth briefly testing if you're keen.

PPC64 blades shit themselves in a strange way. Possibly the udev
breakage you mentioned? Hard to tell really if people are going to
go around breaking userspace compatibility ;-(

http://test.kernel.org/abat/48127/debug/console.log

rpa_vscsi: SPR_VERSION: 16.a
scsi0 : IBM POWER Virtual SCSI Adapter 1.5.8
ibmvscsi: partner initialization complete
ibmvscsic: sent SRP login
ibmvscsi: SRP_LOGIN succeeded
ibmvscsi: host srp version: 16.a, host partition gekko-vios (4), OS 3, 
max io 262144
scsi 0:0:1:0: Direct-Access     AIX      VDASD                 PQ: 0 ANSI: 3
SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
sda: Write Protect is off
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
sda: Write Protect is off
sda: cache data unavailable
sda: assuming drive cache: write through
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
sd 0:0:1:0: Attached scsi disk sda
creating device nodes .[: [0-9]*: bad number
0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
[: [0-9]*: bad number
0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
[: [0-9]*: bad number
0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
[: [0-9]*: bad number
0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
[: [0-9]*: bad number
0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
[: [0-9]*: bad number
0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
[: [0-9]*: bad number
0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
[: [0-9]*: bad number
0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
[: [0-9]*: bad number
0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
..
mount  -o ro /dev/sda2
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
reiserfs: using flush barriers
ReiserFS: sda2: journal params: device sda2, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
looking for init ...
found /sbin/init
/init: cannot open .//dev//console: no such file
Kernel panic - not syncing: Attempted to kill init!
  <0>Rebooting in 180 seconds..-- 0:conmux-control -- time-stamp -- 
Sep/19/06  4:18:52 --
(bot:conmon-payload) disconnected
