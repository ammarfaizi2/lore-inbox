Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSDIQYE>; Tue, 9 Apr 2002 12:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSDIQYD>; Tue, 9 Apr 2002 12:24:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:6 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293457AbSDIQYC>;
	Tue, 9 Apr 2002 12:24:02 -0400
Message-ID: <3CB3071D.9000005@evision-ventures.com>
Date: Tue, 09 Apr 2002 17:22:05 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] IDE TCQ #2
In-Reply-To: <UTC200204091534.PAA574373.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>     On Tue, Apr 09 2002, Martin Dalecki wrote:
>     > >  echo "using_tcq:0" > /proc/ide/hdX/setting
>     > >
>     > >  will disable TCQ and revert to DMA,
>     > >
>     > >  echo "using_tcq:32" > /proc/ide/hdX/setting
>     > >
>     > >  will set queue depth to 32, any value in between the two are of course
>     > >  also allowed. The driver will print enable/disable info to the kernel
>     > >  log.
>     > 
>     > Well this belongs to an ioctl or sysctl... However most
>     > of the /proc/ide stuff if not all will go to the sysctl quite soon.
> 
>     Put it wherever you want it, I'm just making it easier for myself not
>     having to pass patches to hdparm around as well for people to enable
>     taggged queueing.
> 
> Yes, for IDE purposes it does not matter much what one does.
> 
> But one needs communication between user or user space
> and kernel to interact with hundreds of drivers, in a rather
> messy way.
> 
> In my opinion sysctl() is worthless. It uses an array of numbers
> where ioctl() uses a single number. Especially since the names are
> already in the kernel it is much clearer and cleaner to use a
> pathname. I wouldn't mind if sysctl() disappeared entirely.

Please have a look at /proc/sys/ OK?

> 
> Also ioctl() has its problems. First of all, nobody knows what the
> prototype is. Secondly, it is too rigid - the moment one needs a
> larger structure one needs a different ioctl.
> 
> A text based interface is much more flexible. If the number of
> cylinders of a disk no longer fits in a short, well doesn't matter,
> then the number of digits may increase but the interface remains
> unchanged. Of course the price is that one has to parse, but
> typically that is not a problem.

