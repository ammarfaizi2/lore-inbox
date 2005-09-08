Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVIHNIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVIHNIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVIHNIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:08:13 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:38825 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751325AbVIHNIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:08:12 -0400
Message-ID: <432037B6.10307@comcast.net>
Date: Thu, 08 Sep 2005 09:08:06 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.13-mm1 X86_64: All 32bit programs segfault
References: <431FB5FF.1030700@comcast.net> <200509080600.39368.ak@suse.de> <431FC7DA.6090309@comcast.net> <200509080744.06326.ak@suse.de>
In-Reply-To: <200509080744.06326.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>If you catch a crash in gdb and type x/i $pc what do you see?
>
>-Andi
>  
>
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1431820864 (LWP 2839)]
0x00c40471 in __pthread_initialize_minimal_internal ()
   from /lib/libpthread.so.0
(gdb) x/i $pc
0xc40471 <__pthread_initialize_minimal_internal+78>:    mov    
0x2e8(%eax),%edx
(gdb) info registers
eax            0x0      0
^^^^^^^^^^^^^^^^^^
ecx            0x5557da88       1431820936
edx            0x1      1
ebx            0xffffd4a8       -11096
esp            0xffffd1e4       0xffffd1e4
ebp            0xffffd4a8       0xffffd4a8
esi            0x5557da40       1431820864
edi            0x0      0
eip            0xc40471 0xc40471
eflags         0x10202  66050
cs             0x23     35
ss             0x2b     43
ds             0x2b     43
es             0x2b     43
fs             0x0      0
gs             0x63     99

