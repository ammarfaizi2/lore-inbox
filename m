Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSLRQ3Y>; Wed, 18 Dec 2002 11:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSLRQ3Y>; Wed, 18 Dec 2002 11:29:24 -0500
Received: from packet.digeo.com ([12.110.80.53]:57009 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264001AbSLRQ3Y>;
	Wed, 18 Dec 2002 11:29:24 -0500
Message-ID: <3E00A43D.ADB20C26@digeo.com>
Date: Wed, 18 Dec 2002 08:37:17 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tomlins@cam.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52-mm1
References: <3DFD908D.14D7F6E7@digeo.com> <20021218122602.288D52230@oscar.casa.dyndns.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2002 16:37:17.0930 (UTC) FILETIME=[BA9244A0:01C2A6B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> 
> Hi
> 
> Got this oops this morning reading news:
> 
> Dec 18 07:15:29 oscar kernel:  printing eip:
> Dec 18 07:15:29 oscar kernel: c0140317
> Dec 18 07:15:29 oscar kernel: Oops: 0002
> Dec 18 07:15:29 oscar kernel: CPU:    0
> Dec 18 07:15:29 oscar kernel: EIP:    0060:[remove_inode_buffers+67/116]    Not tainted
> Dec 18 07:15:29 oscar kernel: EFLAGS: 00010246
> Dec 18 07:15:29 oscar kernel: EIP is at remove_inode_buffers+0x43/0x74
> Dec 18 07:15:29 oscar kernel: eax: 0dc4c344   ebx: c3440dc4   ecx: c3440dc6   edx: 0000c344
> Dec 18 07:15:29 oscar kernel: esi: c3440cd4   edi: 00000001   ebp: dfdb9ebc   esp: dfdb9e8c
> Dec 18 07:15:29 oscar kernel: ds: 0068   es: 0068   ss: 0068
> Dec 18 07:15:29 oscar kernel: Process kswapd0 (pid: 7, threadinfo=dfdb8000 task=dfdcb860)
> Dec 18 07:15:29 oscar kernel: Stack: c3440cd4 c3440cdc dfdb8000 c0152ff7 c3440cd4 00000080 00000923 d
> Dec 18 07:15:29 oscar kernel:        00000036 00000036 c3440b5c d76876dc 00000000 c01530db 00000080 c
> Dec 18 07:15:29 oscar kernel:        00000080 000001d0 00000221 c02a5374 fffffe27 0000000c 0d024a92 0

Wow, what a mess.  Something has written this "c3440cd4" value
into the stack and most of the registers.  Presumably it was
some interrupt.  Don't know, sorry.
