Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbREXMWZ>; Thu, 24 May 2001 08:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261741AbREXMWP>; Thu, 24 May 2001 08:22:15 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:3242 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261719AbREXMVz>; Thu, 24 May 2001 08:21:55 -0400
Message-Id: <5.1.0.14.2.20010524130319.00a4c0c0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 May 2001 13:21:57 +0100
To: David Woodhouse <dwmw2@infradead.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: How to add ntfs support 
Cc: Blesson Paul <blessonpaul@usa.net>, linux-kernel@vger.kernel.org
In-Reply-To: <6917.990702100@redhat.com>
In-Reply-To: <5.1.0.14.2.20010524114122.00aa7450@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010524114122.00aa7450@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:01 24/05/01, David Woodhouse wrote:
>aia21@cam.ac.uk said:
> > > I want to know , is there any method to register ntfs file system
> > > without recompiling the whole kernel
>
> > No, it is not possible to not recompile the kernel if NTFS was {not}
> > configured.
>
>Is it not possible to build NTFS as a module?

It is of course possible to build it as a modules. That is what I do. But 
it would be guaranteed to work only if NLS was enabled during the previous 
kernel compile and even then you would still have to do the make 
{old,menu,x,}config, followed by make dep and make modules. On a fast 
mashine you might as well do the make bzImage, too... - Also it would only 
work if you are compiling the modules on the same kernel with the same 
config as the currently running kernel.

Also, the original poster said he was using RedHat 6.2, which means he is 
probably using a 2.2.x kernel as that came with RedHat 6.2 and considering 
he doesn't want to recompile the kernel chances are he has some ancient 
2.2.x kernel at that (whatever came standard with 6.2 + eventual updates...).

So it would be a good idea to get at least 2.4.4 kernel and then yes, you 
would have to compile it from scratch...

Best regards,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

