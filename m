Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTIAPHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 11:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTIAPHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 11:07:08 -0400
Received: from vsmtp2.tin.it ([212.216.176.222]:35210 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S262918AbTIAPHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 11:07:01 -0400
Message-ID: <00f601c3709a$bcc50990$0200a8c0@yakuzad6e0kj9b>
From: "Juri Bracchi Tkachenok" <yakuza@ircitalia.net>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG at rmap.c:398
Date: Mon, 1 Sep 2003 17:07:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sep  1 06:22:39 serv1 kernel: ------------[ cut here ]------------
Sep  1 06:22:39 serv1 kernel: kernel BUG at rmap.c:398!
Sep  1 06:22:39 serv1 kernel: invalid operand: 0000
Sep  1 06:22:39 serv1 kernel: ipv6 autofs eepro100 mii ext3 jbd usb-uhci
usbcore
Sep  1 06:22:39 serv1 kernel: CPU:    0
Sep  1 06:22:39 serv1 kernel: EIP:    0010:[try_to_unmap_one+66/224]    Not
tainted
Sep  1 06:22:39 serv1 kernel: EFLAGS: 00010246
Sep  1 06:22:39 serv1 kernel:
Sep  1 06:22:39 serv1 kernel: EIP is at try_to_unmap_one [kernel] 0x42
(2.4.20-19.7custom)
Sep  1 06:22:39 serv1 kernel: eax: c100000c   ebx: 00200000   ecx: 00000000
edx: c1d0000c
Sep  1 06:22:39 serv1 kernel: esi: 00200000   edi: e5924b00   ebp: 00000000
esp: c33ddf20
Sep  1 06:22:39 serv1 kernel: ds: 0018   es: 0018   ss: 0018
Sep  1 06:22:39 serv1 kernel: Process kswapd (pid: 5, stackpage=c33dd000)
Sep  1 06:22:39 serv1 kernel: Stack: 032e1200 00000800 c115f520 c115f520
c115f520 e5924b00 e5924b00 00000008
Sep  1 06:22:39 serv1 kernel:        c01398df 032e1200 c115f520 00000020
00000008 00000000 00000000 c115f520
Sep  1 06:22:39 serv1 kernel:        c115f520 00000000 000001d0 c0131047
00000001 00000367 c02da628 00000098
Sep  1 06:22:39 serv1 kernel: Call Trace:   [try_to_unmap+191/384]
try_to_unmap [kernel] 0xbf (0xc33ddf40))
Sep  1 06:22:39 serv1 kernel: [launder_page+1143/1696] launder_page [kernel]
0x477 (0xc33ddf6c))
Sep  1 06:22:39 serv1 kernel: [rebalance_dirty_zone+90/144]
rebalance_dirty_zone [kernel] 0x5a (0xc33ddf84))
Sep  1 06:22:39 serv1 kernel: [do_try_to_free_pages_kswapd+108/784]
do_try_to_free_pages_kswapd [kernel] 0x6c (0xc33ddfa4))
Sep  1 06:22:39 serv1 kernel: [kswapd+321/1248] kswapd [kernel] 0x141
(0xc33ddfd4))
Sep  1 06:22:39 serv1 kernel: [_stext+0/48] stext [kernel] 0x0 (0xc33ddfe8))
Sep  1 06:22:39 serv1 kernel: [arch_kernel_thread+38/48] arch_kernel_thread
[kernel] 0x26 (0xc33ddff0))
Sep  1 06:22:39 serv1 kernel: [kswapd+0/1248] kswapd [kernel] 0x0
(0xc33ddff8))
Sep  1 06:22:39 serv1 kernel:
Sep  1 06:22:39 serv1 kernel:
Sep  1 06:22:39 serv1 kernel: Code: 0f 0b 8e 01 56 07 23 c0 56 55 e8 ef e6
fe ff 59 89 c7 85 ff



after this my server is crash.

I have  2.4.20-19.7 RedHat Kernel

in witch mode a fix it ??

if i update to 2.4.22 from source this bug is fix ?? of this is any patch to
add to kernel ?

why is generate this error ? (any modules ?)
if i disable it, the error go away?


Juri Bracchi
Extracon.it Hosting Solution




