Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278795AbRJVNVC>; Mon, 22 Oct 2001 09:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278793AbRJVNUx>; Mon, 22 Oct 2001 09:20:53 -0400
Received: from mx0.gmx.de ([213.165.64.100]:47633 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S278742AbRJVNUf>;
	Mon, 22 Oct 2001 09:20:35 -0400
Date: Mon, 22 Oct 2001 15:21:09 +0200 (MEST)
From: abusch@gmx.net
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [oops] 2.4.12+i kswapd invalid operand: 0000
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000109679@gmx.net
X-Authenticated-IP: [194.15.145.12]
Message-ID: <8858.1003756869@www60.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There seems to be a problem with KSWAPD, maybe with the latest vm changes
?
>> Haven't seen oops for a long time. Uptime was only 17 hours.
>>
>> The kernel is 2.4.12 patched with the international crypto patch 2.4.3.1
>> and the 1512 NVidia module is loaded.
>Can you reproduce this bug without the NVIDIA driver or without the crypto
patch ?
The crypto stuff is compiled as modules and they were not used nor loaded at
that time.
An init 3 now on my box, disconnected my ssh-session ??? sorry, so I can
only tell you later when I'm at home to check what happened this time....
sorry. (uptime so far was 21 hours, the mysterious thing is that it happened
almost the same minute ~15:02:00 same as yesterday, I have to check that.)

> >>EIP; c012a17b <__free_pages_ok+1b/1e0>   <=====
> Trace; c0129901 <shrink_cache+1c1/300>
> Trace; c0129bbc <shrink_caches+5c/90>
> Trace; c0129c1c <try_to_free_pages+2c/60>
> Trace; c0129cd1 <kswapd_balance_pgdat+51/a0>
> Trace; c0129d46 <kswapd_balance+26/50>
> Trace; c0129e91 <kswapd+a1/c0>
> Trace; c0129df0 <kswapd+0/c0>
But can you tell me what is this memory area coming from ? c000000 should be
free ?
RAM goes here:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
Framebuffer here:
d0000000-d7ffffff : PCI Bus #01
other PCI stuff follows...

thx,
Andy.

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

