Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315461AbSEYXxo>; Sat, 25 May 2002 19:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315462AbSEYXxn>; Sat, 25 May 2002 19:53:43 -0400
Received: from wotug.org ([194.106.52.201]:49736 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S315461AbSEYXxm>;
	Sat, 25 May 2002 19:53:42 -0400
Date: Sun, 26 May 2002 00:49:57 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Luigi Genoni <kernel@Expansa.sns.it>
cc: Dave Jones <davej@suse.de>, "J.A. Magallon" <jamagallon@able.es>,
        Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1
 -march=pentium{-mmx,3,4}
In-Reply-To: <Pine.LNX.4.44.0205260128110.2047-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.44.0205260044270.10923-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 May 2002, Luigi Genoni wrote:
>On Sun, 26 May 2002, Dave Jones wrote:
>> On Sun, May 26, 2002 at 01:37:39AM +0200, J.A. Magallon wrote:
>>  > Could you also split
>>  > 	Pentium-Pro/Celeron/Pentium-II     CONFIG_M686
>>  > into
>>  > 	Pentium-Pro            CONFIG_M686
>>  > 	Pentium-II/Celeron     CONFIG_MPENTIUMII
>> There are also a few extra Athlon targets iirc. athlon-xp and the like,
>> which I'm not sure the purpose of. Some gcc know-all want to clue me in
>> to what these offer over -march=athlon ?
>>
>I do not know about the gcc options, but Athlon XP/MP has sse instruction,
>while tbird has not, so it could be relate to this.
>
>>  > BTW, I think an option to enable -mmmx would also be useful. Nothing more,
>>  > because afaik sse is only floating point.

For the CONFIG_<<cputype>> options, is it only gcc compiler-type settings that 
are affected? I thought the assembly parts of the kernel were also switched on 
occasion.

I was wondering whether anyone has checked that these assembly snippets were 
decently optimal for the cpu type selected...


>> Another interesting recently-added option which may be worth
>> benchmarking on modern CPUs is the prefetch-loops option.
>> In a lot of cases, the kernel 'knows better' and is adding the

Be careful about 'knowing better' than compilers. I really don't want to start
a flamefest, but modern compilers are very good at doing all sorts of
optimisations, and hand-coded 'optimisations' can _sometimes_ actually hurt
performance over the unadorned version of the code. It is sensible to prove 
that the source-level optimisation helps, and then to mark it as such, so as 
compilers change it can be reviewed.


Regards,

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

