Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTL3E3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTL3E3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:29:09 -0500
Received: from WILBUR.CONTACTOFFICE.NET ([212.3.242.68]:9223 "EHLO
	wilbur.contactoffice.com") by vger.kernel.org with ESMTP
	id S264386AbTL3E3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:29:02 -0500
Message-ID: <26530865.1072758531296.JavaMail.Administrator@pumbaa>
Date: Tue, 30 Dec 2003 05:28:51 +0100 (CET)
From: IP v6 <inet6@mail.be>
Reply-To: IP v6 <inet6@mail.be>
To: linux-kernel@vger.kernel.org
Subject: kernel: kernel BUG at vmscan.c:389!
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, I've googled about the error in the subject but can't find anything about it,
I seem to be the only one having this?

Since I couldn't find anything in Google I am mailing it to this list.

I'm having this for the second time and needed to reboot the box and I don't know how to reproduce this.

The kernel version is 2.4.24-pre2 with some netfilter pom patches and lufs patch
and the CPU is a Cyrix 6x86L 150MHz
I believe this was the reason why I decided to upgrade to 2.4.24-pre2 from 2.4.23 but I'm not sure anymore, I forgot...
Anyway I'm compiling 2.4.23 again now, as this may not happen when I'm out partying for newyear ;)

Here is a *small* portion of the messages in /var/log/messages
(there is more but the mail would be too long to include them all :)).
I hope someone can do anything with this and help me. Thanks.


Dec 30 02:34:43 core1-fe0-gw1 kernel: kernel BUG at vmscan.c:389!
Dec 30 02:34:43 core1-fe0-gw1 kernel: invalid operand: 0000
Dec 30 02:34:43 core1-fe0-gw1 kernel: CPU:    0
Dec 30 02:34:43 core1-fe0-gw1 kernel: EIP:    0010:[<c012d240>]    Tainted: P
Dec 30 02:34:43 core1-fe0-gw1 kernel: EFLAGS: 00010202
Dec 30 02:34:43 core1-fe0-gw1 kernel: eax: 000000c4   ebx: c10215e4   ecx: 00002dd9   edx: c1160000
Dec 30 02:34:43 core1-fe0-gw1 kernel: esi: c10215c8   edi: 00000000   ebp: 00000005   esp: c1161f30
Dec 30 02:34:43 core1-fe0-gw1 kernel: ds: 0018   es: 0018   ss: 0018
Dec 30 02:34:43 core1-fe0-gw1 kernel: Process kswapd (pid: 4, stackpage=c1161000)
Dec 30 02:34:43 core1-fe0-gw1 kernel: Stack: c1160000 00000bf2 00000a31 000001d0 c028c998 c2cf6fe0 c105a460 c012d632
Dec 30 02:34:43 core1-fe0-gw1 kernel:        c105a460 00000020 000001d0 c028c998 00000000 c012d6cf c1161f88 0000003c
Dec 30 02:34:43 core1-fe0-gw1 kernel:        000001d0 00000020 c012d732 c1161f88 c1161f88 c028c998 00000000 c028c998
Dec 30 02:34:43 core1-fe0-gw1 kernel: Call Trace:    [<c012d632>] [<c012d6cf>] [<c012d732>] [<c012d8ec>] [<c012d956>]
Dec 30 02:34:43 core1-fe0-gw1 kernel:   [<c012da91>] [<c012d9f0>] [<c0105000>] [<c0107156>] [<c012d9f0>]
Dec 30 02:34:43 core1-fe0-gw1 kernel:
Dec 30 02:34:43 core1-fe0-gw1 kernel: Code: 0f 0b 85 01 26 f5 25 c0 8b 03 8b 53 04 31 ff 89 50 04 89 02
Dec 30 02:34:44 core1-fe0-gw1 kernel:  kernel BUG at vmscan.c:389!
Dec 30 02:34:44 core1-fe0-gw1 kernel: invalid operand: 0000
Dec 30 02:34:44 core1-fe0-gw1 kernel: CPU:    0
Dec 30 02:34:44 core1-fe0-gw1 kernel: EIP:    0010:[<c012d240>]    Tainted: P
Dec 30 02:34:44 core1-fe0-gw1 kernel: EFLAGS: 00010202
Dec 30 02:34:44 core1-fe0-gw1 kernel: eax: 000000c4   ebx: c10215e4   ecx: 00002f09   edx: c5c62000
Dec 30 02:34:44 core1-fe0-gw1 kernel: esi: c10215c8   edi: c028c998   ebp: 00000020   esp: c5c63dc0
Dec 30 02:34:44 core1-fe0-gw1 kernel: ds: 0018   es: 0018   ss: 0018
Dec 30 02:34:44 core1-fe0-gw1 kernel: Process up2date (pid: 17790, stackpage=c5c63000)
Dec 30 02:34:44 core1-fe0-gw1 kernel: Stack: c5c62000 00000c80 00000b08 000001d2 c028c998 c01bb570 c1084bf8 c012d632
Dec 30 02:34:44 core1-fe0-gw1 kernel:        c1084bf8 00000020 000001d2 c028c998 00000000 c012d6cf c5c63e18 0000003c
Dec 30 02:34:44 core1-fe0-gw1 kernel:        000001d2 00000020 c012d732 c5c63e18 c5c63e18 c028c998 00000000 00000000
Dec 30 02:34:44 core1-fe0-gw1 kernel: Call Trace:    [<c01bb570>] [<c012d632>] [<c012d6cf>] [<c012d732>] [<c012e2ed>]
Dec 30 02:34:44 core1-fe0-gw1 kernel:   [<c012e67a>] [<c01b6f5f>] [<c0123f02>] [<c0124014>] [<c0124218>] [<c0112789>]
Dec 30 02:34:44 core1-fe0-gw1 kernel:   [<c010d6bd>] [<c0107440>] [<c0113894>] [<c0112600>] [<c0108a24>]
Dec 30 02:34:44 core1-fe0-gw1 kernel:
Dec 30 02:34:44 core1-fe0-gw1 kernel: Code: 0f 0b 85 01 26 f5 25 c0 8b 03 8b 53 04 31 ff 89 50 04 89 02
Dec 30 02:34:56 core1-fe0-gw1 kernel:  kernel BUG at vmscan.c:389!
Dec 30 02:34:56 core1-fe0-gw1 kernel: invalid operand: 0000
Dec 30 02:34:56 core1-fe0-gw1 kernel: CPU:    0
Dec 30 02:34:56 core1-fe0-gw1 kernel: EIP:    0010:[<c012d240>]    Tainted: P
Dec 30 02:34:56 core1-fe0-gw1 kernel: EFLAGS: 00010202
Dec 30 02:34:56 core1-fe0-gw1 kernel: eax: 000000c4   ebx: c10215e4   ecx: 000028e0   edx: c2284000
Dec 30 02:34:56 core1-fe0-gw1 kernel: esi: c10215c8   edi: c028c998   ebp: 00000020   esp: c2285dc0
Dec 30 02:34:56 core1-fe0-gw1 kernel: ds: 0018   es: 0018   ss: 0018
Dec 30 02:34:56 core1-fe0-gw1 kernel: Process up2date (pid: 17792, stackpage=c2285000)
Dec 30 02:34:56 core1-fe0-gw1 kernel: Stack: c2284000 00000c80 00000b07 000001d2 c028c998 c2285de0 c10c62dc c012d632
Dec 30 02:34:56 core1-fe0-gw1 kernel:        c10c62dc 00000020 000001d2 c028c998 00000000 c012d6cf c2285e18 0000003c
Dec 30 02:34:56 core1-fe0-gw1 kernel:        000001d2 00000020 c012d732 c2285e18 c2285e18 c028c998 00000000 00000000
Dec 30 02:34:56 core1-fe0-gw1 kernel: Call Trace:    [<c012d632>] [<c012d6cf>] [<c012d732>] [<c012e2ed>] [<c012e67a>]
Dec 30 02:34:56 core1-fe0-gw1 kernel:   [<c0123f02>] [<c0124014>] [<c0124218>] [<c0126f1f>] [<c0127145>] [<c0112789>]
Dec 30 02:34:56 core1-fe0-gw1 kernel:   [<c0134d1d>] [<c0107440>] [<c012459c>] [<c0112600>] [<c0108a24>]
Dec 30 02:34:56 core1-fe0-gw1 kernel:
Dec 30 02:34:56 core1-fe0-gw1 kernel: Code: 0f 0b 85 01 26 f5 25 c0 8b 03 8b 53 04 31 ff 89 50 04 89 02
-----------------------------------------------------
Mail.be, WebMail and Virtual Office
http://www.mail.be

