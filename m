Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292574AbSCFMxn>; Wed, 6 Mar 2002 07:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292752AbSCFMxc>; Wed, 6 Mar 2002 07:53:32 -0500
Received: from [195.63.194.11] ([195.63.194.11]:3336 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S292574AbSCFMxZ>;
	Wed, 6 Mar 2002 07:53:25 -0500
Message-ID: <3C86110E.7020703@evision-ventures.com>
Date: Wed, 06 Mar 2002 13:52:30 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: bitkeeper / IDE cleanup
In-Reply-To: <UTC200203061212.MAA182963.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>>Plese note that the mail in wich I did send this particular patch
>>didn't contain the cleanup term.
>>
> 
> You forgot to check the Subject line.
> 
> 
>>I would rather have a true lean *abstract* ioctl/sysctl
>>based interface
>>
> 
> I very much distrust the possibility of defining any abstract interface.
> For special purpose things one just wants to send certain commands and
> data to the disk, and user space knows which commands and what data,
> and the kernel doesn't, so has to allow user space access.

Well then please answer the following:

1. Why do Windwos, FreeBSD, Darwin and Solrais provide generic hooks for
    device probing, powerstate handing and so on?

2. Why do they get away with an interface half the complexity of the
    linx IDE ioctl mess?

3. Why do we have something like genric cdrom ioctl handling layer,
    which is basically just adding the above hooks?

Actually Alan Cox convinced me that it still makes sense to have a
IOCTL_ATA_DRIVE_TAKE_ME_HARD_FROM_THE_REAR, but I still don't see any
argument in favour of the current half-finished code behind
HDIO_DRIVE_TASKFILE, which even by concept doesn't provide a true
backdoor for "vendor specific" mess, due to the misguided attempts
for command format parsing found there.

