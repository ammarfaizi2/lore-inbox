Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317031AbSFGRke>; Fri, 7 Jun 2002 13:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317307AbSFGRkd>; Fri, 7 Jun 2002 13:40:33 -0400
Received: from exchange.ignitemedia.com ([207.24.163.39]:35619 "EHLO
	ignitemedia.com") by vger.kernel.org with ESMTP id <S317031AbSFGRkc> convert rfc822-to-8bit;
	Fri, 7 Jun 2002 13:40:32 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: kernel meltdown
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Fri, 7 Jun 2002 12:36:11 -0500
Message-ID: <D466FBEAA19E7E408BE3FAAC6EEB567601820186@utah.ignitemedia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel meltdown
Thread-Index: AcIOSnZa8MKrD+AGREqCmxVVKOtM0A==
From: "Anna Riley" <ariley@ignitesports.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
	I am hoping someone can help me.  This morning one of our web servers crapped itself and I don't know why.  It's running RedHat 7.2 kernel version 2.4.9-31smp.  I couldn't login from the console so I had to reset it.  When it came back up it was fine.  This is what I am seeing in the messages log:


Jun  7 02:57:43 web02 kernel: kernel BUG at slab.c:1767!
Jun  7 02:57:43 web02 kernel: invalid operand: 0000
Jun  7 02:57:43 web02 kernel: Kernel 2.4.9-31smp
Jun  7 02:57:43 web02 kernel: CPU:    0
Jun  7 02:57:43 web02 kernel: EIP:    0010:[kmem_cache_reap+504/912]    Not tainted
Jun  7 02:57:43 web02 kernel: EIP:    0010:[<c0133d08>]    Not tainted
Jun  7 02:57:43 web02 kernel: EFLAGS: 00010092
Jun  7 02:57:43 web02 kernel: EIP is at kmem_cache_reap [kernel] 0x1f8 
Jun  7 02:57:43 web02 kernel: eax: 0000001b   ebx: e2c34000   ecx: c02db9e4   edx: 00003906
Jun  7 02:57:43 web02 kernel: esi: c1b8f9e8   edi: c1b8f9f8   ebp: 00000000   esp: e3fedf8c
Jun  7 02:57:43 web02 kernel: ds: 0018   es: 0018   ss: 0018
Jun  7 02:57:43 web02 kernel: Process kswapd (pid: 5, stackpage=e3fed000)
Jun  7 02:57:43 web02 kernel: Stack: c024f253 000006e7 00000d80 c1b8f9f8 c1b8f9f0 00000183 e3f9d000 0000000a 
Jun  7 02:57:43 web02 kernel:        00000000 00000000 00000000 00000183 000000c0 000000c0 0008e000 c0136076 
Jun  7 02:57:43 web02 kernel:        000000c0 e3fec000 00000006 c01360d5 000000c0 00000000 00010f00 c1d9ffb8 
Jun  7 02:57:43 web02 kernel: Call Trace: [call_spurious_interrupt+130654/156203] .rodata.str1.1 [kernel] 0x2a8e 
Jun  7 02:57:43 web02 kernel: Call Trace: [<c024f253>] .rodata.str1.1 [kernel] 0x2a8e 
Jun  7 02:57:43 web02 kernel: [do_try_to_free_pages+70/80] do_try_to_free_pages [kernel] 0x46 
Jun  7 02:57:43 web02 kernel: [<c0136076>] do_try_to_free_pages [kernel] 0x46 
Jun  7 02:57:43 web02 kernel: [kswapd+85/240] kswapd [kernel] 0x55 
Jun  7 02:57:43 web02 kernel: [<c01360d5>] kswapd [kernel] 0x55 
Jun  7 02:57:43 web02 kernel: [_stext+0/96] stext [kernel] 0x0 
Jun  7 02:57:43 web02 kernel: [<c0105000>] stext [kernel] 0x0 
Jun  7 02:57:43 web02 kernel: [kernel_thread+38/48] kernel_thread [kernel] 0x26 
Jun  7 02:57:43 web02 kernel: [<c0105866>] kernel_thread [kernel] 0x26 
Jun  7 02:57:43 web02 kernel: [kswapd+0/240] kswapd [kernel] 0x0 
Jun  7 02:57:43 web02 kernel: [<c0136080>] kswapd [kernel] 0x0 
Jun  7 02:57:43 web02 kernel: 
Jun  7 02:57:43 web02 kernel: 
Jun  7 02:57:43 web02 kernel: Code: 0f 0b 58 5a 8b 03 45 39 f8 75 dd 8b 4e 2c 89 ea 8b 7e 4c d3 


I have searched on google for some of these messages but I couldn't find anything helpful.  Any help or direction would be apprecaited. 

I am not subscribed to this list so email to me directly would be great.  If I am mailing to the wrong list my apologies.

Thanks so much all!

-anna
