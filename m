Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbSLTWti>; Fri, 20 Dec 2002 17:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266335AbSLTWtf>; Fri, 20 Dec 2002 17:49:35 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:31154 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S266323AbSLTWtb>; Fri, 20 Dec 2002 17:49:31 -0500
Date: Fri, 20 Dec 2002 23:57:33 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-aa and LARGE Squid process -> SIGSEGV
Message-ID: <20021220225733.GE31070@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021220114837.GC13591@charite.de> <20021220223754.GA10139@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220223754.GA10139@werewolf.able.es>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* J.A. Magallon <jamagallon@able.es>:

> Normal. You are running OOM. Look at what you do:

But that manifests itself in a segfault? The kernel never logs an OOM
in the logs.

> Ah, with 2Gb of ram you will need to compile with 3Gb userspace,
> to let a one only process allocate a chunk of mem that does not fit
> into core memory. Or, easier, run several instances...

Right now we're running a Xeon with 2GB - from the menuconfig:

      (4GB) High Memory Support

This was based on the help in the kernel config:

"If the machine has between 1 and 4 Gigabytes physical RAM, then
answer "4GB" here."

      (3.5GB) User address space size
      [*] HIGHMEM I/O support

dmesg says:

Linux version 2.4.20aa1 (root@spidergirl) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 Thu Dec 19 14:35:35 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fffec00 (ACPI data)
 BIOS-e820: 000000007fffec00 - 000000007ffff000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1663MB HIGHMEM available.
384MB LOWMEM available.
...
Calibrating delay loop... 5557.45 BogoMIPS
Memory: 2069264k/2097088k available (1659k kernel code, 27440k
reserved, 651k data, 136k init, 1703872k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Xeon(TM) CPU 2.80GHz stepping 07
...
-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
"All programmers are playwrights and all computers are lousy actors."  -Anon.

