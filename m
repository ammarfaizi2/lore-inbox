Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUBFVtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266723AbUBFVtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:49:23 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:61695 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266689AbUBFVtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:49:15 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] 2.4.25-rc1: Shutdown kernel on zone-alignment failure
Date: Sat, 7 Feb 2004 05:48:12 +0800
User-Agent: KMail/1.5.4
Cc: axboe@suse.de, "Randy.Dunlap" <rddunlap@osdl.org>, riel@redhat.com,
       linux-kernel@vger.kernel.org
References: <200402070534.46123.mhf@linuxmail.org>
In-Reply-To: <200402070534.46123.mhf@linuxmail.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402070548.12110.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an example.

Linux version 2.4.25-rc1-mhf176 (root@mhfl4) (gcc version 2.95.3 20010315 (release)) #17 Sat Feb 7 04:53:09 HKT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
 BIOS-e820: 000000001eff0000 - 000000001eff3000 (ACPI NVS)
 BIOS-e820: 000000001eff3000 - 000000001f000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
300MB HIGHMEM available.
195MB LOWMEM available.
On node 0 totalpages: 126960, zones aligned at 0x200000
zone(0): 4096 pages, physical start address at 0x0
zone(1): 46064 pages, physical start address at 0x1000000
zone(2): 76800 pages, physical start address at 0xc3f0000
zone(2): FATAL ERROR: wrong zone alignment 0x1f0000 - will force kernel BUG
Kernel command line: vga=0xf07 root=/dev/hda4 resume2=swap:/dev/hda1 console=tty0 console=ttyS0,115200n8r devfs=nomount nousb acpi=off highmem=300m 4
Initializing CPU#0
Detected 2399.787 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 498696k/507840k available (1589k kernel code, 8756k reserved, 676k data, 120k init, 307200k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
kernel BUG at init/main.c:427!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c033a682>]    Not tainted
EFLAGS: 00010202
eax: c15da360   ebx: 00010809   ecx: c037e710   edx: c02f5b08
esi: 00099800   edi: c0105000   ebp: 0008e000   esp: c0339ff8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0339000)
Stack: c03598c0 c0100191
Call Trace:

Code: 0f 0b ab 01 1b d8 28 c0 e8 91 90 00 00 e8 c0 fa ff ff 68 40
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing




