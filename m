Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUBRE3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUBRE3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:29:02 -0500
Received: from agminet03.oracle.com ([141.146.126.230]:49294 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S263595AbUBRE2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:28:55 -0500
Message-ID: <4032EA00.6060104@iitbombay.org>
Date: Wed, 18 Feb 2004 09:58:48 +0530
From: Niraj Kumar <niraj17@iitbombay.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nForce2  with 2.6.3-rc3-mm1 : oops when X started
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have am ASUS A7N8X-VM with Athlon 2000+ .
I got this oops just after a few seconds after starting X . The display 
freezes although mouse continue to move . I was able to press 
<ctrl-alt-backspace> to come back to text mode.

I have heard that 2.6.3-rc3-mm1 has got some fix for nForce2/AMD
hangup problems . Is that right ?



Linux version 2.6.3-rc3-mm1 (root@localhost.localdomain) (gcc version 
3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #8 Tue Feb 17 22:16:38 IST 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001dfd0000 (usable)
  BIOS-e820: 000000001dfd0000 - 000000001dfdf000 (ACPI data)
  BIOS-e820: 000000001dfdf000 - 000000001e000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
479MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 122832
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 118736 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Built 1 zonelists
current: c03a2a60
current->thread_info: c0422000
Initializing CPU#0
Kernel command line: ro root=/dev/hdb2 hdc=ide-scsi  noapic nolapic acpi=off
ide_setup: hdc=ide-scsi
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1664.095 MHz processor.

...............
...............<several lines removed>
.................
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Unable to handle kernel paging request at virtual address 19cd21b9
  printing eip:
c015dd7a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c015dd7a>]    Not tainted VLI
EFLAGS: 00010246
EIP is at pipe_poll+0x3a/0x80       ddd665c0 d9885f5c d9885f60 00000043 
c01641fa 0000000a ddd665c8 d9885f5c
        d9885f60 d9884000 d9884000 00000000 00000000 00000000 ddd665c0 
081bc698
Call Trace:
  [<c0164189>] do_pollfd+0x89/0x90
  [<c01641fa>] do_poll+0x6a/0xd0
  [<c01643f4>] sys_poll+0x194/0x2a0
  [<c0163770>] __pollwait+0x0/0xd0
  [<c033f1c2>] sysenter_past_esp+0x43/0x65
 

Code: 8b 74 24 18 85 d2 8b 46 08 8b 58 08 8b 8b 24 01 00 00 74 17 85 c9 
74 13 89 4c 24 04 89 54 24 08 89 34 24 ff 12 8b 8b 24 01 00 00 <8b> 41 
0c bb 41 00 00 00 85 c0 b8 04 01 00 00 0f 44 d8 8b 41 18
  mm/memory.c:403: bad pmd 00a80861.
mm/memory.c:102: bad pmd 01ef0193.
mm/memory.c:102: bad pmd 7bcf0a00.
mm/memory.c:102: bad pmd f7beffff.
mm/memory.c:102: bad pmd f79ef79e.
mm/memory.c:102: bad pmd f79ef79e.
mm/memory.c:102: bad pmd ef7df79e.
mm/memory.c:102: bad pmd ef7def7d.

eax: d8bfd300   ebx: d99a5540   ecx: 19cd21ad   edx: 00000000
esi: d8b7bb40   edi: d8b7bb40   ebp: 00000000   esp: d9885f10
ds: 007b   es: 007b   ss: 0068
Process nautilus (pid: 1435, threadinfo=d9884000 task=d98b9410)
Stack: fffeb520 d81eb800 00100100 00000145 ddd665c8 c0164189 d8b7bb40 
00000000


Niraj

