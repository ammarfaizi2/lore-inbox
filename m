Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314274AbSDRI77>; Thu, 18 Apr 2002 04:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314275AbSDRI76>; Thu, 18 Apr 2002 04:59:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:30990 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314274AbSDRI75>; Thu, 18 Apr 2002 04:59:57 -0400
Message-ID: <3CBE7C63.6060203@evision-ventures.com>
Date: Thu, 18 Apr 2002 09:57:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 boot enhancements, boot bean counting 8/11
In-Reply-To: <m1elhegt1c.fsf@frodo.biederman.org>	<3CBDA073.6010700@evision-ventures.com> <m1sn5ufcpa.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Martin Dalecki <dalecki@evision-ventures.com> writes:
> 
> 
>>Eric W. Biederman wrote:
>>
>>>Linus please apply,
>>>Rework the actual build/link step for kernel images.  - remove the need for
>>>objcopy
>>>- Kill the ROOT_DEV Makefile variable, the implementation
>>>  was only half correct and there are much better ways
>>>  to specify your root device than modifying the kernel Makefile.
>>>- Don't loose information when the executable is built
>>
>>Coudl you please use sufficiently large fields for kdev_t variables?
>>This way if we once have bigger device id spaces one will not have
>>to mess with the boot code again.
>>Thank you.
> 
> 
> 1) This patch doesn't change anything except to document which fields
>    are present, and how big they are, and no there isn't enough room
>    to trivially expand these fields.
> 2) Exporting kdev_t from the kernel would be very bad.
> 3) swapdev is long dead, and root_dev while it works is unnecessary,
>    you can specify it on the command line just fine.
> 
> So we already are future proofed, and the change you suggest would be
> a bad one.  The compiled in command line fully supports the ability
> to set your root device, so no functionality is lost.
> 
> Like I said in my intro a lot of this code simply makes what the boot
> processes is currently doing more visible.
> 

Fine that explains it. Sorry for bogging you about it.

