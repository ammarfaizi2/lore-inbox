Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbRGHJNh>; Sun, 8 Jul 2001 05:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266830AbRGHJN1>; Sun, 8 Jul 2001 05:13:27 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:23459 "HELO
	smtp2.pandora.be") by vger.kernel.org with SMTP id <S266797AbRGHJNO>;
	Sun, 8 Jul 2001 05:13:14 -0400
Subject: Invalid operand messages in 2.4.5-ac24
From: Roel Teuwen <Roel.Teuwen@advalvas.be>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-fgJ67ICIEyGkX1qNqbgC"
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 08 Jul 2001 11:12:39 +0200
Message-Id: <994583559.1250.2.camel@Terra>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fgJ67ICIEyGkX1qNqbgC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

yesterday I compiled and booted 2.4.5-ac24 and got several 'invalid
operand' messages in the syslog. I have attached two, decoded with
klogd.

I have only seen these with -ac24, -ac22 was fine (skipped ac23), and I
have yet to see them with 2.4.6-ac1.

I am not sure what would cause these errors, but I do know they appear
in -ac24 only, relatively quickly.

Hope this helps,
kind regards,

Roel Teuwen

--=-fgJ67ICIEyGkX1qNqbgC
Content-ID: <994583431.1162.0.camel@Terra>
Content-Description: 
Content-Type: text/plain
Content-Disposition: attachment; filename=operand_kswapd
Content-Transfer-Encoding: 7bit

Jul  7 14:55:43 Terra kernel:  invalid operand: 0000
Jul  7 14:55:43 Terra kernel: CPU:    0
Jul  7 14:55:43 Terra kernel: EIP:    0010:[deactivate_page_nolock+144/240]
Jul  7 14:55:43 Terra kernel: EFLAGS: 00010246
Jul  7 14:55:43 Terra kernel: eax: 00000000   ebx: c11d8b0c   ecx: c11d8af0   edx: c119ffac
Jul  7 14:55:43 Terra kernel: esi: c11d8af0   edi: 00000074   ebp: 00000030   esp: cbffbfb0
Jul  7 14:55:43 Terra kernel: ds: 0018   es: 0018   ss: 0018
Jul  7 14:55:43 Terra kernel: Process kswapd (pid: 3, stackpage=cbffb000)
Jul  7 14:55:43 Terra kernel: Stack: c01280c0 c11d8af0 00000000 000000c0 00000000 0008e000 c01283fa 00000006
Jul  7 14:55:43 Terra kernel:        00000000 c0105000 0008e000 00000000 00000018 00010f00 c13c7fb8 c0105000
Jul  7 14:55:43 Terra kernel:        c01054e6 00000000 c0128370 c0233fd8
Jul  7 14:55:43 Terra kernel: Call Trace: [refill_inactive_scan+144/256] [kswapd+138/240] [stext+0/48] [stext+0/48] [kernel_thread+38/48]
Jul  7 14:55:43 Terra kernel:    [kswapd+0/240]
Jul  7 14:55:43 Terra kernel:
Jul  7 14:55:43 Terra kernel: Code: 0f 0b 8b 41 18 83 e0 40 75 14 8b 41 18 a9 80 00 00 00 75 0a

--=-fgJ67ICIEyGkX1qNqbgC
Content-Type: text/plain
Content-Disposition: attachment; filename=operand_make
Content-ID: <994583435.1162.1.camel@Terra>
Content-Transfer-Encoding: 7bit

Jul  7 15:11:06 Terra kernel:  invalid operand: 0000
Jul  7 15:11:06 Terra kernel: CPU:    0
Jul  7 15:11:06 Terra kernel: EIP:    0010:[deactivate_page_nolock+144/240]
Jul  7 15:11:06 Terra kernel: EFLAGS: 00010246
Jul  7 15:11:06 Terra kernel: eax: 00000000   ebx: c117679c   ecx: c1176780   edx: c112b014
Jul  7 15:11:06 Terra kernel: esi: c1176780   edi: 000001eb   ebp: 00000001   esp: c7817e00
Jul  7 15:11:06 Terra kernel: ds: 0018   es: 0018   ss: 0018
Jul  7 15:11:06 Terra kernel: Process make (pid: 1054, stackpage=c7817000)
Jul  7 15:11:06 Terra kernel: Stack: c01280c0 c1176780 00000010 c7816000 00000006 00000010 c01282df 00000006
Jul  7 15:11:06 Terra kernel:        00000010 00000006 000000d2 000000d2 000000da 00000001 000000d2 c0128352
Jul  7 15:11:06 Terra kernel:        000000d2 00000001 c7816000 00000010 00000000 c01284b8 000000d2 00000001
Jul  7 15:11:06 Terra kernel: Call Trace: [refill_inactive_scan+144/256] [refill_inactive+127/176] [do_try_to_free_pages+66/96] [try_to_free_pages+40/64] [__alloc_pages+414/544]
Jul  7 15:11:06 Terra kernel:    [do_anonymous_page+54/144] [do_no_page+48/192]
[handle_mm_fault+101/224] [file_read_actor+46/96] [do_page_fault+0/1168] [do_page_fault+378/1168]
Jul  7 15:11:06 Terra kernel:    [do_munmap+100/608] [do_timer+50/80] [timer_bh+36/592] [do_brk+180/352] [sys_brk+169/224] [do_page_fault+0/1168]
Jul  7 15:11:07 Terra kernel:    [error_code+56/64]
Jul  7 15:11:07 Terra kernel:
Jul  7 15:11:07 Terra kernel: Code: 0f 0b 8b 41 18 83 e0 40 75 14 8b 41 18 a9 80 00 00 00 75 0a

--=-fgJ67ICIEyGkX1qNqbgC--

