Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278269AbRJSB0b>; Thu, 18 Oct 2001 21:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278268AbRJSB0M>; Thu, 18 Oct 2001 21:26:12 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:52236 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278266AbRJSBZ4>; Thu, 18 Oct 2001 21:25:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Davide Libenzi <davidel@xmailserver.org>,
        "David E. Weekly" <dweekly@legato.com>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Date: Thu, 18 Oct 2001 21:26:28 -0400
X-Mailer: KMail [version 1.3.2]
Cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0110181720370.970-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0110181720370.970-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011019012601Z278266-17408+2209@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 October 2001 20:22, Davide Libenzi wrote:
> On Thu, 18 Oct 2001, David E. Weekly wrote:
> > Hey all,
> >
> > I was trying to speed up kernel compiles experimentally by moving the
> > source tree into tmpfs and compiling there. It seemed to work okay and
> > crunched through the dep phase and most of the main build phase just
> > fine, but then it hit a file, got an internal segfault, and stopped. I
> > tried again -- this time make itself segfaulted. Three more times of make
> > segfaulting -- a strace on make didn't reveal what was failing. Then
> > strace started segfaulting. Eventually "ls" segfaulted and the machine
> > needed to be manually rebooted. Ouch!
> >
> > I ran the full memtest86 suite on the machine, and it passed with flying
> > colors. So the memory proper is okay.
> >
> > I come to one of two conclusions: this is a wierd problem with my north
> > bridge, or there's something funky going on with tmpfs.
> >
> > Is tmpfs stable?
>
> Or, is /dev/epoll stable ? :)
> I'm running it both on UP and 2 way SMP w/o problems from July.
> Just try w/o /dev/epoll
>
>
>
> - Davide

It works fine here, cept i get that damn 
ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
ld: final link failed: Bad value
error now when i compile on tmpfs that i didn't get when i compiled on the 
hdd with 2.4.10-acX.  It's only started happening since using 2.4.12-ac3.  
I've only used this kernel so i dont know if it's 2.4.12 or the ac3 part.   
anyways it got to that point in about 3:30 seconds . . which is about 5 
seconds faster than disk.   
