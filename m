Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSFJMzp>; Mon, 10 Jun 2002 08:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSFJMyw>; Mon, 10 Jun 2002 08:54:52 -0400
Received: from [195.63.194.11] ([195.63.194.11]:35591 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315213AbSFJMxj>; Mon, 10 Jun 2002 08:53:39 -0400
Message-ID: <3D049390.40101@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:54:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 "I can't get no compilation"
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <5.1.0.14.2.20020610133039.00ae8440@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> At 12:19 10/06/02, Martin Dalecki wrote:
> 
>> The subject says it all...
>>
>> Contrary to other proposed patches I realized that there is
>> no such thing as vmalloc_dma.
> 
> 
> Perhaps you ought to look in mm/vmalloc.c which contains:
> 
> void * vmalloc_dma (unsigned long size)
> {
>         return __vmalloc(size, GFP_KERNEL|GFP_DMA, PAGE_KERNEL);
> }
> 
> Or are you going to tell me that is a figment of my imagination?
> 

Oh I have missed the chunk which delets it there apparently, since
*nobody* is using this. The only place where a special
__vmalloc setup code is used in nfs which GFP_NOFS flag added,
but not the above. so providing vmalloc_nofs would make more
sense then vmalloc_dma.

