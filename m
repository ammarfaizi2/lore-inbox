Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSIIAcv>; Sun, 8 Sep 2002 20:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSIIAcv>; Sun, 8 Sep 2002 20:32:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11276 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315746AbSIIAcu>;
	Sun, 8 Sep 2002 20:32:50 -0400
Message-ID: <3D7BED2D.8000705@mandrakesoft.com>
Date: Sun, 08 Sep 2002 20:37:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Daniel Mehrmann <daniel.mehrmann@gmx.de>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4/2.5] Athlon CFLAGS
References: <200209082128.11316.daniel.mehrmann@gmx.de> <20020909011833.B14358@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sun, Sep 08, 2002 at 09:28:11PM +0200, Daniel Mehrmann wrote:
>  > Hi Alan,
>  > 
>  > i add for the AMD Athlon family some optimize compilerflags. 
>  > Gcc 3.1 and 3.2 support more specific Athlon instructions as 3.0 or 2.95x. 
>  > This patch for 2.4.19, 2.4.20-pre5 and 2.5.33 set a new "-march" flag:
>  > 
>  > Athlon TB/Duron 		+= -march=athlon-tbird
>  > Athlon XP/Athlon4/Duron	+= -march=athlon-xp
>  > Athlon MP				+= -march=athlon-mp
> 
> I thought these were all just gcc aliases for the same options ?
> It's been a while since I looked at the gcc option parser, so I've
> forgotten exactly what happens, but at least you missed the
> bogus athlon-4 option.
> 
> Are the gains between all these options really worth the added
> complexity ?
> 
>         Dave
> 

They all have the same scheduling AFAICS, there are minor variations 
between athlon, athlon-tbird, and the rest:

> 
>       {"athlon", PROCESSOR_ATHLON, PTA_MMX | PTA_PREFETCH_SSE | PTA_3DNOW
>                                    | PTA_3DNOW_A},
>       {"athlon-tbird", PROCESSOR_ATHLON, PTA_MMX | PTA_PREFETCH_SSE
>                                          | PTA_3DNOW | PTA_3DNOW_A},
>       {"athlon-4", PROCESSOR_ATHLON, PTA_MMX | PTA_PREFETCH_SSE | PTA_3DNOW
>                                     | PTA_3DNOW_A | PTA_SSE},
>       {"athlon-xp", PROCESSOR_ATHLON, PTA_MMX | PTA_PREFETCH_SSE | PTA_3DNOW
>                                       | PTA_3DNOW_A | PTA_SSE},
>       {"athlon-mp", PROCESSOR_ATHLON, PTA_MMX | PTA_PREFETCH_SSE | PTA_3DNOW
>                                       | PTA_3DNOW_A | PTA_SSE},

