Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316293AbSEVRYf>; Wed, 22 May 2002 13:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316295AbSEVRYe>; Wed, 22 May 2002 13:24:34 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33810 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316293AbSEVRYc>; Wed, 22 May 2002 13:24:32 -0400
Message-ID: <3CEBC576.4060703@evision-ventures.com>
Date: Wed, 22 May 2002 18:21:10 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 67
In-Reply-To: <3CEB466B.3090604@evision-ventures.com> <20020522171329.GG1209@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Tom Rini napisa?:
> On Wed, May 22, 2002 at 09:19:07AM +0200, Martin Dalecki wrote:
> 
> 
>>Wed May 22 01:43:54 CEST 2002 ide-clean-67
>>
>>- Nuke COMMERIAL and similar spurious configuration options...
>>  The fact that every single default configuration option contained
>>  those bits makes this trivial patch appear rather big.
> 
> 
> This also nukes CONFIG_DMA_NONPCI.  While this probably shouldn't have
> been define_bool'ed to 'n' all of the time, there are cases where this
> seems to be properly used.  I know PPC4xx uses it (or will be using it
> once the driver is ready to be submitted) and it looks like cris uses it
> as well.

No I checked. PPC4xx had no functional code for the case
of CONFIG_DMA_NONPCI. It just looked like it had.
Look at the patch and see that it is removing the two
nonpci_xxx functions which are nowhere defined!

And the portability layer provides better mechanisms for the purpose
the serve to serve by the neas of the udma_ interface now.
Please look closer. The __CRIS__ behaviour is preserved and BTW.
not pretty as well.
But this can be fixed a bit later...

