Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLEAcv>; Mon, 4 Dec 2000 19:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQLEAcb>; Mon, 4 Dec 2000 19:32:31 -0500
Received: from [213.157.1.114] ([213.157.1.114]:14084 "EHLO server.dreamind")
	by vger.kernel.org with ESMTP id <S129248AbQLEAcV>;
	Mon, 4 Dec 2000 19:32:21 -0500
Date: Tue, 5 Dec 2000 01:04:05 +0100 (CET)
From: Stefan Pfetzing <dreamind@dreamind.yi.org>
To: linux-kernel@vger.kernel.org
Subject: Posible Bug at page_alloc.c in the [2.4.0-test11] kernel
Message-ID: <Pine.LNX.4.21.0012050048090.930-100000@server.dreamind>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think i possibly foun a Bug in the Linux Kernel 2.4.0-test11.
I patched the kernel with the bttv driver 7.49 but nothing else.
My system was up for 5 1/2 days and than it crashed.

I have a Pentium 200MMX (overclocked to 225 but I REALLY don't think that's
the problem, because it worked fine with other Kernels.), a Asus TX97 Board,
64MB Ram, an Nvidia Riva 128 graphics card, a Hauppauge TV Card, a AVM Isdn Card,
a Symbios Logic SCSI Card and of course a D-Link network card (tulip based).
I also have several Usb devices attached (Monitor, Keyboard and Mouse)

At the moment when the kernel crashed, I was online (via ISDN) and I just closed
xawv (tv viewing program) and started playing a mp3 via mp3blaster.
(hope this information isn't too accurate)

/var/log/messages:
---snipp---
Dec  4 23:50:57 server kernel: kernel BUG at page_alloc.c:84!
Dec  4 23:50:57 server kernel: invalid operand: 0000
Dec  4 23:50:57 server kernel: CPU:    0
Dec  4 23:50:57 server kernel: EIP:    0010:[__free_pages_ok+73/892]
Dec  4 23:50:57 server kernel: EFLAGS: 00010286
Dec  4 23:50:57 server kernel: eax: 0000001f   ebx: c1013210   ecx: 00000000   edx: 00000000
Dec  4 23:50:57 server kernel: esi: c1013238   edi: 00000000   ebp: 0000001e   esp: c1165f64
Dec  4 23:50:57 server kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 23:50:57 server kernel: Process kswapd (pid: 3, stackpage=c1165000)
Dec  4 23:50:57 server kernel: Stack: c01df9a5 c01dfb73 00000054 c1013210 c1013238 00000091 0000001e 00000091 
Dec  4 23:50:57 server kernel:        0000001d 00000000 00000003 c0128882 c012a127 c0128a69 00000000 00000004 
Dec  4 23:50:57 server kernel:        00000000 00000000 00000000 00000004 00000000 00000000 c01290d0 00000004 
Dec  4 23:50:57 server kernel: Call Trace: [tvecs+7389/60504] [tvecs+7851/60504] [page_launder+670/1900] [__free_pa
Dec  4 23:50:57 server kernel:        [kswapd+115/316] [kernel_thread+40/56] 
Dec  4 23:50:57 server kernel: Code: 0f 0b 83 c4 0c 89 f6 89 da 2b 15 b8 fd 26 c0 89 d0 c1 e0 04 
Dec  4 23:51:23 server kernel: kernel BUG at vmscan.c:533!
Dec  4 23:51:23 server kernel: invalid operand: 0000
Dec  4 23:51:23 server kernel: CPU:    0
Dec  4 23:51:23 server kernel: EIP:    0010:[reclaim_page+901/988]
Dec  4 23:51:23 server kernel: EFLAGS: 00010286
Dec  4 23:51:23 server kernel: eax: 0000001c   ebx: c101322c   ecx: 00000000   edx: 00000010
Dec  4 23:51:23 server kernel: esi: c1013210   edi: c06ab5bc   ebp: 00000000   esp: c3491e10
Dec  4 23:51:23 server kernel: esi: c1013210   edi: c06ab5bc   ebp: 00000000   esp: c3491e10
Dec  4 23:51:23 server kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 23:51:23 server kernel: Process xglobe (pid: 14216, stackpage=c3491000)
Dec  4 23:51:23 server kernel: Stack: c01df405 c01df5c4 00000215 c020e6e0 c020e974 00000000 00000000 c0129dc8 
Dec  4 23:51:23 server kernel:        c020e6e0 00000000 c020e978 00000000 00000001 c0129f83 c020e96c 00000000 
Dec  4 23:51:23 server kernel:        00000000 00000001 00000000 c1024188 000000a3 c1a79bbc 00000005 00000001 
Dec  4 23:51:23 server kernel: Call Trace: [tvecs+5949/60504] [tvecs+6396/60504] [__alloc_pages_limit+124/172] [__a
Dec  4 23:51:23 server kernel:        [handle_mm_fault+232/340] [do_page_fault+311/1004] [do_page_fault+0/1004] [do
Dec  4 23:51:23 server kernel: Code: 0f 0b 83 c4 0c 31 c0 0f b3 46 18 8d 5e 28 8d 46 2c 39 46 2c 
Dec  4 23:55:00 server /USR/SBIN/CRON[14222]: (root) CMD ( ping www.heise.de -c1 >/dev/null ) 
Dec  4 23:55:43 server kernel: usb-uhci.c: interrupt, status 3, frame# 100
---snipp---

If i forgot anything (kernel config or anything else please mail me.

And please also mail to my address in replys because I am NOT suscribed to the mailing list.

thanx

dreamind


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
