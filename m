Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315130AbSDWJ1k>; Tue, 23 Apr 2002 05:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315131AbSDWJ1j>; Tue, 23 Apr 2002 05:27:39 -0400
Received: from pD9E12CD1.dip.t-dialin.net ([217.225.44.209]:47606 "HELO
	smart.cobolt.net") by vger.kernel.org with SMTP id <S315130AbSDWJ1d>;
	Tue, 23 Apr 2002 05:27:33 -0400
Date: Tue, 23 Apr 2002 11:27:32 +0200
From: Dennis Schoen <dennis@cns.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.4.19-pre6aa1 (i586) ?
Message-ID: <20020423092731.GA6327@smart.cobolt.net>
Reply-To: Dennis Schoen <dennis@cns.dnsalias.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Mail-Copies-To: never
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok thats the second time in 3 days the machine died. Here are the infos:

AMD-K6(tm) 3D processor

opel:~# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5591/5592 Host (rev 02)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.  RTL-8029(AS)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
86C326 (rev 0b)

Kernel config is also attached. Contact me if you need more infos.

Ciao
  Dennis

from syslog:

Apr 21 21:40:03 opel kernel: kernel BUG at page_alloc.c:234!
Apr 21 21:40:03 opel kernel: invalid operand: 0000
Apr 21 21:40:03 opel kernel: CPU:    0
Apr 21 21:40:03 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:03 opel kernel: EFLAGS: 00010086
Apr 21 21:40:03 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:03 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: ca569e64
Apr 21 21:40:03 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:03 opel kernel: Process w3m-en (pid: 1963, stackpage=ca569000)
Apr 21 21:40:03 opel kernel: Stack: c02304d4 00000000 00000001 00000001 c0230310 0000a9b0 00000286 c023034c 
Apr 21 21:40:03 opel kernel:        00000000 c0230310 c012bac4 c1002ccc 00000000 c6ebb274 00000001 c0230310 
Apr 21 21:40:03 opel kernel:        00000001 c0122684 0000000c c0230310 c02304d0 000001d2 0809deb0 c012213b 
Apr 21 21:40:03 opel kernel: Call Trace: [__alloc_pages+116/664] [do_no_page+56/380] [do_wp_page+127/440] [handle_mm_fault+144/208] [do_page_fault+447/1336] 
Apr 21 21:40:03 opel kernel:    [do_page_fault+0/1336] [do_brk+283/508] [sys_brk+193/240] [error_code+52/64] 
Apr 21 21:40:03 opel kernel: 
Apr 21 21:40:03 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: ca569e38
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process w3m (pid: 1969, stackpage=ca569000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 40014000 000081d0 00000296 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 00104025 080cb014 c7a7a32c 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        c0279ba0 00000000 0000000c c0230310 c02304d0 000001d2 c0125bea c01225a5 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [filemap_nopage+234/508] [do_anonymous_page+61/228] [do_no_page+56/380] [handle_mm_fault+89/208] 
Apr 21 21:40:04 opel kernel:    [do_page_fault+447/1336] [do_page_fault+0/1336] [__do_generic_file_read+1123/1136] [do_brk+283/508] [sys_brk+193/240] [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: c659fe38
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process perl (pid: 1976, stackpage=c659f000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 c0109a21 00104025 00000296 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 00104025 080f992c c74873e4 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        c107b3dc 00000000 0000000c c0230310 c02304d0 000001d2 c0125bea c01225a5 
Apr 21 21:40:04 opel kernel: Call Trace: [do_IRQ+153/168] [__alloc_pages+116/664] [filemap_nopage+234/508] [do_anonymous_page+61/228] [do_no_page+56/380] 
Apr 21 21:40:04 opel kernel:    [handle_mm_fault+89/208] [do_page_fault+447/1336] [do_page_fault+0/1336] [free_page_and_swap_cache+49/52] [__vma_link+98/172] [do_brk+283/508] 
Apr 21 21:40:04 opel kernel:    [sys_brk+193/240] [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: c1793e64
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process w3m-en (pid: 1973, stackpage=c1793000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 c0230310 32313437 00000286 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 c1002ccc 00000000 c1e0c0dc 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        00000001 c0122684 0000000c c0230310 c02304d0 000001d2 40037c20 c012213b 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [do_no_page+56/380] [do_wp_page+127/440] [handle_mm_fault+144/208] [do_page_fault+447/1336] 
Apr 21 21:40:04 opel kernel:    [do_page_fault+0/1336] [update_wall_time+11/60] [do_brk+283/508] [do_softirq+91/172] [sys_brk+193/240] [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: ca569da0
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process w3m (pid: 1979, stackpage=ca569000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 c0221d80 00000000 00000282 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 00104025 40014000 c8281050 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        4a494847 4e4d4c4b 0000000c c0230310 c02304d0 000001d2 33323130 c01225a5 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [do_anonymous_page+61/228] [do_no_page+56/380] [handle_mm_fault+89/208] [do_page_fault+447/1336] 
Apr 21 21:40:04 opel kernel:    [do_page_fault+0/1336] [sprintf+18/24] [meminfo_read_proc+344/392] [meminfo_read_proc+380/392] [error_code+52/64] [__generic_copy_to_user+48/60] 
Apr 21 21:40:04 opel kernel:    [proc_file_read+323/428] [sys_read+149/232] [system_call+51/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: c659fe38
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process perl (pid: 1986, stackpage=c659f000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 40011000 00006eda 00000296 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 00104025 40156f50 c7b48558 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        00002a59 00000286 0000000c c0230310 c02304d0 000001d2 c0125bea c01225a5 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [filemap_nopage+234/508] [do_anonymous_page+61/228] [do_no_page+56/380] [handle_mm_fault+89/208] 
Apr 21 21:40:04 opel kernel:    [do_page_fault+447/1336] [do_page_fault+0/1336] [free_page_and_swap_cache+49/52] [unmap_fixup+100/312] [do_munmap+556/572] [sys_munmap+54/84] 
Apr 21 21:40:04 opel kernel:    [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: c4cf5e38
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process w3m-en (pid: 1983, stackpage=c4cf5000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 37363530 00001abc 00000296 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 00104025 080ad000 c6ebb2b4 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        32313437 00000282 0000000c c0230310 c02304d0 000001d2 00000001 c01225a5 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [do_anonymous_page+61/228] [do_no_page+56/380] [handle_mm_fault+89/208] [do_page_fault+447/1336] 
Apr 21 21:40:04 opel kernel:    [do_page_fault+0/1336] [do_brk+283/508] [sys_brk+193/240] [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: ca569e64
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process w3m (pid: 1989, stackpage=ca569000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 c0230310 000021c6 00000286 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 c104b890 00000000 c7a7a2fc 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        00000113 c1297f54 0000000c c0230310 c02304d0 000001d2 080bf7d0 c012213b 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [do_wp_page+127/440] [handle_mm_fault+144/208] [do_page_fault+447/1336] [do_page_fault+0/1336] 
Apr 21 21:40:04 opel kernel:    [permission+43/48] [chrdev_open+64/84] [dentry_open+399/432] [filp_open+67/76] [sys_ioctl+374/388] [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: ca569e38
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process perl (pid: 1996, stackpage=ca569000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 00000000 00004fa9 00000296 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 00104025 080f992c c18453e4 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        c1064b18 c249d6ec 0000000c c0230310 c02304d0 000001d2 c0125bea c01225a5 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [filemap_nopage+234/508] [do_anonymous_page+61/228] [do_no_page+56/380] [handle_mm_fault+89/208] 
Apr 21 21:40:04 opel kernel:    [do_page_fault+447/1336] [do_page_fault+0/1336] [free_page_and_swap_cache+49/52] [__vma_link+98/172] [do_brk+283/508] [sys_brk+193/240] 
Apr 21 21:40:04 opel kernel:    [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: c1793e38
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process w3m-en (pid: 1993, stackpage=c1793000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 37363530 0000075f 00000296 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 00104025 080a2000 c90f5288 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        32313437 00000286 0000000c c0230310 c02304d0 000001d2 00000001 c01225a5 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [do_anonymous_page+61/228] [do_no_page+56/380] [handle_mm_fault+89/208] [do_page_fault+447/1336] 
Apr 21 21:40:04 opel kernel:    [do_page_fault+0/1336] [do_brk+283/508] [sys_brk+193/240] [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: c4cf5e64
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process w3m (pid: 1999, stackpage=c4cf5000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 c0230310 c97f9080 00000286 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 c1002ccc 00000000 c624d5d0 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        00000001 c0122684 0000000c c0230310 c02304d0 000001d2 401744a4 c012213b 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [do_no_page+56/380] [do_wp_page+127/440] [handle_mm_fault+144/208] [do_page_fault+447/1336] 
Apr 21 21:40:04 opel kernel:    [do_page_fault+0/1336] [permission+43/48] [chrdev_open+64/84] [dentry_open+399/432] [filp_open+67/76] [sys_ioctl+374/388] 
Apr 21 21:40:04 opel kernel:    [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: c659fe64
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process perl (pid: 2006, stackpage=c659f000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 c0230310 0000925e 00000286 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 c1064b44 c22f92a0 c18d64e0 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        000000ad c1280e7c 0000000c c0230310 c02304d0 000001d2 080f3000 c01226eb 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [do_no_page+159/380] [handle_mm_fault+89/208] [do_page_fault+447/1336] [do_page_fault+0/1336] 
Apr 21 21:40:04 opel kernel:    [free_page_and_swap_cache+49/52] [__vma_link+98/172] [do_brk+283/508] [sys_brk+193/240] [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: ca569e38
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process w3m-en (pid: 2003, stackpage=ca569000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 37363530 0000925e 00000296 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 00104025 080a4000 c1845290 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        32313437 00000286 0000000c c0230310 c02304d0 000001d2 00000001 c01225a5 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [do_anonymous_page+61/228] [do_no_page+56/380] [handle_mm_fault+89/208] [do_page_fault+447/1336] 
Apr 21 21:40:04 opel kernel:    [do_page_fault+0/1336] [do_brk+283/508] [sys_brk+193/240] [error_code+52/64] 
Apr 21 21:40:04 opel kernel: 
Apr 21 21:40:04 opel kernel: Code: 0f 0b ea 00 88 ab 1f c0 8b 53 04 8b 03 89 50 04 89 02 8b 54 
Apr 21 21:40:04 opel kernel:  kernel BUG at page_alloc.c:234!
Apr 21 21:40:04 opel kernel: invalid operand: 0000
Apr 21 21:40:04 opel kernel: CPU:    0
Apr 21 21:40:04 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
Apr 21 21:40:04 opel kernel: EFLAGS: 00010086
Apr 21 21:40:04 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
Apr 21 21:40:04 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: c1793e64
Apr 21 21:40:04 opel kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 21:40:04 opel kernel: Process w3m (pid: 2012, stackpage=c1793000)
Apr 21 21:40:04 opel kernel: Stack: c02304d4 00000000 00000001 00000001 c0230310 00004a48 00000286 c023034c 
Apr 21 21:40:04 opel kernel:        00000000 c0230310 c012bac4 c10f2780 00000000 c2ce4ffc 00000001 c0230310 
Apr 21 21:40:04 opel kernel:        ca568000 00000011 0000000c c0230310 c02304d0 000001d2 bffff850 c012213b 
Apr 21 21:40:04 opel kernel: Call Trace: [__alloc_pages+116/664] [do_wp_page+127/440] [handle_mm_fault+144/208] [do_page_fault+447/1336] [do_page_fault+0/1336] 
Apr 21 21:40:04 opel kernel:    [__free_pte+64/72] [zap_page_range+388/560] [__mmdrop+59/68] [do_exit+595/608] [error_code+52/64] 


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=opel

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
CONFIG_MK6=y
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_3GB is not set
# CONFIG_05GB is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_PM=y
CONFIG_ACPI=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_BUSMGR is not set
# CONFIG_ACPI_SYS is not set
# CONFIG_ACPI_CPU is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_EC is not set
# CONFIG_ACPI_CMBATT is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_TUX is not set
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_TC35815 is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=y
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_NEW_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_ACPI is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_MINIX_FS=m
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

--OgqxwSJOaUobr8KG--
