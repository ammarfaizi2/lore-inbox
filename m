Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263388AbTDCNKY>; Thu, 3 Apr 2003 08:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263389AbTDCNKX>; Thu, 3 Apr 2003 08:10:23 -0500
Received: from fionet.com ([217.172.181.68]:44455 "EHLO service")
	by vger.kernel.org with ESMTP id <S263388AbTDCNKW>;
	Thu, 3 Apr 2003 08:10:22 -0500
Subject: Re: System time warping around real time problem - please help
From: Fionn Behrens <mail@fionn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, george anzinger <george@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049376145.29020.216.camel@rtfm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Apr 2003 15:22:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I had the system running about a week with "notsc" AND no power
management. No system crashes so far. Nevertheless, I keep getting some
kernel oopses like this from time to time. The call trace suggests that
there is still an issue with timing.

Apr  3 15:09:51 rtfm kernel:  printing eip:
Apr  3 15:09:51 rtfm kernel: 49199fd0
Apr  3 15:09:51 rtfm kernel: *pde = 00000000
Apr  3 15:09:51 rtfm kernel: Oops: 0000
Apr  3 15:09:51 rtfm kernel: CPU:    0
Apr  3 15:09:51 rtfm kernel: EIP:    0010:[<49199fd0>]    Tainted: P 
Apr  3 15:09:51 rtfm kernel: EFLAGS: 00210287
Apr  3 15:09:51 rtfm kernel: eax: 3e8c329f   ebx: cfd15fac   ecx:
054f7f1e   edx: 000e213f
Apr  3 15:09:51 rtfm kernel: esi: bffffa50   edi: 00000000   ebp:
bffffa58   esp: cfd15f9c
Apr  3 15:09:51 rtfm kernel: ds: 0018   es: 0018   ss: 0018
Apr  3 15:09:51 rtfm kernel: Process lmule (pid: 27969,
stackpage=cfd15000)
Apr  3 15:09:51 rtfm kernel: Stack: c0122b4b bffffa50 cfd15fac 00000008
3e8c329f 000e213f cfd14000 bffffa50 
Apr  3 15:09:51 rtfm kernel:        bffffab0 c01091ff bffffa50 00000000
408584d4 bffffa50 bffffab0 bffffa58 
Apr  3 15:09:51 rtfm kernel:        0000004e 0000002b 0000002b 0000004e
40655501 00000023 00200287 bffffa1c 
Apr  3 15:09:51 rtfm kernel: Call Trace:    [sys_gettimeofday+59/128]
[system_call+51/56]
Apr  3 15:09:51 rtfm kernel: 
Apr  3 15:09:51 rtfm kernel: Code:  Bad EIP value.


Do you have any more ideas regarding this issue? I'd hate trying to send
the board in for a check...

Regards,
	Fionn (not subscribed to lklm)
