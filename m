Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTJWXXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTJWXXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:23:41 -0400
Received: from mail-03.iinet.net.au ([203.59.3.35]:52413 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261875AbTJWXXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:23:38 -0400
Message-ID: <3F986311.40804@cyberone.com.au>
Date: Fri, 24 Oct 2003 09:24:01 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: "Joseph D. Wagner" <theman@josephdwagner.info>,
       linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
References: <200310221855.15925.theman@josephdwagner.info> <20031023230542.GC2084@werewolf.able.es>
In-Reply-To: <20031023230542.GC2084@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



J.A. Magallon wrote:

>On 10.22, Joseph D. Wagner wrote:
>
>>Yes, I know you can select Pentium III, Pentium 4, Athlon, etc, under 
>>processor type when doing a 'make xconfig', but those selections do not 
>>translate into the appropriate -mcpu and -march flags.
>>
>>While the kernel on x86 architecture can be optimized in terms of generic 
>>processor specifications (i.e. i386, i486, i586, i686), the kernel can't be 
>>optimized beyond a i686.
>>
>>If you select Pentium III, the -march flag is set to i686.
>>If you select Pentium 4, the -march flag is set to i686.
>>If you select Athlon 4, the -march flag is set to i686.
>>If you select Athlon XP, the -march flag is set to i686.
>>
>>It should be that...
>>
>>If you select Pentium III, the -march flag is set to pentium3.
>>If you select Pentium 4, the -march flag is set to pentium4.
>>If you select Athlon 4, the -march flag is set to athlon-4.
>>If you select Athlon XP, the -march flag is set to athlon-xp.
>>
>>I don't want to have to hand edit the makefiles just to optimize my kernel.  
>>I think this change is simple enough to do, and would allow kernel 
>>developers the option of processor-specific optimizations in the future.
>>
>>TIA.
>>
>>Joseph D. Wagner
>>
>
>I have sent the attached patches sometimes to the list/Marcelo, and they
>have been rejected to the moment because:
>- gcc can spit some new instructions, reorganize code and other things when
>  you jump from i686 to pentium3, for example.
>- There can be bugs both in gcc and in the kernel that can be triggered by
>  >i686 optimizations/code.
>- This is not safe for a stable kernel, it was done in 2.5, bugs appeared,
>  were corrected, and so on, 'cause this was a development kernel.
>

Not that I think this should go in anyway, but the only way you ever
might get it in is if you measure significant performance improvements.
I don't think you will.


