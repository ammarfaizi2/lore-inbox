Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311589AbSCNUE7>; Thu, 14 Mar 2002 15:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSCNUEt>; Thu, 14 Mar 2002 15:04:49 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:14055 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S311589AbSCNUEl>; Thu, 14 Mar 2002 15:04:41 -0500
Message-ID: <3C910262.6010107@drugphish.ch>
Date: Thu, 14 Mar 2002 21:04:50 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au> <3C905894.90407@drugphish.ch> <3C905B9D.A1E3ACF6@zip.com.au> <3C9091D6.6030301@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> AFAICS you only
>>> addressed the i386 arch with that patch, do you want the specific arch
>>> maintainers to clean up their part when your patch is finished?
>>>
>>
>> ?  There's nothing arch-specific in any of this...
>  
> And there is nothing IDE related either. The code removed
> at the time wasn't used!

I see. So the trick is to fix hdparm and tell it not to use ioctl(fd, 
BLKRAGET, arg). But I don't think that the BIO changes introduce a means 
for readahead control/export from/to user space? Or would this be 
something like bio_ioctl(kdev_t, unsigned int, unsigned long), which is 
actually not used anywhere, or the request queue approach used by Andrew 
Morton?

The reason I was confused about the arch was that sparc64, ppc64, 
mips64, s390x and x86_64 still provide a ioctl handler for those ioctl's 
hooking up the the w_long (interestig naming concept btw) function.

Am I completely off the track here, mixing things up?

Best regards,
Roberto Nibali, ratz

