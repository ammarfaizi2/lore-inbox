Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSEYTmc>; Sat, 25 May 2002 15:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSEYTmb>; Sat, 25 May 2002 15:42:31 -0400
Received: from dsl-213-023-040-043.arcor-ip.net ([213.23.40.43]:34255 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315267AbSEYTm3>;
	Sat, 25 May 2002 15:42:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Karim Yaghmour <karim@opersys.com>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Sat, 25 May 2002 21:41:43 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Wolfgang Denk <wd@denx.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205251138390.17649-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17BhQ7-0003nR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 May 2002 20:44, Linus Torvalds wrote:
> On Sat, 25 May 2002, Karim Yaghmour wrote:
> >
> > Blinders ehh... Well, if you would care to ask I would answer.
> >
> > In reality, what you point out is actually a non-issue since the hard-rt
> > user-land tasks are not allowed to call on normal Linux services. They
> > can only call on RTAI services which are exported by an extra soft-int.
> > These services are hard-rt, so there's no problem there.
> 
> .. which was exactly what I said:
> 
>  "..every single spinlock in the kernel assumes that the kernel isn't
>   preempted, which means that user apps that can preempt the kernel
>   cannot use them."

Nice recovery, however, reading your original comment in context, it
appears that you were not aware of the method RTAI uses to prevent
priority inversions[1]:

 - I think the microkernel approach is fundamentally broken. Karim claims
   there is no priority inversion, but he must have his blinders on. Every
   single spinlock in the kernel assumes that the kernel isn't preempted,
   which means that user apps that can preempt the kernel cannot use them.

So, since you thought that the priority inversion problem was not solved,
then you must not have known about the second set of services.

> Karim, I don't _need_ to download RTAI or ask you questions about how it
> works,

Oh, but I think you just showed that you do need to do that, I think we
all do.

-- 
Daniel

[1] And neither was I.
