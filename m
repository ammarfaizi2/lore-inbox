Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267950AbTB1P2c>; Fri, 28 Feb 2003 10:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267959AbTB1P2c>; Fri, 28 Feb 2003 10:28:32 -0500
Received: from dyn-ctb-210-9-246-99.webone.com.au ([210.9.246.99]:17156 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267950AbTB1P2b>;
	Fri, 28 Feb 2003 10:28:31 -0500
Message-ID: <3E5F8276.2010809@cyberone.com.au>
Date: Sat, 01 Mar 2003 02:38:30 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: janetmor@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 BUG in deadline-iosched.c
References: <3E5E70E0.36937042@us.ibm.com> <20030227144749.48e8e0f1.akpm@digeo.com>
In-Reply-To: <20030227144749.48e8e0f1.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Janet Morgan <janetmor@us.ibm.com> wrote:
>  
>
>>I got this on 2.5.63 while running the "find" command:
>>
>>kernel BUG at drivers/block/deadline-iosched.c:145!
>>invalid operand: 0000
>>CPU:    3
>>EIP:    0060:[<c026f8a1>]    Not tainted
>>EFLAGS: 00010046
>>EIP is at deadline_find_drq_hash+0x41/0xb0
>>eax: f76fe060   ebx: f76fe058   ecx: f76fe060   edx: 00000000
>>esi: f76fe060   edi: f76fe044   ebp: f76fe050   esp: f7e27c88
>>ds: 007b   es: 007b   ss: 0068
>>Process pdflush (pid: 16, threadinfo=f7e26000 task=c3b39300)
>>Stack: 010d7ce6 00000000 f7fd2ae0 f7fd2ae0 f7fd2ae0 f7747f80 c026fbc9
>>f7747f80
>>       010d7ce6 00000000 f7747f80 00000000 f7759000 f7759000 00000008
>>c026a438
>>       f7759000 f7e27cf8 f7fd2ae0 c026cc58 f7759000 f7e27cf8 f7fd2ae0
>>010d7ce6
>>Call Trace:
>> [<c026fbc9>] deadline_merge+0x49/0x120
>> [<c026a438>] elv_merge+0x18/0x30
>> [<c026cc58>] __make_request+0xb8/0x440
>>    
>>
>
>Nick, could this be caused by a stale next_drq[] entry?
>
Yes, it could be.

