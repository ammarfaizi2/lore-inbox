Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbSKOG0S>; Fri, 15 Nov 2002 01:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbSKOG0S>; Fri, 15 Nov 2002 01:26:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:63727 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265854AbSKOG0R>;
	Fri, 15 Nov 2002 01:26:17 -0500
Message-ID: <3DD49520.7927434C@digeo.com>
Date: Thu, 14 Nov 2002 22:33:04 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin A <ja6447@albany.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47-ac4 panic on boot.
References: <200211150059.51743.ja6447@albany.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 06:33:06.0062 (UTC) FILETIME=[DB2472E0:01C28C70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin A wrote:
> 
> My thinkpad 760e starts to boot but panics while running depmod -a:
> (unfortunately the top is cut off...it doesn't fit:))
> 
> ...
> CPU:    0
> EIP:    0060:[<c012b914>]       Not tainted
> EFLAGS: 00010006
> EIP is at reap_timer_fnc+0x104/0x40c
> eax: 00000002   ebx: c47ffab4   ecx: c47fe8a0   edx: 00000003
> esi: 00000002   edi: c4742414   ebp: c47ffa98   esp: c031df8c
> ds: 0068   es: 0068   ss: 0068
> Process swapper (pid: 0, threadinfo=c031c000 task=c02da3e0)
> Stack: same as call trace...
> 
> Call trace:
>  [<c012b810>] reap_timer_fnc+0x0/0x40c
>  [<c011ae47>] run_timer_tasklet+0xb7/0xe8
>  [<c0117f39>] tasklet_hi_action+0x3d/0x60
>  [<c0117d5a>] do_softirq+0x5a/0xac
>  [<c010a268>] do_IRQ+0xc8/0xd4
>  [<c0105000>] stext+0x0/0x1c
>  [<c0108b03>] common_interrupt+0x43/x060
> 
> Code: 0f 0b fb 07 a8 fe 21 c0 8d 74 26 00 8b 41 04 8b 11 89 42 04
> 
> I tried it a few times...the last few change, but its always in
> reap_timer_fnc.
> 

This is probably a dodgy device driver doing something bad with
kmalloced memory.

If you have time, please go through and disable various drivers
in config, see if you can isolate it to a particular one.

Thanks.
