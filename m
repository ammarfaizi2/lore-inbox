Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbTFEMWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 08:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264653AbTFEMWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 08:22:42 -0400
Received: from services.erkkila.org ([24.97.94.217]:22150 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id S264652AbTFEMWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 08:22:39 -0400
Message-ID: <3EDF3904.3010808@erkkila.org>
Date: Thu, 05 Jun 2003 12:35:16 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030520
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_services-23350-1054816570-0001-2"
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, neilb@cse.unsw.edu.au
Subject: Re: 2.5.70-mm5 new oops that wasn't in 2.5.70-mm4
References: <20030605021231.2b3ebc59.akpm@digeo.com> <3EDF302B.70601@aitel.hist.no>
In-Reply-To: <3EDF302B.70601@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_services-23350-1054816570-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This same oops exists in a normal kernel from
bitkeeper with a patch (raid 0 though..) from
Neil Brown applied.(I think it was the same one in -mm).
I am also running / as a raid-1 partition.

-pee



--=_services-23350-1054816570-0001-2
Content-Type: text/plain; name="ksym.raid1"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksym.raid1"

ksymoops 2.4.9 on i686 2.5.69.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.69/ (default)
     -m System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernbel BUG at drivers/md/raid1.c:145!
invalid operand: 000 [#1]
CPU:   0
EIP:   0060:[<c025d7df>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: 00000000 ebx: 00000001 exc: 00000010 edx: f7ffb800
Warning (Oops_set_regs): garbage 'exc: 00000010 edx: f7ffb800' at end of register line ignored
esi: f7d5ddb4 edi: 00000003 ebp: c036bdf8 esp: c036bde8
ds: 007 es: 007b ss:0068
Stack: f7fcf900 f7d80480 00000046 f7d5dd80 c036be18 c025d8fc f7d80480
f7d4dd80
      00000000 f7d5dd80 00000001 0000000c c036be18 c025da43 f7d5dd80
f7f9f880
      00000003 00000000 00000001 00000004 00000000 c18f5ch4 f7d6fce0
0000000c
Call Trace:
[<c025d8fc>] raid_end_bio_io+0x55/0x92
[<c025da43>] raid1_end_request+0x10a/0x196
[<c013042c>] mempool_free+0x32/0x65
[<c014a420>] bio_endio+0x55/0x7a
[<c01ef559>] __end_that_request_first+0x1f1/0x20d
[<c023c0a4>] ide_end_request+0x58/0x118
[<c024f3cb>] ide_dma_intr+0x9d/0xba
[<c023d43f>] ide_intr+0xb9/0x12e
[<c024f34e>] ide_dma_intr+0x0/0xba
[<c010c279>] handle_IRQ_event+0x3c/0xfd
[<c010c48f>] do_IRQ+0x80/0xd6
[<c0108be9>] default_idle+0x0/0x2c
[<c0108be9>] default_idle+0x0/0x2c
[<c010acd4>] common_interrupt+0x18/0x20
[<c0108be9>] default_idle+0x0/0x2c
[<c0108be9>] default_idle+0x0/0x2c
[<c0108c10>] default_idle+0x27/0x2c
[<c0108c81>] cpu_idle+0x31/0x3a
[<c0105000>] _stext+0x0/0x2a
[<c036c678>] start_kernel+0x152/0x177
[<c036c401>] unknown_bootoption+0x0/0xfa
Code: 0f 0b 91 00 85 96 2d c0 89 14 24 e8 7e c2 ee ff c7 06 00 00


>>EIP; c025d7df <put_all_bios+59/85>   <=====

>>esi; f7d5ddb4 <_end+3797c660/3fc1c8ac>
>>ebp; c036bdf8 <init_thread_union+1df8/2000>
>>esp; c036bde8 <init_thread_union+1de8/2000>

Trace; c025d8fc <raid_end_bio_io+55/92>
Trace; c025da43 <raid1_end_request+10a/196>
Trace; c013042c <mempool_free+32/65>
Trace; c014a420 <bio_endio+55/7a>
Trace; c01ef559 <__end_that_request_first+1f1/20d>
Trace; c023c0a4 <ide_end_request+58/118>
Trace; c024f3cb <ide_dma_intr+9d/ba>
Trace; c023d43f <ide_intr+c3/12e>
Trace; c024f34e <ide_dma_intr+20/ba>
Trace; c010c279 <handle_IRQ_event+3c/fd>
Trace; c010c48f <do_IRQ+80/d6>
Trace; c0108be9 <default_idle+0/2c>
Trace; c0108be9 <default_idle+0/2c>
Trace; c010acd4 <common_interrupt+18/20>
Trace; c0108be9 <default_idle+0/2c>
Trace; c0108be9 <default_idle+0/2c>
Trace; c0108c10 <default_idle+27/2c>
Trace; c0108c81 <cpu_idle+31/3a>
Trace; c0105000 <_stext+0/0>
Trace; c036c678 <start_kernel+152/177>
Trace; c036c401 <unknown_bootoption+0/fa>

Code;  c025d7df <put_all_bios+59/85>
00000000 <_EIP>:
Code;  c025d7df <put_all_bios+59/85>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c025d7e1 <put_all_bios+5b/85>
   2:   91                        xchg   %eax,%ecx
Code;  c025d7e2 <put_all_bios+5c/85>
   3:   00 85 96 2d c0 89         add    %al,0x89c02d96(%ebp)
Code;  c025d7e8 <put_all_bios+62/85>
   9:   14 24                     adc    $0x24,%al
Code;  c025d7ea <put_all_bios+64/85>
   b:   e8 7e c2 ee ff            call   ffeec28e <_EIP+0xffeec28e>
Code;  c025d7ef <put_all_bios+69/85>
  10:   c7 06 00 00 00 00         movl   $0x0,(%esi)

<0>Kernel panic: Fatal exception in interrupt
> unable to handle kernel paging request at 6b6b6b97 (poison?)

1 warning and 1 error issued.  Results may not be reliable.

--=_services-23350-1054816570-0001-2--
