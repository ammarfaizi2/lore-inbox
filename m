Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269168AbTCBAWg>; Sat, 1 Mar 2003 19:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269169AbTCBAWg>; Sat, 1 Mar 2003 19:22:36 -0500
Received: from static-b2-191.highspeed.eol.ca ([64.56.236.191]:35850 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id <S269168AbTCBAWc>;
	Sat, 1 Mar 2003 19:22:32 -0500
Message-ID: <3E615134.8050907@brad-x.com>
Date: Sat, 01 Mar 2003 19:32:52 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030223
X-Accept-Language: en-us, en, zh-cn, zh-hk, zh-sg,
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>
Cc: Marc Giger <gigerstyle@gmx.ch>, jt@hpl.hp.com,
       linux-kernel@vger.kernel.org, breed@users.sourceforge.net,
       achirica@users.sourceforge.net
Subject: Re: Cisco Aironet 340 oops with 2.4.20
References: <Pine.LNX.4.44.0303021053170.4620-100000@blackbird.intercode.com.au>
In-Reply-To: <Pine.LNX.4.44.0303021053170.4620-100000@blackbird.intercode.com.au>
Content-Type: multipart/mixed;
 boundary="------------050002050502010201020104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050002050502010201020104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Morris wrote:

>On Sat, 1 Mar 2003, Brad Laue wrote:
>
>  
>
>>Still crashes:
>>
>>static const char version[] = "$Revision: 1.46 $";
>>
>>ksymoops output attached.
>>
>>    
>>
>
>Can you reproduce the crash without the Nvidia module loaded?
>
>
>- James
>  
>
Yes.

In the attached is a full dump of three crashes. The first, at 18:14 
occurs with NVdriver loaded, and the subsequent two occur with a system 
which has booted without being touched by NVdriver.

-- 
// -- http://www.BRAD-X.com/ -- //


--------------050002050502010201020104
Content-Type: text/plain;
 name="ksymoops2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops2"

ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (specified)

Mar  1 18:04:30 Odyssey kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Mar  1 18:04:30 Odyssey kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
Mar  1 18:04:30 Odyssey kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Mar  1 18:05:08 Odyssey kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Mar  1 18:14:39 Odyssey kernel: Warning: kfree_skb passed an skb still on a list (from c01201ba).
Mar  1 18:14:39 Odyssey kernel: kernel BUG at skbuff.c:315!
Mar  1 18:14:39 Odyssey kernel: invalid operand: 0000
Mar  1 18:14:39 Odyssey kernel: CPU:    0
Mar  1 18:14:39 Odyssey kernel: EIP:    0010:[start_request+164/528]    Tainted: P 
Mar  1 18:14:39 Odyssey kernel: EIP:    0010:[<c01dca24>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
Mar  1 18:14:39 Odyssey kernel: EFLAGS: 00010286
Mar  1 18:14:39 Odyssey kernel: eax: 00000045   ebx: c267c860   ecx: cd36e000   edx: cd36ff7c
Mar  1 18:14:39 Odyssey kernel: esi: c12f1f84   edi: 00000000   ebp: c12f0000   esp: c12f1f6c
Mar  1 18:14:39 Odyssey kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 18:14:39 Odyssey kernel: Process keventd (pid: 2, stackpage=c12f1000)
Mar  1 18:14:39 Odyssey kernel: Stack: c0244620 c01201ba 00000000 c12f1f84 c01201ba c267c860 cea682e4 cea682e4 
Mar  1 18:14:39 Odyssey kernel:        00000000 00000000 c0128df3 c0256d70 c12f1fb0 00000000 c12f0560 c12f0570 
Mar  1 18:14:39 Odyssey kernel:        c12f0000 00000001 00000000 c0253fa0 00010000 00000000 00000700 c0128cc0 
Mar  1 18:14:39 Odyssey kernel: Call Trace:    [sys_old_getrlimit+42/224] [sys_old_getrlimit+42/224] [vmalloc_area_pages+243/368] [vmfree_area_pages+320/384] [rest_init+0/40]
Mar  1 18:14:39 Odyssey kernel: Call Trace:    [<c01201ba>] [<c01201ba>] [<c0128df3>] [<c0128cc0>] [<c0105000>]
Mar  1 18:14:39 Odyssey kernel:   [<c01057ce>] [<c0128cc0>]
Mar  1 18:14:39 Odyssey kernel: Code: 0f 0b 3b 01 b1 38 24 c0 8b 5c 24 14 e9 0e ff ff ff 8d 74 26 


>>EIP; c01dca24 <__kfree_skb+f4/110>   <=====

>>ebx; c267c860 <_end+23aa028/10623828>
>>ecx; cd36e000 <_end+d09b7c8/10623828>
>>edx; cd36ff7c <_end+d09d744/10623828>
>>esi; c12f1f84 <_end+101f74c/10623828>
>>ebp; c12f0000 <_end+101d7c8/10623828>
>>esp; c12f1f6c <_end+101f734/10623828>

Trace; c01201ba <__run_task_queue+5a/70>
Trace; c01201ba <__run_task_queue+5a/70>
Trace; c0128df3 <context_thread+133/1c0>
Trace; c0128cc0 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c01057ce <kernel_thread+2e/40>
Trace; c0128cc0 <context_thread+0/1c0>

Code;  c01dca24 <__kfree_skb+f4/110>
00000000 <_EIP>:
Code;  c01dca24 <__kfree_skb+f4/110>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01dca26 <__kfree_skb+f6/110>
   2:   3b 01                     cmp    (%ecx),%eax
Code;  c01dca28 <__kfree_skb+f8/110>
   4:   b1 38                     mov    $0x38,%cl
Code;  c01dca2a <__kfree_skb+fa/110>
   6:   24 c0                     and    $0xc0,%al
Code;  c01dca2c <__kfree_skb+fc/110>
   8:   8b 5c 24 14               mov    0x14(%esp,1),%ebx
Code;  c01dca30 <__kfree_skb+100/110>
   c:   e9 0e ff ff ff            jmp    ffffff1f <_EIP+0xffffff1f>
Code;  c01dca35 <__kfree_skb+105/110>
  11:   8d 74 26 00               lea    0x0(%esi,1),%esi

Mar  1 18:17:01 Odyssey kernel:   Receiver lock-up bug exists -- enabling work-around.
Mar  1 18:17:01 Odyssey kernel: ac97_codec: AC97 Audio codec, id: \203\204v9(SigmaTel STAC9721/23)
Mar  1 18:18:51 Odyssey kernel:   Receiver lock-up bug exists -- enabling work-around.
Mar  1 18:18:51 Odyssey kernel: ac97_codec: AC97 Audio codec, id: \203\204v9(SigmaTel STAC9721/23)
Mar  1 19:00:06 Odyssey kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Mar  1 19:00:06 Odyssey kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
Mar  1 19:00:06 Odyssey kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Mar  1 19:01:11 Odyssey kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Mar  1 19:13:19 Odyssey kernel: Warning: kfree_skb passed an skb still on a list (from c01201ba).
Mar  1 19:13:19 Odyssey kernel: kernel BUG at skbuff.c:315!
Mar  1 19:13:19 Odyssey kernel: invalid operand: 0000
Mar  1 19:13:19 Odyssey kernel: CPU:    0
Mar  1 19:13:19 Odyssey kernel: EIP:    0010:[start_request+164/528]    Tainted: P 
Mar  1 19:13:19 Odyssey kernel: EIP:    0010:[<c01dca24>]    Tainted: P 
Mar  1 19:13:19 Odyssey kernel: EFLAGS: 00010286
Mar  1 19:13:19 Odyssey kernel: eax: 00000045   ebx: c550f760   ecx: cf026000   edx: cf027f7c
Mar  1 19:13:19 Odyssey kernel: esi: c12f1f84   edi: 00000000   ebp: c12f0000   esp: c12f1f6c
Mar  1 19:13:19 Odyssey kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 19:13:19 Odyssey kernel: Process keventd (pid: 2, stackpage=c12f1000)
Mar  1 19:13:19 Odyssey kernel: Stack: c0244620 c01201ba 00000000 c12f1f84 c01201ba c550f760 cedd82e4 cedd82e4 
Mar  1 19:13:19 Odyssey kernel:        00000000 00000000 c0128df3 c0256d70 c12f1fb0 00000000 c12f0560 c12f0570 
Mar  1 19:13:19 Odyssey kernel:        c12f0000 00000001 00000000 c0253fa0 00010000 00000000 00000700 c0128cc0 
Mar  1 19:13:19 Odyssey kernel: Call Trace:    [sys_old_getrlimit+42/224] [sys_old_getrlimit+42/224] [vmalloc_area_pages+243/368] [vmfree_area_pages+320/384] [rest_init+0/40]
Mar  1 19:13:19 Odyssey kernel: Call Trace:    [<c01201ba>] [<c01201ba>] [<c0128df3>] [<c0128cc0>] [<c0105000>]
Mar  1 19:13:19 Odyssey kernel:   [<c01057ce>] [<c0128cc0>]
Mar  1 19:13:19 Odyssey kernel: Code: 0f 0b 3b 01 b1 38 24 c0 8b 5c 24 14 e9 0e ff ff ff 8d 74 26 


>>EIP; c01dca24 <__kfree_skb+f4/110>   <=====

>>ebx; c550f760 <_end+523cf28/10623828>
>>ecx; cf026000 <_end+ed537c8/10623828>
>>edx; cf027f7c <_end+ed55744/10623828>
>>esi; c12f1f84 <_end+101f74c/10623828>
>>ebp; c12f0000 <_end+101d7c8/10623828>
>>esp; c12f1f6c <_end+101f734/10623828>

Trace; c01201ba <__run_task_queue+5a/70>
Trace; c01201ba <__run_task_queue+5a/70>
Trace; c0128df3 <context_thread+133/1c0>
Trace; c0128cc0 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c01057ce <kernel_thread+2e/40>
Trace; c0128cc0 <context_thread+0/1c0>

Code;  c01dca24 <__kfree_skb+f4/110>
00000000 <_EIP>:
Code;  c01dca24 <__kfree_skb+f4/110>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01dca26 <__kfree_skb+f6/110>
   2:   3b 01                     cmp    (%ecx),%eax
Code;  c01dca28 <__kfree_skb+f8/110>
   4:   b1 38                     mov    $0x38,%cl
Code;  c01dca2a <__kfree_skb+fa/110>
   6:   24 c0                     and    $0xc0,%al
Code;  c01dca2c <__kfree_skb+fc/110>
   8:   8b 5c 24 14               mov    0x14(%esp,1),%ebx
Code;  c01dca30 <__kfree_skb+100/110>
   c:   e9 0e ff ff ff            jmp    ffffff1f <_EIP+0xffffff1f>
Code;  c01dca35 <__kfree_skb+105/110>
  11:   8d 74 26 00               lea    0x0(%esi,1),%esi

Mar  1 19:16:52 Odyssey kernel:   Receiver lock-up bug exists -- enabling work-around.
Mar  1 19:16:52 Odyssey kernel: ac97_codec: AC97 Audio codec, id: \203\204v9(SigmaTel STAC9721/23)
Mar  1 19:17:25 Odyssey kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Mar  1 19:17:25 Odyssey kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
Mar  1 19:17:25 Odyssey kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Mar  1 19:17:38 Odyssey kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Mar  1 19:22:28 Odyssey kernel: Warning: kfree_skb passed an skb still on a list (from c01201ba).
Mar  1 19:22:28 Odyssey kernel: kernel BUG at skbuff.c:315!
Mar  1 19:22:28 Odyssey kernel: invalid operand: 0000
Mar  1 19:22:28 Odyssey kernel: CPU:    0
Mar  1 19:22:28 Odyssey kernel: EIP:    0010:[start_request+164/528]    Tainted: P 
Mar  1 19:22:28 Odyssey kernel: EIP:    0010:[<c01dca24>]    Tainted: P 
Mar  1 19:22:28 Odyssey kernel: EFLAGS: 00010286
Mar  1 19:22:28 Odyssey kernel: eax: 00000045   ebx: caaf3320   ecx: ccd20000   edx: ccd21f7c
Mar  1 19:22:28 Odyssey kernel: esi: c12f1f84   edi: 00000000   ebp: c12f0000   esp: c12f1f6c
Mar  1 19:22:28 Odyssey kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 19:22:28 Odyssey kernel: Process keventd (pid: 2, stackpage=c12f1000)
Mar  1 19:22:28 Odyssey kernel: Stack: c0244620 c01201ba 00000000 c12f1f84 c01201ba caaf3320 ccedc2e4 ccedc2e4 
Mar  1 19:22:28 Odyssey kernel:        00000000 00000000 c0128df3 c0256d70 c12f1fb0 00000000 c12f0560 c12f0570 
Mar  1 19:22:28 Odyssey kernel:        c12f0000 00000001 00000000 c0253fa0 00010000 00000000 00000700 c0128cc0 
Mar  1 19:22:28 Odyssey kernel: Call Trace:    [sys_old_getrlimit+42/224] [sys_old_getrlimit+42/224] [vmalloc_area_pages+243/368] [vmfree_area_pages+320/384] [rest_init+0/40]
Mar  1 19:22:28 Odyssey kernel: Call Trace:    [<c01201ba>] [<c01201ba>] [<c0128df3>] [<c0128cc0>] [<c0105000>]
Mar  1 19:22:28 Odyssey kernel:   [<c01057ce>] [<c0128cc0>]
Mar  1 19:22:28 Odyssey kernel: Code: 0f 0b 3b 01 b1 38 24 c0 8b 5c 24 14 e9 0e ff ff ff 8d 74 26 


>>EIP; c01dca24 <__kfree_skb+f4/110>   <=====

>>ebx; caaf3320 <_end+a820ae8/10623828>
>>ecx; ccd20000 <_end+ca4d7c8/10623828>
>>edx; ccd21f7c <_end+ca4f744/10623828>
>>esi; c12f1f84 <_end+101f74c/10623828>
>>ebp; c12f0000 <_end+101d7c8/10623828>
>>esp; c12f1f6c <_end+101f734/10623828>

Trace; c01201ba <__run_task_queue+5a/70>
Trace; c01201ba <__run_task_queue+5a/70>
Trace; c0128df3 <context_thread+133/1c0>
Trace; c0128cc0 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c01057ce <kernel_thread+2e/40>
Trace; c0128cc0 <context_thread+0/1c0>

Code;  c01dca24 <__kfree_skb+f4/110>
00000000 <_EIP>:
Code;  c01dca24 <__kfree_skb+f4/110>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01dca26 <__kfree_skb+f6/110>
   2:   3b 01                     cmp    (%ecx),%eax
Code;  c01dca28 <__kfree_skb+f8/110>
   4:   b1 38                     mov    $0x38,%cl
Code;  c01dca2a <__kfree_skb+fa/110>
   6:   24 c0                     and    $0xc0,%al
Code;  c01dca2c <__kfree_skb+fc/110>
   8:   8b 5c 24 14               mov    0x14(%esp,1),%ebx
Code;  c01dca30 <__kfree_skb+100/110>
   c:   e9 0e ff ff ff            jmp    ffffff1f <_EIP+0xffffff1f>
Code;  c01dca35 <__kfree_skb+105/110>
  11:   8d 74 26 00               lea    0x0(%esi,1),%esi

Mar  1 19:24:00 Odyssey kernel:   Receiver lock-up bug exists -- enabling work-around.
Mar  1 19:24:00 Odyssey kernel: ac97_codec: AC97 Audio codec, id: \203\204v9(SigmaTel STAC9721/23)
Mar  1 19:25:31 Odyssey kernel:   Receiver lock-up bug exists -- enabling work-around.
Mar  1 19:25:31 Odyssey kernel: ac97_codec: AC97 Audio codec, id: \203\204v9(SigmaTel STAC9721/23)

--------------050002050502010201020104--

