Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbTFQSaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTFQSaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:30:18 -0400
Received: from core1-gige-ds3.pfn.citynetwireless.net ([209.218.71.2]:20426
	"EHLO core.citynetwireless.net") by vger.kernel.org with ESMTP
	id S264786AbTFQSaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:30:11 -0400
Date: Tue, 17 Jun 2003 13:44:06 -0500
From: Bubba Parker <lkml@ro0tsiege.org>
To: linux-kernel@vger.kernel.org
Subject: Elan booting with 2.4.21 fails
Message-ID: <20030617184406.GA30200@core.citynetwireless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to boot 2.4.21 on a Soekris net4521 (AMD Elan SC520 CPU) and
get a panic "Attempted to kill the idle task". Is this a known bug, or,
how can I fix it?

This kernel also has grsecurity-1.9.10 applied.


Linux version 2.4.21-grsec (bubba@home) (gcc version
2.95.4 20011002 (Debian prerelease)) #1 Mon Jun 16 19:09:56 CDT 203
BIOS-provided physical RAM map:
BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
BIOS-e801: 0000000000100000 - 0000000004000000 (usable)
64MB LOWMEM available.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,19200n81 ro debug
No local APIC present or hardware disabled
Initializing CPU#0
Calibrating delay loop... 66.56 BogoMIPS
Memory: 61628k/65536k available (1663k kernel code, 3520k reserved,
-2020k data, 116k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor
mode... Ok.
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU:     After generic, caps: 00000001 00000000 00000000 00000000
CPU:             Common caps: 00000001 00000000 00000000 00000000
CPU: AMD 486 DX/4-WB stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01aa710>]    Not tainted
EFLAGS: 00010046
eax: 00000001   ebx: c0148000   ecx: c0148000   edx: 00000000
esi: c0149fb0   edi: c014f000   ebp: 0008e000   esp: c0149f78
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0149000)
Stack: c01abb2d 00010f00 c01a8238 00000000 c0149fb0 c014f000 0008e000
00000001
00000018 c01b0018 00000078 c01aa25e 00000010 00000206 00000000
c0148000
c01bb29a c01a8238 00000000 00010e00 00000000 00099800
c01a8221 c01a8238
Call Trace:    [<c01abb2d>] [<c01a8238>] [<c01b0018>]
[<c01aa25e>] [<c01bb29a>]
[<c01a8238>] [<c01a8221>] [<c01a8238>]

  Code: 0f 31 83 e0 1f c1 e0 02 ba 00 e0 ff ff 21 e2 33
  82 70 02 00
  <0>Kernel panic: Attempted to kill the idle task!
   In idle task - not syncing


Thanks in advance

--
Bubba Parker
lkml@ro0tsiege.org

