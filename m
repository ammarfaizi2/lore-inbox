Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313637AbSDHQvK>; Mon, 8 Apr 2002 12:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSDHQvJ>; Mon, 8 Apr 2002 12:51:09 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:54657 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S313637AbSDHQvC>; Mon, 8 Apr 2002 12:51:02 -0400
Message-ID: <3CB1CA6E.8070204@t-online.de>
Date: Mon, 08 Apr 2002 18:50:54 +0200
From: Robert.Hannebauer@t-online.de (Robert Hannebauer)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:0.9.9) Gecko/20020313
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc (2.4.19-pre5-ac3)
Content-Type: multipart/mixed;
 boundary="------------040702000904010709050206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040702000904010709050206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've got the attached kernel BUG message while
running seti, mozilla and kghostview.

sincerely yours
   Robert

--------------040702000904010709050206
Content-Type: text/plain;
 name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops"

Apr  8 18:23:31 sonne kernel: kernel BUG at page_alloc.c:240!
Apr  8 18:23:31 sonne kernel: invalid operand: 0000
Apr  8 18:23:31 sonne kernel: CPU:    0
Apr  8 18:23:31 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:23:31 sonne kernel: EFLAGS: 00210202
Apr  8 18:23:31 sonne kernel: eax: 01000040   ebx: c10c1b88   ecx: 00001000   edx: 00003b9b
Apr  8 18:23:31 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: c77e9e54
Apr  8 18:23:31 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:23:31 sonne kernel: Process setiathome (pid: 1529, stackpage=c77e9000)
Apr  8 18:23:31 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00002b9b 00200282 c0278754 
Apr  8 18:23:31 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc c85d9348 ca54fec0 00000010 
Apr  8 18:23:31 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 ca54fec0 410d2000 
Apr  8 18:23:31 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] [handle_mm_fault+203/320] 
Apr  8 18:23:31 sonne kernel:    [do_page_fault+279/1076] [do_page_fault+0/1076] [old_mmap+237/304] [error_code+52/60] 
Apr  8 18:23:31 sonne kernel: 
Apr  8 18:23:31 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 
Apr  8 18:31:21 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:31:21 sonne kernel: invalid operand: 0000
Apr  8 18:31:21 sonne kernel: CPU:    0
Apr  8 18:31:21 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:31:21 sonne kernel: EFLAGS: 00010202
Apr  8 18:31:21 sonne kernel: eax: 01000040   ebx: c10c1b54   ecx: 00001000   edx: 00003b9a
Apr  8 18:31:21 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: c6c33e7c
Apr  8 18:31:21 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:31:21 sonne kernel: Process mozilla-bin (pid: 1535, stackpage=c6c33000)
Apr  8 18:31:21 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00002b9a 00000292 c027873c 
Apr  8 18:31:21 sonne kernel:        00000000 c02786fc c0130514 000001d2 00000000 c85d0fe8 06950065 00000003 
Apr  8 18:31:21 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 c115644c c01255ef ca54f800 bfffad2c 
Apr  8 18:31:21 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_wp_page+143/512] [handle_mm_fault+258/320] [do_page_fault+279/1076] 
Apr  8 18:31:21 sonne kernel:    [do_page_fault+0/1076] [handle_kbd_event+249/368] [keyboard_interrupt+15/32] [handle_IRQ_event+47/96] [end_8259A_irq+24/32] [do_IRQ+140/176] 
Apr  8 18:31:21 sonne kernel:    [error_code+52/60] 
Apr  8 18:31:21 sonne kernel: 
Apr  8 18:31:21 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 
Apr  8 18:31:21 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:31:21 sonne kernel: invalid operand: 0000
Apr  8 18:31:21 sonne kernel: CPU:    0
Apr  8 18:31:21 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:31:21 sonne kernel: EFLAGS: 00010202
Apr  8 18:31:21 sonne kernel: eax: 01000040   ebx: c10c1b20   ecx: 00001000   edx: 00003b99
Apr  8 18:31:21 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: c6c3be54
Apr  8 18:31:21 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:31:21 sonne kernel: Process run-mozilla.sh (pid: 1530, stackpage=c6c3b000)
Apr  8 18:31:21 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00002b99 00000282 c0278748 
Apr  8 18:31:21 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc c77d0330 ce578b40 cc069340 
Apr  8 18:31:21 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 ce578b40 080cc004 
Apr  8 18:31:21 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] [handle_mm_fault+203/320] 
Apr  8 18:31:21 sonne kernel:    [do_page_fault+279/1076] [do_page_fault+0/1076] [do_generic_file_read+1117/1136] [do_brk+314/576] [do_brk+553/576] [sys_brk+197/240] 
Apr  8 18:31:21 sonne kernel:    [error_code+52/60] 
Apr  8 18:31:21 sonne kernel: 
Apr  8 18:31:21 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 
Apr  8 18:31:21 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:31:21 sonne kernel: invalid operand: 0000
Apr  8 18:31:21 sonne kernel: CPU:    0
Apr  8 18:31:21 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:31:21 sonne kernel: EFLAGS: 00010202
Apr  8 18:31:21 sonne kernel: eax: 01000040   ebx: c10c1aec   ecx: 00001000   edx: 00003b98
Apr  8 18:31:21 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: c6ce3e7c
Apr  8 18:31:21 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:31:21 sonne kernel: Process kghostview (pid: 1579, stackpage=c6ce3000)
Apr  8 18:31:21 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00002b98 00000292 c027873c 
Apr  8 18:31:21 sonne kernel:        00000000 c02786fc c0130514 000001d2 410ad3e4 c12973e8 c98752b4 cff7d8a4 
Apr  8 18:31:21 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 ca54f380 c0125c56 ca54f380 410ad3e4 
Apr  8 18:31:21 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_no_page+150/464] [handle_mm_fault+203/320] [do_page_fault+279/1076] 
Apr  8 18:31:21 sonne kernel:    [do_page_fault+0/1076] [wake_up_process+11/16] [mprotect_fixup+1037/1056] [sys_mprotect+325/507] [sys_mprotect+491/507] [error_code+52/60] 
Apr  8 18:31:21 sonne kernel: 
Apr  8 18:31:21 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 
Apr  8 18:31:26 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:31:26 sonne kernel: invalid operand: 0000
Apr  8 18:31:26 sonne kernel: CPU:    0
Apr  8 18:31:26 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:31:26 sonne kernel: EFLAGS: 00010202
Apr  8 18:31:26 sonne kernel: eax: 01000040   ebx: c10c35f0   ecx: 00001000   edx: 00003c1d
Apr  8 18:31:26 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: cb2f5e54
Apr  8 18:31:26 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:31:26 sonne kernel: Process mozilla-bin (pid: 1585, stackpage=cb2f5000)
Apr  8 18:31:26 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00002c1d 00000282 c0278748 
Apr  8 18:31:26 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc c85dc060 ca54f800 cb2f5eec 
Apr  8 18:31:26 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 ca54f800 08418d64 
Apr  8 18:31:26 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] [handle_mm_fault+203/320] 
Apr  8 18:31:26 sonne kernel:    [do_page_fault+279/1076] [do_page_fault+0/1076] [do_generic_file_read+1117/1136] [do_brk+314/576] [do_brk+553/576] [sys_brk+197/240] 
Apr  8 18:31:26 sonne kernel:    [error_code+52/60] 
Apr  8 18:31:26 sonne kernel: 
Apr  8 18:31:26 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 
Apr  8 18:31:26 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:31:26 sonne kernel: invalid operand: 0000
Apr  8 18:31:26 sonne kernel: CPU:    0
Apr  8 18:31:26 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:31:26 sonne kernel: EFLAGS: 00010202
Apr  8 18:31:26 sonne kernel: eax: 01000044   ebx: c10c35bc   ecx: 00001000   edx: 00003c1c
Apr  8 18:31:26 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: cac2be54
Apr  8 18:31:26 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:31:26 sonne kernel: Process run-mozilla.sh (pid: 1580, stackpage=cac2b000)
Apr  8 18:31:26 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 56555453 00002c1c 00000282 c027873c 
Apr  8 18:31:26 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc ca496080 ce578b40 0000448b 
Apr  8 18:31:26 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 ce578b40 40020000 
Apr  8 18:31:26 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] [handle_mm_fault+203/320] 
Apr  8 18:31:26 sonne kernel:    [do_page_fault+279/1076] [do_page_fault+0/1076] [old_mmap+237/304] [error_code+52/60] 
Apr  8 18:31:26 sonne kernel: 
Apr  8 18:31:26 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 
Apr  8 18:32:12 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:32:12 sonne kernel: invalid operand: 0000
Apr  8 18:32:12 sonne kernel: CPU:    0
Apr  8 18:32:12 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:32:12 sonne kernel: EFLAGS: 00210202
Apr  8 18:32:12 sonne kernel: eax: 01000040   ebx: c122dcc0   ecx: 00001000   edx: 0000aba1
Apr  8 18:32:12 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: c8f8fc68
Apr  8 18:32:12 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:32:12 sonne kernel: Process kdeinit (pid: 1491, stackpage=c8f8f000)
Apr  8 18:32:12 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00009ba1 00200296 c0278748 
Apr  8 18:32:12 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc c8dd7ea4 ca54f500 00000000 
Apr  8 18:32:12 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 ca54f500 417a9000 
Apr  8 18:32:12 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] [handle_mm_fault+203/320] 
Apr  8 18:32:12 sonne kernel:    [do_page_fault+279/1076] [do_page_fault+0/1076] [__delay+19/48] [__const_udelay+28/48] [do_rw_disk+129/144] [error_code+52/60] 
Apr  8 18:32:12 sonne kernel:    [__generic_copy_to_user+51/80] [memcpy_toiovec+56/112] [unix_stream_recvmsg+590/880] [sock_recvmsg+61/176] [sock_readv_writev+120/176] [sock_readv+49/64] 
Apr  8 18:32:12 sonne kernel:    [do_readv_writev+371/592] [select_bits_free+10/16] [sys_select+1135/1152] [sys_readv+65/96] [system_call+51/56] 
Apr  8 18:32:12 sonne kernel: 
Apr  8 18:32:12 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 
Apr  8 18:32:41 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:32:41 sonne kernel: invalid operand: 0000
Apr  8 18:32:41 sonne kernel: CPU:    0
Apr  8 18:32:41 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:32:41 sonne kernel: EFLAGS: 00013202
Apr  8 18:32:41 sonne kernel: eax: 01000040   ebx: c122dc8c   ecx: 00001000   edx: 0000aba0
Apr  8 18:32:41 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: ce89be54
Apr  8 18:32:41 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:32:41 sonne kernel: Process X (pid: 828, stackpage=ce89b000)
Apr  8 18:32:41 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 c0223b36 00009ba0 00003282 c027873c 
Apr  8 18:32:41 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc ca542ba0 cfed6740 ce89a2b0 
Apr  8 18:32:41 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 cfed6740 456e8000 
Apr  8 18:32:41 sonne kernel: Call Trace: [unix_stream_sendmsg+518/704] [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] 
Apr  8 18:32:41 sonne kernel:    [handle_mm_fault+203/320] [do_page_fault+279/1076] [do_page_fault+0/1076] [parport_pc:__insmod_parport_pc_O/lib/modules/2.4.19-pre5-ac3/kernel/dr+-236679/96] [parport_pc:__insmod_parport_pc_O/lib/modules/2.4.19-pre5-ac3/kernel/dr+-315222/96] [parport_pc:__insmod_parport_pc_O/lib/modules/2.4.19-pre5-ac3/kernel/dr+-315186/96] 
Apr  8 18:32:41 sonne kernel:    [parport_pc:__insmod_parport_pc_O/lib/modules/2.4.19-pre5-ac3/kernel/dr+-211374/96] [handle_IRQ_event+47/96] [end_8259A_irq+24/32] [do_IRQ+140/176] [error_code+52/60] 
Apr  8 18:32:41 sonne kernel: 
Apr  8 18:32:41 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 
Apr  8 18:32:41 sonne kernel:  <1>Unable to handle kernel paging request at virtual address ffc0c6b4
Apr  8 18:32:41 sonne kernel:  printing eip:
Apr  8 18:32:41 sonne kernel: c01348b0
Apr  8 18:32:41 sonne kernel: *pde = 00001063
Apr  8 18:32:41 sonne kernel: *pte = 00000000
Apr  8 18:32:41 sonne kernel: Oops: 0000
Apr  8 18:32:41 sonne kernel: CPU:    0
Apr  8 18:32:41 sonne kernel: EIP:    0010:[page_remove_rmap+64/112]    Not tainted
Apr  8 18:32:41 sonne kernel: EFLAGS: 00010282
Apr  8 18:32:41 sonne kernel: eax: ffc0c6b0   ebx: cbe860b0   ecx: c129e91c   edx: cbe8da08
Apr  8 18:32:41 sonne kernel: esi: 0019a000   edi: 0001c000   ebp: 40666000   esp: cb1dff38
Apr  8 18:32:41 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:32:41 sonne kernel: Process kdeinit (pid: 1462, stackpage=cb1df000)
Apr  8 18:32:41 sonne kernel: Stack: cbe8da08 c0124c34 cb9e7440 ce578d80 40266000 001e4000 cb1dd404 cb1dd404 
Apr  8 18:32:41 sonne kernel:        40666000 0000001d 00000000 40400000 cb1dd400 00000000 4044a000 c0127534 
Apr  8 18:32:41 sonne kernel:        ce578d80 40266000 001e4000 ce578d80 cb1de000 0000ff00 bfffee14 cb9e73c0 
Apr  8 18:32:41 sonne kdm[800]: Server for display :0 terminated unexpectedly
Apr  8 18:32:41 sonne kernel: Call Trace: [zap_page_range+388/576] [exit_mmap+196/304] [mmput+38/80] [do_exit+141/480] [sys_exit+14/16] 
Apr  8 18:32:41 sonne kernel:    [system_call+51/56] 
Apr  8 18:32:41 sonne kernel: 
Apr  8 18:32:41 sonne kernel: Code: 39 50 04 75 0d 51 53 50 e8 63 02 00 00 83 c4 0c eb 0e 89 c3 
Apr  8 18:32:41 sonne kernel:  <1>Unable to handle kernel paging request at virtual address ffc0c6b4
Apr  8 18:32:41 sonne kernel:  printing eip:
Apr  8 18:32:41 sonne kernel: c01348b0
Apr  8 18:32:41 sonne kernel: *pde = 00001063
Apr  8 18:32:41 sonne kernel: *pte = 00000000
Apr  8 18:32:41 sonne kernel: Oops: 0000
Apr  8 18:32:41 sonne kernel: CPU:    0
Apr  8 18:32:41 sonne kernel: EIP:    0010:[page_remove_rmap+64/112]    Not tainted
Apr  8 18:32:41 sonne kernel: EFLAGS: 00010282
Apr  8 18:32:41 sonne kernel: eax: ffc0c6b0   ebx: cbe860b0   ecx: c129e91c   edx: ca633a08
Apr  8 18:32:41 sonne kernel: esi: 0019a000   edi: 0001c000   ebp: 40666000   esp: ca635f38
Apr  8 18:32:41 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:32:41 sonne kernel: Process kdeinit (pid: 1456, stackpage=ca635000)
Apr  8 18:32:41 sonne kernel: Stack: ca633a08 c0124c34 ca6324c0 ce578cc0 40266000 001e4000 ca636404 ca636404 
Apr  8 18:32:41 sonne kernel:        40666000 0000001d 00000000 40400000 ca636400 00000000 4044a000 c0127534 
Apr  8 18:32:41 sonne kernel:        ce578cc0 40266000 001e4000 ce578cc0 ca634000 00000100 bfffe92c ca632540 
Apr  8 18:32:41 sonne kernel: Call Trace: [zap_page_range+388/576] [exit_mmap+196/304] [mmput+38/80] [do_exit+141/480] [sys_exit+14/16] 
Apr  8 18:32:41 sonne kernel:    [system_call+51/56] 
Apr  8 18:32:41 sonne kernel: 
Apr  8 18:32:41 sonne kernel: Code: 39 50 04 75 0d 51 53 50 e8 63 02 00 00 83 c4 0c eb 0e 89 c3 
Apr  8 18:32:41 sonne kernel:  <1>Unable to handle kernel paging request at virtual address 313374fa
Apr  8 18:32:41 sonne kernel:  printing eip:
Apr  8 18:32:41 sonne kernel: c01348b0
Apr  8 18:32:41 sonne kernel: *pde = 00000000
Apr  8 18:32:41 sonne kernel: Oops: 0000
Apr  8 18:32:41 sonne kernel: CPU:    0
Apr  8 18:32:41 sonne kernel: EIP:    0010:[page_remove_rmap+64/112]    Not tainted
Apr  8 18:32:41 sonne kernel: EFLAGS: 00010206
Apr  8 18:32:41 sonne kernel: eax: 313374f6   ebx: cbe81cd0   ecx: c127c548   edx: cb4ef13c
Apr  8 18:32:41 sonne kernel: esi: 0002d000   edi: 00002000   ebp: 4044d000   esp: cb4f3f38
Apr  8 18:32:41 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:32:41 sonne kernel: Process kdeinit (pid: 1459, stackpage=cb4f3000)
Apr  8 18:32:41 sonne kernel: Stack: cb4ef13c c0124c34 cbe86940 ce578e40 4004d000 0002d000 cb4f1404 cb4f1404 
Apr  8 18:32:41 sonne kernel:        4044d000 00000003 00000000 4007a000 cb4f1400 00000000 4007a000 c0127534 
Apr  8 18:32:41 sonne kernel:        ce578e40 4004d000 0002d000 ce578e40 cb4f2000 00000000 bffff37c cbe869c0 
Apr  8 18:32:41 sonne kernel: Call Trace: [zap_page_range+388/576] [exit_mmap+196/304] [mmput+38/80] [do_exit+141/480] [sys_exit+14/16] 
Apr  8 18:32:41 sonne PAM-unix2[862]: session finished for user robert, service xdm 
Apr  8 18:32:41 sonne kernel:    [system_call+51/56] 
Apr  8 18:32:41 sonne kernel: 
Apr  8 18:32:41 sonne kernel: Code: 39 50 04 75 0d 51 53 50 e8 63 02 00 00 83 c4 0c eb 0e 89 c3 

--------------040702000904010709050206
Content-Type: text/plain;
 name="ksymoops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops"

ksymoops 2.4.2 on i686 2.4.19-pre5-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre5-ac3/ (default)
     -m /boot/System.map-2.4.19-pre5-ac3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol GPLONLY_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Apr  8 18:23:31 sonne kernel: kernel BUG at page_alloc.c:240!
Apr  8 18:23:31 sonne kernel: invalid operand: 0000
Apr  8 18:23:31 sonne kernel: CPU:    0
Apr  8 18:23:31 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:23:31 sonne kernel: EFLAGS: 00210202
Apr  8 18:23:31 sonne kernel: eax: 01000040   ebx: c10c1b88   ecx: 00001000   edx: 00003b9b
Apr  8 18:23:31 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: c77e9e54
Apr  8 18:23:31 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:23:31 sonne kernel: Process setiathome (pid: 1529, stackpage=c77e9000)
Apr  8 18:23:31 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00002b9b 00200282 c0278754 
Apr  8 18:23:31 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc c85d9348 ca54fec0 00000010 
Apr  8 18:23:31 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 ca54fec0 410d2000 
Apr  8 18:23:31 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] [handle_mm_fault+203/320] 
Apr  8 18:23:31 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f0 00 0c b8               lock add %cl,(%eax,%edi,4)
Code;  00000006 Before first symbol
   6:   23 c0                     and    %eax,%eax
Code;  00000008 Before first symbol
   8:   90                        nop    
Code;  00000008 Before first symbol
   9:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000c Before first symbol
   d:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000010 Before first symbol
  10:   a8 80                     test   $0x80,%al
Code;  00000012 Before first symbol
  12:   74 08                     je     1c <_EIP+0x1c> 0000001c Before first symbol

Apr  8 18:31:21 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:31:21 sonne kernel: invalid operand: 0000
Apr  8 18:31:21 sonne kernel: CPU:    0
Apr  8 18:31:21 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:31:21 sonne kernel: EFLAGS: 00010202
Apr  8 18:31:21 sonne kernel: eax: 01000040   ebx: c10c1b54   ecx: 00001000   edx: 00003b9a
Apr  8 18:31:21 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: c6c33e7c
Apr  8 18:31:21 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:31:21 sonne kernel: Process mozilla-bin (pid: 1535, stackpage=c6c33000)
Apr  8 18:31:21 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00002b9a 00000292 c027873c 
Apr  8 18:31:21 sonne kernel:        00000000 c02786fc c0130514 000001d2 00000000 c85d0fe8 06950065 00000003 
Apr  8 18:31:21 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 c115644c c01255ef ca54f800 bfffad2c 
Apr  8 18:31:21 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_wp_page+143/512] [handle_mm_fault+258/320] [do_page_fault+279/1076] 
Apr  8 18:31:21 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f0 00 0c b8               lock add %cl,(%eax,%edi,4)
Code;  00000006 Before first symbol
   6:   23 c0                     and    %eax,%eax
Code;  00000008 Before first symbol
   8:   90                        nop    
Code;  00000008 Before first symbol
   9:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000c Before first symbol
   d:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000010 Before first symbol
  10:   a8 80                     test   $0x80,%al
Code;  00000012 Before first symbol
  12:   74 08                     je     1c <_EIP+0x1c> 0000001c Before first symbol

Apr  8 18:31:21 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:31:21 sonne kernel: invalid operand: 0000
Apr  8 18:31:21 sonne kernel: CPU:    0
Apr  8 18:31:21 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:31:21 sonne kernel: EFLAGS: 00010202
Apr  8 18:31:21 sonne kernel: eax: 01000040   ebx: c10c1b20   ecx: 00001000   edx: 00003b99
Apr  8 18:31:21 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: c6c3be54
Apr  8 18:31:21 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:31:21 sonne kernel: Process run-mozilla.sh (pid: 1530, stackpage=c6c3b000)
Apr  8 18:31:21 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00002b99 00000282 c0278748 
Apr  8 18:31:21 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc c77d0330 ce578b40 cc069340 
Apr  8 18:31:21 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 ce578b40 080cc004 
Apr  8 18:31:21 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] [handle_mm_fault+203/320] 
Apr  8 18:31:21 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f0 00 0c b8               lock add %cl,(%eax,%edi,4)
Code;  00000006 Before first symbol
   6:   23 c0                     and    %eax,%eax
Code;  00000008 Before first symbol
   8:   90                        nop    
Code;  00000008 Before first symbol
   9:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000c Before first symbol
   d:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000010 Before first symbol
  10:   a8 80                     test   $0x80,%al
Code;  00000012 Before first symbol
  12:   74 08                     je     1c <_EIP+0x1c> 0000001c Before first symbol

Apr  8 18:31:21 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:31:21 sonne kernel: invalid operand: 0000
Apr  8 18:31:21 sonne kernel: CPU:    0
Apr  8 18:31:21 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:31:21 sonne kernel: EFLAGS: 00010202
Apr  8 18:31:21 sonne kernel: eax: 01000040   ebx: c10c1aec   ecx: 00001000   edx: 00003b98
Apr  8 18:31:21 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: c6ce3e7c
Apr  8 18:31:21 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:31:21 sonne kernel: Process kghostview (pid: 1579, stackpage=c6ce3000)
Apr  8 18:31:21 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00002b98 00000292 c027873c 
Apr  8 18:31:21 sonne kernel:        00000000 c02786fc c0130514 000001d2 410ad3e4 c12973e8 c98752b4 cff7d8a4 
Apr  8 18:31:21 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 ca54f380 c0125c56 ca54f380 410ad3e4 
Apr  8 18:31:21 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_no_page+150/464] [handle_mm_fault+203/320] [do_page_fault+279/1076] 
Apr  8 18:31:21 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f0 00 0c b8               lock add %cl,(%eax,%edi,4)
Code;  00000006 Before first symbol
   6:   23 c0                     and    %eax,%eax
Code;  00000008 Before first symbol
   8:   90                        nop    
Code;  00000008 Before first symbol
   9:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000c Before first symbol
   d:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000010 Before first symbol
  10:   a8 80                     test   $0x80,%al
Code;  00000012 Before first symbol
  12:   74 08                     je     1c <_EIP+0x1c> 0000001c Before first symbol

Apr  8 18:31:26 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:31:26 sonne kernel: invalid operand: 0000
Apr  8 18:31:26 sonne kernel: CPU:    0
Apr  8 18:31:26 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:31:26 sonne kernel: EFLAGS: 00010202
Apr  8 18:31:26 sonne kernel: eax: 01000040   ebx: c10c35f0   ecx: 00001000   edx: 00003c1d
Apr  8 18:31:26 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: cb2f5e54
Apr  8 18:31:26 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:31:26 sonne kernel: Process mozilla-bin (pid: 1585, stackpage=cb2f5000)
Apr  8 18:31:26 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00002c1d 00000282 c0278748 
Apr  8 18:31:26 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc c85dc060 ca54f800 cb2f5eec 
Apr  8 18:31:26 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 ca54f800 08418d64 
Apr  8 18:31:26 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] [handle_mm_fault+203/320] 
Apr  8 18:31:26 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f0 00 0c b8               lock add %cl,(%eax,%edi,4)
Code;  00000006 Before first symbol
   6:   23 c0                     and    %eax,%eax
Code;  00000008 Before first symbol
   8:   90                        nop    
Code;  00000008 Before first symbol
   9:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000c Before first symbol
   d:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000010 Before first symbol
  10:   a8 80                     test   $0x80,%al
Code;  00000012 Before first symbol
  12:   74 08                     je     1c <_EIP+0x1c> 0000001c Before first symbol

Apr  8 18:31:26 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:31:26 sonne kernel: invalid operand: 0000
Apr  8 18:31:26 sonne kernel: CPU:    0
Apr  8 18:31:26 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:31:26 sonne kernel: EFLAGS: 00010202
Apr  8 18:31:26 sonne kernel: eax: 01000044   ebx: c10c35bc   ecx: 00001000   edx: 00003c1c
Apr  8 18:31:26 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: cac2be54
Apr  8 18:31:26 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:31:26 sonne kernel: Process run-mozilla.sh (pid: 1580, stackpage=cac2b000)
Apr  8 18:31:26 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 56555453 00002c1c 00000282 c027873c 
Apr  8 18:31:26 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc ca496080 ce578b40 0000448b 
Apr  8 18:31:26 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 ce578b40 40020000 
Apr  8 18:31:26 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] [handle_mm_fault+203/320] 
Apr  8 18:31:26 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f0 00 0c b8               lock add %cl,(%eax,%edi,4)
Code;  00000006 Before first symbol
   6:   23 c0                     and    %eax,%eax
Code;  00000008 Before first symbol
   8:   90                        nop    
Code;  00000008 Before first symbol
   9:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000c Before first symbol
   d:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000010 Before first symbol
  10:   a8 80                     test   $0x80,%al
Code;  00000012 Before first symbol
  12:   74 08                     je     1c <_EIP+0x1c> 0000001c Before first symbol

Apr  8 18:32:12 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:32:12 sonne kernel: invalid operand: 0000
Apr  8 18:32:12 sonne kernel: CPU:    0
Apr  8 18:32:12 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:32:12 sonne kernel: EFLAGS: 00210202
Apr  8 18:32:12 sonne kernel: eax: 01000040   ebx: c122dcc0   ecx: 00001000   edx: 0000aba1
Apr  8 18:32:12 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: c8f8fc68
Apr  8 18:32:12 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:32:12 sonne kernel: Process kdeinit (pid: 1491, stackpage=c8f8f000)
Apr  8 18:32:12 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 00001000 00009ba1 00200296 c0278748 
Apr  8 18:32:12 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc c8dd7ea4 ca54f500 00000000 
Apr  8 18:32:12 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 ca54f500 417a9000 
Apr  8 18:32:12 sonne kernel: Call Trace: [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] [handle_mm_fault+203/320] 
Apr  8 18:32:12 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f0 00 0c b8               lock add %cl,(%eax,%edi,4)
Code;  00000006 Before first symbol
   6:   23 c0                     and    %eax,%eax
Code;  00000008 Before first symbol
   8:   90                        nop    
Code;  00000008 Before first symbol
   9:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000c Before first symbol
   d:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000010 Before first symbol
  10:   a8 80                     test   $0x80,%al
Code;  00000012 Before first symbol
  12:   74 08                     je     1c <_EIP+0x1c> 0000001c Before first symbol

Apr  8 18:32:41 sonne kernel:  kernel BUG at page_alloc.c:240!
Apr  8 18:32:41 sonne kernel: invalid operand: 0000
Apr  8 18:32:41 sonne kernel: CPU:    0
Apr  8 18:32:41 sonne kernel: EIP:    0010:[rmqueue+483/560]    Not tainted
Apr  8 18:32:41 sonne kernel: EFLAGS: 00013202
Apr  8 18:32:41 sonne kernel: eax: 01000040   ebx: c122dc8c   ecx: 00001000   edx: 0000aba0
Apr  8 18:32:41 sonne kernel: esi: c02786fc   edi: 00000001   ebp: c02786fc   esp: ce89be54
Apr  8 18:32:41 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:32:41 sonne kernel: Process X (pid: 828, stackpage=ce89b000)
Apr  8 18:32:41 sonne kernel: Stack: 000001d2 c02788d8 00000100 00000000 c0223b36 00009ba0 00003282 c027873c 
Apr  8 18:32:41 sonne kernel:        00000000 c02786fc c0130514 000001d2 c10034dc ca542ba0 cfed6740 ce89a2b0 
Apr  8 18:32:41 sonne kernel:        00000001 c02788d4 000001d2 c01303d6 00104025 c0125b23 cfed6740 456e8000 
Apr  8 18:32:41 sonne kernel: Call Trace: [unix_stream_sendmsg+518/704] [__alloc_pages+100/688] [_alloc_pages+22/32] [do_anonymous_page+67/224] [do_no_page+51/464] 
Apr  8 18:32:41 sonne kernel: Code: 0f 0b f0 00 0c b8 23 c0 90 8d 74 26 00 8b 43 18 a8 80 74 08 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   f0 00 0c b8               lock add %cl,(%eax,%edi,4)
Code;  00000006 Before first symbol
   6:   23 c0                     and    %eax,%eax
Code;  00000008 Before first symbol
   8:   90                        nop    
Code;  00000008 Before first symbol
   9:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000c Before first symbol
   d:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000010 Before first symbol
  10:   a8 80                     test   $0x80,%al
Code;  00000012 Before first symbol
  12:   74 08                     je     1c <_EIP+0x1c> 0000001c Before first symbol

Apr  8 18:32:41 sonne kernel:  <1>Unable to handle kernel paging request at virtual address ffc0c6b4
Apr  8 18:32:41 sonne kernel: c01348b0
Apr  8 18:32:41 sonne kernel: *pde = 00001063
Apr  8 18:32:41 sonne kernel: Oops: 0000
Apr  8 18:32:41 sonne kernel: CPU:    0
Apr  8 18:32:41 sonne kernel: EIP:    0010:[page_remove_rmap+64/112]    Not tainted
Apr  8 18:32:41 sonne kernel: EFLAGS: 00010282
Apr  8 18:32:41 sonne kernel: eax: ffc0c6b0   ebx: cbe860b0   ecx: c129e91c   edx: cbe8da08
Apr  8 18:32:41 sonne kernel: esi: 0019a000   edi: 0001c000   ebp: 40666000   esp: cb1dff38
Apr  8 18:32:41 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:32:41 sonne kernel: Process kdeinit (pid: 1462, stackpage=cb1df000)
Apr  8 18:32:41 sonne kernel: Stack: cbe8da08 c0124c34 cb9e7440 ce578d80 40266000 001e4000 cb1dd404 cb1dd404 
Apr  8 18:32:41 sonne kernel:        40666000 0000001d 00000000 40400000 cb1dd400 00000000 4044a000 c0127534 
Apr  8 18:32:41 sonne kernel:        ce578d80 40266000 001e4000 ce578d80 cb1de000 0000ff00 bfffee14 cb9e73c0 
Apr  8 18:32:41 sonne kernel: Call Trace: [zap_page_range+388/576] [exit_mmap+196/304] [mmput+38/80] [do_exit+141/480] [sys_exit+14/16] 
Apr  8 18:32:41 sonne kernel: Code: 39 50 04 75 0d 51 53 50 e8 63 02 00 00 83 c4 0c eb 0e 89 c3 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 50 04                  cmp    %edx,0x4(%eax)
Code;  00000002 Before first symbol
   3:   75 0d                     jne    12 <_EIP+0x12> 00000012 Before first symbol
Code;  00000004 Before first symbol
   5:   51                        push   %ecx
Code;  00000006 Before first symbol
   6:   53                        push   %ebx
Code;  00000006 Before first symbol
   7:   50                        push   %eax
Code;  00000008 Before first symbol
   8:   e8 63 02 00 00            call   270 <_EIP+0x270> 00000270 Before first symbol
Code;  0000000c Before first symbol
   d:   83 c4 0c                  add    $0xc,%esp
Code;  00000010 Before first symbol
  10:   eb 0e                     jmp    20 <_EIP+0x20> 00000020 Before first symbol
Code;  00000012 Before first symbol
  12:   89 c3                     mov    %eax,%ebx

Apr  8 18:32:41 sonne kernel:  <1>Unable to handle kernel paging request at virtual address ffc0c6b4
Apr  8 18:32:41 sonne kernel: c01348b0
Apr  8 18:32:41 sonne kernel: *pde = 00001063
Apr  8 18:32:41 sonne kernel: Oops: 0000
Apr  8 18:32:41 sonne kernel: CPU:    0
Apr  8 18:32:41 sonne kernel: EIP:    0010:[page_remove_rmap+64/112]    Not tainted
Apr  8 18:32:41 sonne kernel: EFLAGS: 00010282
Apr  8 18:32:41 sonne kernel: eax: ffc0c6b0   ebx: cbe860b0   ecx: c129e91c   edx: ca633a08
Apr  8 18:32:41 sonne kernel: esi: 0019a000   edi: 0001c000   ebp: 40666000   esp: ca635f38
Apr  8 18:32:41 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:32:41 sonne kernel: Process kdeinit (pid: 1456, stackpage=ca635000)
Apr  8 18:32:41 sonne kernel: Stack: ca633a08 c0124c34 ca6324c0 ce578cc0 40266000 001e4000 ca636404 ca636404 
Apr  8 18:32:41 sonne kernel:        40666000 0000001d 00000000 40400000 ca636400 00000000 4044a000 c0127534 
Apr  8 18:32:41 sonne kernel:        ce578cc0 40266000 001e4000 ce578cc0 ca634000 00000100 bfffe92c ca632540 
Apr  8 18:32:41 sonne kernel: Call Trace: [zap_page_range+388/576] [exit_mmap+196/304] [mmput+38/80] [do_exit+141/480] [sys_exit+14/16] 
Apr  8 18:32:41 sonne kernel: Code: 39 50 04 75 0d 51 53 50 e8 63 02 00 00 83 c4 0c eb 0e 89 c3 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 50 04                  cmp    %edx,0x4(%eax)
Code;  00000002 Before first symbol
   3:   75 0d                     jne    12 <_EIP+0x12> 00000012 Before first symbol
Code;  00000004 Before first symbol
   5:   51                        push   %ecx
Code;  00000006 Before first symbol
   6:   53                        push   %ebx
Code;  00000006 Before first symbol
   7:   50                        push   %eax
Code;  00000008 Before first symbol
   8:   e8 63 02 00 00            call   270 <_EIP+0x270> 00000270 Before first symbol
Code;  0000000c Before first symbol
   d:   83 c4 0c                  add    $0xc,%esp
Code;  00000010 Before first symbol
  10:   eb 0e                     jmp    20 <_EIP+0x20> 00000020 Before first symbol
Code;  00000012 Before first symbol
  12:   89 c3                     mov    %eax,%ebx

Apr  8 18:32:41 sonne kernel:  <1>Unable to handle kernel paging request at virtual address 313374fa
Apr  8 18:32:41 sonne kernel: c01348b0
Apr  8 18:32:41 sonne kernel: *pde = 00000000
Apr  8 18:32:41 sonne kernel: Oops: 0000
Apr  8 18:32:41 sonne kernel: CPU:    0
Apr  8 18:32:41 sonne kernel: EIP:    0010:[page_remove_rmap+64/112]    Not tainted
Apr  8 18:32:41 sonne kernel: EFLAGS: 00010206
Apr  8 18:32:41 sonne kernel: eax: 313374f6   ebx: cbe81cd0   ecx: c127c548   edx: cb4ef13c
Apr  8 18:32:41 sonne kernel: esi: 0002d000   edi: 00002000   ebp: 4044d000   esp: cb4f3f38
Apr  8 18:32:41 sonne kernel: ds: 0018   es: 0018   ss: 0018
Apr  8 18:32:41 sonne kernel: Process kdeinit (pid: 1459, stackpage=cb4f3000)
Apr  8 18:32:41 sonne kernel: Stack: cb4ef13c c0124c34 cbe86940 ce578e40 4004d000 0002d000 cb4f1404 cb4f1404 
Apr  8 18:32:41 sonne kernel:        4044d000 00000003 00000000 4007a000 cb4f1400 00000000 4007a000 c0127534 
Apr  8 18:32:41 sonne kernel:        ce578e40 4004d000 0002d000 ce578e40 cb4f2000 00000000 bffff37c cbe869c0 
Apr  8 18:32:41 sonne kernel: Call Trace: [zap_page_range+388/576] [exit_mmap+196/304] [mmput+38/80] [do_exit+141/480] [sys_exit+14/16] 
Apr  8 18:32:41 sonne kernel: Code: 39 50 04 75 0d 51 53 50 e8 63 02 00 00 83 c4 0c eb 0e 89 c3 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 50 04                  cmp    %edx,0x4(%eax)
Code;  00000002 Before first symbol
   3:   75 0d                     jne    12 <_EIP+0x12> 00000012 Before first symbol
Code;  00000004 Before first symbol
   5:   51                        push   %ecx
Code;  00000006 Before first symbol
   6:   53                        push   %ebx
Code;  00000006 Before first symbol
   7:   50                        push   %eax
Code;  00000008 Before first symbol
   8:   e8 63 02 00 00            call   270 <_EIP+0x270> 00000270 Before first symbol
Code;  0000000c Before first symbol
   d:   83 c4 0c                  add    $0xc,%esp
Code;  00000010 Before first symbol
  10:   eb 0e                     jmp    20 <_EIP+0x20> 00000020 Before first symbol
Code;  00000012 Before first symbol
  12:   89 c3                     mov    %eax,%ebx


2 warnings issued.  Results may not be reliable.

--------------040702000904010709050206
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ec000000-edffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
	Subsystem: Yamaha Corporation DS-XG PCI Audio Codec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ef000000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at c000 [size=64]
	Region 2: I/O ports at c400 [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ef00a000 (32-bit, prefetchable) [size=4K]

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ef008000 (32-bit, prefetchable) [size=4K]

00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at c800 [size=128]
	Region 1: Memory at ef009000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at cc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.4 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 RAID bus controller: Triones Technologies, Inc. HPT366 (rev 05)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at dc00 [size=8]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at e400 [size=8]
	Region 3: I/O ports at e800 [size=4]
	Region 4: I/O ports at ec00 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS) (rev a4) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 4023
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


--------------040702000904010709050206
Content-Type: text/plain;
 name="proc.cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.cpuinfo"

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 1800+
stepping	: 2
cpu MHz		: 1534.016
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3060.53


--------------040702000904010709050206
Content-Type: text/plain;
 name="proc.version"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.version"

Linux version 2.4.19-pre5-ac3 (root@sonne) (gcc version 2.95.3 20010315 (SuSE)) #2 Sat Apr 6 10:18:44 CEST 2002

--------------040702000904010709050206
Content-Type: text/plain;
 name="proc.modules"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.modules"

snd-pcm-oss            36128   1 (autoclean)
snd-mixer-oss           9136   1 (autoclean)
vmnet                  17984   6
vmmon                  18688   0 (unused)
parport_pc             26176   1 (autoclean)
lp                      7040   0 (autoclean)
parport                22304   1 (autoclean) [parport_pc lp]
snd-opl3-synth          8688   0 (unused)
snd-seq-instr           4320   0 [snd-opl3-synth]
snd-seq-midi-emul       4336   0 [snd-opl3-synth]
snd-seq                37168   0 [snd-opl3-synth snd-seq-instr snd-seq-midi-emul]
snd-ainstr-fm           1520   0 [snd-opl3-synth]
snd-ymfpci             40704   2
snd-pcm                47712   0 [snd-pcm-oss snd-ymfpci]
snd-opl3-lib            5328   0 [snd-opl3-synth snd-ymfpci]
snd-hwdep               3792   0 [snd-opl3-lib]
snd-timer              10288   0 [snd-seq snd-pcm snd-opl3-lib]
snd-mpu401-uart         2704   0 [snd-ymfpci]
snd-rawmidi            12224   0 [snd-mpu401-uart]
snd-seq-device          4096   0 [snd-opl3-synth snd-seq snd-opl3-lib snd-rawmidi]
snd-ac97-codec         23120   0 [snd-ymfpci]
snd                    24672   0 [snd-pcm-oss snd-mixer-oss snd-opl3-synth snd-seq-instr snd-seq snd-ymfpci snd-pcm snd-opl3-lib snd-hwdep snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd-ac97-codec]
soundcore               3376   7 [snd]
evdev                   4144   0 (unused)
input                   3168   0 [evdev]
3c59x                  25056   1 (autoclean)
w83781d                19088   0 (unused)
i2c-proc                6288   0 [w83781d]
i2c-isa                 1264   0 (unused)
i2c-core               12448   0 [w83781d i2c-proc i2c-isa]
iptable_nat            13168   0 (autoclean) (unused)
ip_conntrack           13392   1 (autoclean) [iptable_nat]
iptable_filter          1760   0 (autoclean) (unused)
ip_tables              10560   4 [iptable_nat iptable_filter]
ide-scsi                7728   0
scsi_mod               81104   1 [ide-scsi]

--------------040702000904010709050206
Content-Type: text/plain;
 name="proc.ioports"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.ioports"

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : w83697hf
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-c03f : Yamaha Corporation YMF-754 [DS-1E Audio Controller]
  c000-c001 : OPL2/3 (left)
  c002-c003 : OPL2/3 (right)
  c020-c021 : MPU401 UART
c400-c403 : Yamaha Corporation YMF-754 [DS-1E Audio Controller]
c800-c87f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  c800-c87f : 00:0d.0
cc00-cc0f : VIA Technologies, Inc. Bus Master IDE
  cc00-cc07 : ide0
  cc08-cc0f : ide1
d000-d01f : VIA Technologies, Inc. UHCI USB
d400-d41f : VIA Technologies, Inc. UHCI USB (#2)
d800-d81f : VIA Technologies, Inc. UHCI USB (#3)
dc00-dc07 : Triones Technologies, Inc. HPT366 / HPT370
e000-e003 : Triones Technologies, Inc. HPT366 / HPT370
e400-e407 : Triones Technologies, Inc. HPT366 / HPT370
e800-e803 : Triones Technologies, Inc. HPT366 / HPT370
ec00-ecff : Triones Technologies, Inc. HPT366 / HPT370
  ec00-ec07 : ide2
  ec08-ec0f : ide3
  ec10-ecff : HPT372

--------------040702000904010709050206--

