Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316794AbSFJJPh>; Mon, 10 Jun 2002 05:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSFJJPg>; Mon, 10 Jun 2002 05:15:36 -0400
Received: from [213.38.169.194] ([213.38.169.194]:59653 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S316794AbSFJJPe>; Mon, 10 Jun 2002 05:15:34 -0400
Message-ID: <AFE36742FF57D411862500508BDE8DD004639F24@cordelia.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: "'Anna Riley'" <ariley@ignitesports.com>, linux-kernel@vger.kernel.org
Subject: RE: kernel meltdown
Date: Mon, 10 Jun 2002 10:20:57 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RedHat have released an updated kernel (2.4.9-34).

Does this help?

---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK 

> -----Original Message-----
> From: Anna Riley [mailto:ariley@ignitesports.com]
> Sent: 07 June 2002 18:36
> To: linux-kernel@vger.kernel.org
> Subject: kernel meltdown
> 
> 
> Hi there,
> 	I am hoping someone can help me.  This morning one of 
> our web servers crapped itself and I don't know why.  It's 
> running RedHat 7.2 kernel version 2.4.9-31smp.  I couldn't 
> login from the console so I had to reset it.  When it came 
> back up it was fine.  This is what I am seeing in the messages log:
> 
> 
> Jun  7 02:57:43 web02 kernel: kernel BUG at slab.c:1767!
> Jun  7 02:57:43 web02 kernel: invalid operand: 0000
> Jun  7 02:57:43 web02 kernel: Kernel 2.4.9-31smp
> Jun  7 02:57:43 web02 kernel: CPU:    0
> Jun  7 02:57:43 web02 kernel: EIP:    
> 0010:[kmem_cache_reap+504/912]    Not tainted
> Jun  7 02:57:43 web02 kernel: EIP:    0010:[<c0133d08>]    Not tainted
> Jun  7 02:57:43 web02 kernel: EFLAGS: 00010092
> Jun  7 02:57:43 web02 kernel: EIP is at kmem_cache_reap 
> [kernel] 0x1f8 
> Jun  7 02:57:43 web02 kernel: eax: 0000001b   ebx: e2c34000   
> ecx: c02db9e4   edx: 00003906
> Jun  7 02:57:43 web02 kernel: esi: c1b8f9e8   edi: c1b8f9f8   
> ebp: 00000000   esp: e3fedf8c
> Jun  7 02:57:43 web02 kernel: ds: 0018   es: 0018   ss: 0018
> Jun  7 02:57:43 web02 kernel: Process kswapd (pid: 5, 
> stackpage=e3fed000)
> Jun  7 02:57:43 web02 kernel: Stack: c024f253 000006e7 
> 00000d80 c1b8f9f8 c1b8f9f0 00000183 e3f9d000 0000000a 
> Jun  7 02:57:43 web02 kernel:        00000000 00000000 
> 00000000 00000183 000000c0 000000c0 0008e000 c0136076 
> Jun  7 02:57:43 web02 kernel:        000000c0 e3fec000 
> 00000006 c01360d5 000000c0 00000000 00010f00 c1d9ffb8 
> Jun  7 02:57:43 web02 kernel: Call Trace: 
> [call_spurious_interrupt+130654/156203] .rodata.str1.1 
> [kernel] 0x2a8e 
> Jun  7 02:57:43 web02 kernel: Call Trace: [<c024f253>] 
> .rodata.str1.1 [kernel] 0x2a8e 
> Jun  7 02:57:43 web02 kernel: [do_try_to_free_pages+70/80] 
> do_try_to_free_pages [kernel] 0x46 
> Jun  7 02:57:43 web02 kernel: [<c0136076>] 
> do_try_to_free_pages [kernel] 0x46 
> Jun  7 02:57:43 web02 kernel: [kswapd+85/240] kswapd [kernel] 0x55 
> Jun  7 02:57:43 web02 kernel: [<c01360d5>] kswapd [kernel] 0x55 
> Jun  7 02:57:43 web02 kernel: [_stext+0/96] stext [kernel] 0x0 
> Jun  7 02:57:43 web02 kernel: [<c0105000>] stext [kernel] 0x0 
> Jun  7 02:57:43 web02 kernel: [kernel_thread+38/48] 
> kernel_thread [kernel] 0x26 
> Jun  7 02:57:43 web02 kernel: [<c0105866>] kernel_thread 
> [kernel] 0x26 
> Jun  7 02:57:43 web02 kernel: [kswapd+0/240] kswapd [kernel] 0x0 
> Jun  7 02:57:43 web02 kernel: [<c0136080>] kswapd [kernel] 0x0 
> Jun  7 02:57:43 web02 kernel: 
> Jun  7 02:57:43 web02 kernel: 
> Jun  7 02:57:43 web02 kernel: Code: 0f 0b 58 5a 8b 03 45 39 
> f8 75 dd 8b 4e 2c 89 ea 8b 7e 4c d3 
> 
> 
> I have searched on google for some of these messages but I 
> couldn't find anything helpful.  Any help or direction would 
> be apprecaited. 
> 
> I am not subscribed to this list so email to me directly 
> would be great.  If I am mailing to the wrong list my apologies.
> 
> Thanks so much all!
> 
> -anna
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
