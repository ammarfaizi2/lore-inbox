Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSEHM02>; Wed, 8 May 2002 08:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313715AbSEHM01>; Wed, 8 May 2002 08:26:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12809 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313711AbSEHM0Z>; Wed, 8 May 2002 08:26:25 -0400
Message-ID: <3CD90AB0.2050508@evision-ventures.com>
Date: Wed, 08 May 2002 13:23:28 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <E175QmK-0001V8-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>Make hdX gone and use the scsi device major/minor number stuff instead.
>>And then just making the ATA driver looking like if it where some
>>incapable SCSI would actually reduce tons of code from kudzu and
>>friends without the need for any adjustment there.
> 
> 
> The SCSI layer is significant overhead even in 2.5. Right now for example
> it appears to be the primary bottleneck for the aacraid drivers.  ATA6 is
> also more capable than SCSI in several areas regardless of the notional
> market positioning.
> 
> Linus talked about having a /dev/disc/... which once you have 32bit dev_t
> makes complete sense. What you don't do however is throw IDE through the
> SCSI midlayer, you merely make the /dev/disc/ point call into the right
> drivers - be they raid, scsi or ide. That also lets the scsi emulation
> crap get ripped out of the megaraid and aacraid drivers which will up
> performance.
> 
> Alan

Alan... you have taken me wrong. What I mean is just the following.
Take away some minors from use by SCSI (or more propably a common repository)
and use the same ioctl numbers where possible. Perhaps implement
some ioctl here and there... not more!

Not the whole: "we are just another SCSI device on the driver level".
That would not make sense indeed. Since in esp. the SCSI mid-layer isn't
taht pritty too...

