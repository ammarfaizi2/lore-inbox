Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313448AbSDQIim>; Wed, 17 Apr 2002 04:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313939AbSDQIim>; Wed, 17 Apr 2002 04:38:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:531 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313448AbSDQIil>;
	Wed, 17 Apr 2002 04:38:41 -0400
Message-ID: <3CBD25E2.2050404@evision-ventures.com>
Date: Wed, 17 Apr 2002 09:36:02 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        David Lang <david.lang@digitalinsight.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <E16xVSi-0000FN-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>Doing it with a loopback like interface at a higher level is the much 
>>saner operation - I understand why Martin removed the byteswap support, 
>>and agree with it 100%. It just didn't make any sense from a driver 
>>standpoint.
> 
> 
> We need to support partitioning on loopback devices in that case.
> 
> 
>>The only reason byteswapping exists is a rather historical one: Linux did 
>>the wrong thing for "insw/outsw" on big-endian architectures at one point 
>>(it byteswapped the data).
> 
> 
> A small number of other setups people wired the IDE the quick and easy
> way and their native format is indeed ass backwards - some M68K disks and
> the Tivo are examples of that. Interworking requires byteswapping and the
> ability to handle byteswapped partition tables.

I said it already multiple times Alan - please note that the byte-swapping code
for *physically* crosswired systems is *still there*. OK?

