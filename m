Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbTBKUpy>; Tue, 11 Feb 2003 15:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTBKUpy>; Tue, 11 Feb 2003 15:45:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266228AbTBKUpx>; Tue, 11 Feb 2003 15:45:53 -0500
Date: Tue, 11 Feb 2003 15:55:43 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Panic `cat /proc/ioports`
Message-ID: <Pine.LNX.3.95.1030211155003.2868A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.4.18, after it runs for a few days, will panic
if I do `cat /proc/ioports`. Has this been reported/fixed in
later versions?

: Unable to handle kernel paging request at virtual address d48e2fa0 
: c01d0ecb 
: *pde = 13c22067 
: Oops: 0000 
: CPU:    0 
: EIP:    0010:[3c59x:__insmod_3c59x_O/lib/modules/2.4.18/kernel/drivers/net/3c59+-342778165/84]    Not tainted 
: EFLAGS: 00010297 
: eax: d48e2fa0   ebx: ffffffff   ecx: d48e2fa0   edx: fffffffe 
: esi: d22b70b9   edi: ffffffff   ebp: 00000000   esp: d0a41e90 
: ds: 0018   es: 0018   ss: 0018 
: Process cat (pid: 15481, stackpage=d0a41000) 
: Stack: d22b70ad d2fce2c0 00000300 00000008 c01daa26 00000001 d32c19b0 c0123303  
:        d0a2a6c0 d32c19b0 cfc97064 00000001 0000004e 00000000 ffffffff 0000000a  
:        c01d118e d22b70ad 2dd48f53 c01daa26 d0a41f0c c01d11a8 d22b70ad c01daa17  
: Call Trace: [3c59x:__insmod_3c59x_O/lib/modules/2.4.18/kernel/drivers/net/3c59+-343489789/84] [3c59x:__insmod_3c59x_O/lib/modules/2.4.18/kernel/drivers/net/3c59+-342777458/84] [3c59x:__insmod_3c59x_O/lib/modules/2.4.18/kernel
/drivers/net/3c59+-342777432/84] [3c59x:__insmod_3c59x_O/lib/modules/2.4.18/kernel/drivers/net/3c59+-343526992/84] [3c59x:__insmod_3c59x_O/lib/modules/2.4.18/kernel/drivers/net/3c59+-343526874/84]  
: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 89 c7 f7 c5 10 00  

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	80 38 00             	cmpb   $0x0,(%eax) <===
Code:  00000003 Before first symbol               3:	74 07                	je      0000000c Before first symbol
Code:  00000005 Before first symbol               5:	40                   	inc    %eax
Code:  00000006 Before first symbol               6:	4a                   	dec    %edx
Code:  00000007 Before first symbol               7:	83 fa ff             	cmp    $0xffffffff,%edx
Code:  0000000a Before first symbol               a:	75 f4                	jne    0 <_IP>
Code:  0000000c Before first symbol               c:	29 c8                	sub    %ecx,%eax
Code:  0000000e Before first symbol               e:	89 c7                	mov    %eax,%edi
Code:  00000010 Before first symbol              10:	f7 c5 10 00 00 00    	test   $0x10,%ebp


25 warnings issued.  Results may not be reliable.

`insmod` was not being executed even though the trace pretends
that it was active.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


