Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310806AbSCRNal>; Mon, 18 Mar 2002 08:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310816AbSCRNac>; Mon, 18 Mar 2002 08:30:32 -0500
Received: from [195.63.194.11] ([195.63.194.11]:8210 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S310806AbSCRNaR>;
	Mon, 18 Mar 2002 08:30:17 -0500
Message-ID: <3C95EB96.9020803@evision-ventures.com>
Date: Mon, 18 Mar 2002 14:28:54 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Roberto Nibali <ratz@drugphish.ch>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au> <3C905894.90407@drugphish.ch> <3C905B9D.A1E3ACF6@zip.com.au> <3C9091D6.6030301@evision-ventures.com> <3C910262.6010107@drugphish.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali wrote:
>>>> AFAICS you only
>>>> addressed the i386 arch with that patch, do you want the specific arch
>>>> maintainers to clean up their part when your patch is finished?
>>>>
>>>
>>> ?  There's nothing arch-specific in any of this...
>>
>>  
>> And there is nothing IDE related either. The code removed
>> at the time wasn't used!
> 
> 
> I see. So the trick is to fix hdparm and tell it not to use ioctl(fd, 
> BLKRAGET, arg). But I don't think that the BIO changes introduce a means 
> for readahead control/export from/to user space? Or would this be 
> something like bio_ioctl(kdev_t, unsigned int, unsigned long), which is 
> actually not used anywhere, or the request queue approach used by Andrew 
> Morton?
> 
> The reason I was confused about the arch was that sparc64, ppc64, 
> mips64, s390x and x86_64 still provide a ioctl handler for those ioctl's 
> hooking up the the w_long (interestig naming concept btw) function.
> 
> Am I completely off the track here, mixing things up?

No I think you are entierly on track.

BTW> It's quite propably right now, that I will just reintroduce them
myself and give them the semantics of the multi-write hardware settings,
just to fix the multi write PIO problem :-).

