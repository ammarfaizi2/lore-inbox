Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUDPSDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUDPSDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:03:52 -0400
Received: from nsmtp.pacific.net.th ([203.121.130.117]:56481 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263584AbUDPSDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:03:48 -0400
Date: Sat, 17 Apr 2004 02:02:50 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Subject: 2.4.26 intermittent kernel bug on boot.
Cc: "kernel list" <linux-kernel@vger.kernel.org>,
       "Nigel Cunningham" <ncunningham@users.sourceforge.net>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr6j9q0d54evsfm@smtp.pacific.net.th>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.26 patched with swsusp2.

P4, SIS5513 chipset about the 7th boot of 2.4.26.

Linux version 2.4.26-mhf197 (root@mhfl4) (gcc version 2.95.3 20010315 (release)) #3 Fri Apr 16 22:23:11 HKT 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001f7f0000 (usable)
  BIOS-e820: 000000001f7f0000 - 000000001f7f3000 (ACPI NVS)
  BIOS-e820: 000000001f7f3000 - 000000001f800000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
503MB LOWMEM available.
On node 0 totalpages: 129008
zone(0): 4096 pages.
zone(1): 124912 pages.
zone(2): 0 pages.
Kernel command line: vga=0xf07 root=/dev/hda4 resume2=swap:/dev/hda1 console=tty0 console=ttyS0,115200n8r  devfs=nomount nousb acpi=off
Initializing CPU#0
Detected 2399.777 MHz processor.
Console: colour VGA+ 80x60
kernel BUG at slab.c:1238!
invalid operand: 0000

CPU:    0
EIP:    1010:[<c013bf39>]    Not tainted
EFLAGS: 00010002
EIP is at kmem_cache_alloc+0x31/0xdc [kernel]
eax: 00000000   ebx: 00000008   ecx: 00000000   edx: 00000001
esi: 00000000   edi: 0000000b   ebp: 00000020   esp: c0407f10
ds: 1018   es: 1018   ss: 1018
Process swapper (pid: 0, stackpage=c0407000)
Stack: 0000000b 00000001 0000000b c040656c c0121f8c 00000000 00000020 c0406000
        0000000b 0000000b 00000000 c012206d 0000000b 00000001 c040656c 00000282
        0000000b c0406000 c012211c 0000000b 00000001 c0406000 00000286 c0406000
Call Trace:
  [<c0121f8c>] send_signal+0x2c/0xf0 [kernel]
  [<c012206d>] deliver_signal+0x1d/0x54 [kernel]
  [<c012211c>] send_sig_info+0x78/0x88 [kernel]
  [<c01221a9>] force_sig_info+0x7d/0x88 [kernel]
  [<c010a5e4>] do_double_fault+0x0/0x64 [kernel]
  [<c01223d5>] force_sig+0x11/0x18 [kernel]
  [<c010a619>] do_double_fault+0x35/0x64 [kernel]
  [<c0109dc4>] error_code+0x34/0x40 [kernel]

Code: 0f 0b d6 04 e0 b7 2b c0 8d 5e 08 9c 5f fa 8b 4e 08 39 d9 75

Entering kdb (current=0xc0406000, pid 0) Oops: invalid operand
due to oops @ 0xc013bf39
eax = 0x00000000 ebx = 0x00000008 ecx = 0x00000000 edx = 0x00000001
esi = 0x00000000 edi = 0x0000000b esp = 0xc0407f10 eip = 0xc013bf39
ebp = 0x00000020 xss = 0x00001018 xcs = 0x00001010 eflags = 0x00010002
xds = 0x00001018 xes = 0x00001018 origeax = 0xffffffff &regs = 0xc0407edc
kdb>

Board did 50K+ boots testing swsusp with 2.4.2[012345]...

It's still sitting in kdb, if you want me lookup something let me know.

