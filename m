Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTLMF3F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 00:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTLMF3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 00:29:05 -0500
Received: from web60204.mail.yahoo.com ([216.109.118.99]:14689 "HELO
	web60204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264229AbTLMF25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 00:28:57 -0500
Message-ID: <20031213052856.98915.qmail@web60204.mail.yahoo.com>
Date: Fri, 12 Dec 2003 21:28:56 -0800 (PST)
From: "E. Taylor" <eye_oh_error@yahoo.com>
Subject: frequent oopses on 2.4.20-24.9
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On an Acer Power 4100, running Red Hat 9 with a 2.4.20-24.9 kernel,
I get frequent oopses.

It's a 450MHz Pentium 2 with 128MB of memory.  I've run memtest86
successfully.

Here are a couple of examples.

Nov 25 23:11:24 localhost modprobe: modprobe: Can't locate module
sound-slot-0
Nov 25 23:11:24 localhost modprobe: modprobe: Can't locate module
sound-service-0-3
Nov 26 16:11:26 localhost kernel: ------------[ cut here ]------------
Nov 26 16:11:26 localhost kernel: kernel BUG at page_alloc.c:139!
Nov 26 16:11:26 localhost kernel: invalid operand: 0000
Nov 26 16:11:26 localhost kernel: soundcore ide-cd cdrom parport_pc lp
parport autofs tulip e100 ipt_REJECT iptable_filter ip_tables microcode
keybdev mousedev hid input usb-uhci usbcore ext3 
Nov 26 16:11:26 localhost kernel: CPU:    0
Nov 26 16:11:27 localhost kernel: EIP:    0060:[<c013e91d>]    Not tainted
Nov 26 16:11:27 localhost kernel: EFLAGS: 00013202
Nov 26 16:11:27 localhost kernel: 
Nov 26 16:11:27 localhost kernel: EIP is at __free_pages_ok [kernel] 0xdd
(2.4.20-20.9)
Nov 26 16:11:27 localhost kernel: eax: 01000058   ebx: c1116318   ecx:
c1000030   edx: 0680a980
Nov 26 16:11:27 localhost kernel: esi: 00000000   edi: 00000000   ebp:
00000000   esp: c479bdf0
Nov 26 16:11:27 localhost kernel: ds: 0068   es: 0068   ss: 0068
Nov 26 16:11:27 localhost kernel: Process X (pid: 2031, stackpage=c479b000)
Nov 26 16:11:27 localhost kernel: Stack: 000057f1 c1116318 c03a07c0 c0140396
c03a07c0 00000000 00000001 c1116318 
Nov 26 16:11:27 localhost kernel:        c57961ec c1116318 c1116318 c57961ec
000ed000 04f7b047 c012edec c1116318 
Nov 26 16:11:28 localhost kernel:        0007b000 c0131457 c5c83d00 08c7b000
c57961ec c01199a3 0000007c 09000000 
Nov 26 16:11:28 localhost kernel: Call Trace:   [<c0140396>]
remove_exclusive_swap_page [kernel] 0xb6 (0xc479bdfc))
Nov 26 16:11:29 localhost kernel: [<c012edec>] __free_pte [kernel] 0x4c
(0xc479be28))
Nov 26 16:11:29 localhost kernel: [<c0131457>] zap_pte_range [kernel] 0x137
(0xc479be34))
Nov 26 16:11:29 localhost kernel: [<c01199a3>] sys_sched_yield [kernel] 0x73
(0xc479be44))
Nov 26 16:11:30 localhost kernel: [<c012f45b>] zap_page_range [kernel] 0xcb
(0xc479be5c))
Nov 26 16:11:30 localhost kernel: [<c01329df>] exit_mmap [kernel] 0xaf
(0xc479be9c))
Nov 26 16:11:31 localhost kernel: [<c011a42a>] mmput [kernel] 0x4a
(0xc479bec0))
Nov 26 16:11:31 localhost kernel: [<c011f911>] do_exit [kernel] 0xf1
(0xc479bed0))
Nov 26 16:11:32 localhost kernel: [<c011fbb4>] do_group_exit [kernel] 0x54
(0xc479beec))
Nov 26 16:11:32 localhost kernel: [<c0127b85>] get_signal_to_deliver [kernel]
0x195 (0xc479befc))
Nov 26 16:11:33 localhost kernel: [<c01092f4>] do_signal [kernel] 0x64
(0xc479bf20))
Nov 26 16:11:34 localhost kernel: [<c0128147>] sys_kill [kernel] 0x57
(0xc479bf30))
Nov 26 16:11:34 localhost kernel: [<c01484f5>] fput [kernel] 0xd5
(0xc479bf7c))
Nov 26 16:11:34 localhost kernel: [<c0127d68>] sys_rt_sigprocmask [kernel]
0xc8 (0xc479bf90))
Nov 26 16:11:35 localhost kernel: [<c0109578>] signal_return [kernel] 0x14
(0xc479bfc0))
Nov 26 16:11:35 localhost kernel: 
Nov 26 16:11:36 localhost kernel: 
Nov 26 16:11:36 localhost kernel: Code: 0f 0b 8b 00 6a 1a 26 c0 b8 02 00 00
00 0f b3 43 18 b8 04 00 



26 21:39:02 localhost kernel:  <6>cdrom: This disc doesn't have any tracks I
recognize!
Nov 26 21:39:23 localhost kernel: Page has mapping still set. This is a
serious situation. However if you 
Nov 26 21:39:23 localhost kernel: are using the NVidia binary only module
please report this bug to 
Nov 26 21:39:23 localhost kernel: NVidia and not to the linux kernel
mailinglist.
Nov 26 21:39:23 localhost kernel: ------------[ cut here ]------------
Nov 26 21:39:23 localhost kernel: kernel BUG at page_alloc.c:122!
Nov 26 21:39:23 localhost kernel: invalid operand: 0000
Nov 26 21:39:23 localhost kernel: soundcore ide-cd cdrom parport_pc lp
parport autofs tulip e100 ipt_REJECT iptable_filter ip_tables microcode
keybdev mousedev hid input usb-uhci usbcore ext3 
Nov 26 21:39:23 localhost kernel: CPU:    0
Nov 26 21:39:23 localhost kernel: EIP:    0060:[<c013eb73>]    Not tainted
Nov 26 21:39:23 localhost kernel: EFLAGS: 00210286
Nov 26 21:43:23 localhost syslogd 1.4.1: restart.
Nov 26 21:43:23 localhost syslog: syslogd startup succeeded
Nov 26 21:43:23 localhost kernel: klogd 1.4.1, log source = /proc/kmsg
started.

Any thoughts on what to try?

Thanks,
Eric


__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
