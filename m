Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264122AbUDGHPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264123AbUDGHPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:15:11 -0400
Received: from kendy.up.ac.za ([137.215.101.101]:56154 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S264122AbUDGHO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:14:58 -0400
Message-ID: <4073AA6F.3010308@cs.up.ac.za>
Date: Wed, 07 Apr 2004 09:14:55 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040325
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS in  __alloc_pages on x86
References: <4072E822.9040304@kroon.co.za>	<40739A96.6010604@cs.up.ac.za> <20040406232215.62d88593.akpm@osdl.org>
In-Reply-To: <20040406232215.62d88593.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scan-Signature: bad30d5a1df31d2b0488afa39a97ebc6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Jaco Kroon <jkroon@cs.up.ac.za> wrote:
>  
>
>>And on 2.6.5:
>>
>>ifconfig: page allocation failure. order:0, mode:0x20
>>Call Trace:
>>[<c013df67>] __alloc_pages+0x2d7/0x390
>>[<c013e042>] __get_free_pages+0x22/0x60
>>[<c014216f>] cache_grow+0x11f/0x470
>>[<c014262f>] cache_alloc_refill+0x16f/0x4e0
>>[<c014306f>] kmem_cache_alloc+0x19f/0x1c0
>>[<c0260dfc>] alloc_skb+0x1c/0xe0
>>[<c023cb41>] tulip_init_ring+0xa1/0x160
>>[<c023c6f6>] tulip_open+0x36/0x50
>>[<c0265437>] dev_open+0xb7/0xf0
>>[<c0266cf8>] dev_change_flags+0x58/0x140
>>[<c02a4b27>] devinet_ioctl+0x2b7/0x6a0
>>[<c02a6cf0>] inet_ioctl+0xb0/0xf0
>>[<c025d93c>] sock_ioctl+0xac/0x260
>>[<c0174a1d>] sys_ioctl+0x8d/0x220
>>[<c0107a77>] syscall_call+0x7/0xb
>>
>>When configuring the network card upon boot.
>>    
>>
>
>I don't know why you'd fail an allocation on boot.  How much memory does
>that machine have?
>  
>
64MB.  And by upon boot I mean during the init process, not actually the 
kernel boot itself.  System startup might be a better phrase in the 
context.  By the time ifconfig executes there should still be plenty of 
memory left, plus 128MB swap.

>You should increase /proc/sys/vm/min_free_kbytes.
>
>There's not a lot more we can do about this really, unless the driver is
>actually buggy.  Perhaps the default min_free_kbytes could be increased for
>however much memory you have.
>
>  
>
Will deffinately try this.

Thanks

Jaco

===========================================
This message and attachments are subject to a disclaimer. Please refer to www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
===========================================

