Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTKCSH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTKCSH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:07:59 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:54694 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262123AbTKCSHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:07:55 -0500
Message-ID: <3FA69966.1090001@colorfullife.com>
Date: Mon, 03 Nov 2003 19:07:34 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Gary Wolfe <gpwolfe@cableone.net>, linux-kernel@vger.kernel.org
Subject: Re: [crash/panic] Linux-2.6.0-test9
References: <3FA5FFF7.2020006@cableone.net> <20031103005218.6dc72800.akpm@osdl.org>
In-Reply-To: <20031103005218.6dc72800.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Gary Wolfe <gpwolfe@cableone.net> wrote:
>  
>
>>Greetings,
>>
>>I have:
>>
>>Asus P4C800 Deluxe w/2.4GHz P4 (no HT and not 800Mhz bus)
>>
>>Tried test8 and, now, test9 and both exhibit same problem.
>>
>>The issue seems to be related to the PnPBIOS support under the Plug and 
>>Play Kconfig category.  When enabled I get a crash of the form:
>>
>>Linux Plug and Play Support v0.97 (c) Adam Belay
>>PnPBIOS: Scanning system for PnP BIOS support...
>>PnPBIOS: Found PnP BIOS installation structure at 0xc00f5350
>>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x5f3a, dseg 0xf0000
>>general protection fault: 0000 [#1]
>>CPU: 0
>>EIP: 0098:[<00002b60>] Not tainted
>>EFLAGS: 00010083
>>EIP is at 0x2b60
>>eax: 000023d6  ebx: 0000007a  ecx: 00010000  edx: 00000001
>>esi: dfed244e  edi: 0000006d  ebp: dfed0000  esp: dfed9eda
>>    
>>
>
>Your stack pointer became misaligned.  I thought Manfred fixed that?
>You don't have nmi_watchdog enabled on the kernel boot command line
>do you?
>  
>
I fixed the double-oops caused by misaligned stack pointers, and the 
oops if kmem_cache_alloc is called with an misaligned stack pointer.
In this case it seem to be an oops in the bios itself.

Gary: did it work with 2.4? Are there any bios upgrades you could try? 
My guess is that the bios is just buggy.

--
    Manfred

