Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131316AbRCWSpu>; Fri, 23 Mar 2001 13:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131327AbRCWSpb>; Fri, 23 Mar 2001 13:45:31 -0500
Received: from ns.snowman.net ([63.80.4.34]:9995 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S131316AbRCWSpX>;
	Fri, 23 Mar 2001 13:45:23 -0500
Date: Fri, 23 Mar 2001 13:43:20 -0500 (EST)
From: <nick@snowman.net>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <UTC200103231829.TAA06442.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.21.0103231341050.8442-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please point me to an Operating System that runs on any commonly available
platform and fits your requirements.
	Nick

On Fri, 23 Mar 2001 Andries.Brouwer@cwi.nl wrote:

> On Fri, Mar 23, 2001 at 05:04:07PM +0000, Alan Cox wrote:
> > > This is just an escape route in case everything else has failed.
> > >
> > > Linux is unreliable.
> > > That is bad.
> >
> > Since your definition of reliability is a mathematical abstraction requiring
> > infinite storage why don't you start by inventing infinitely large SDRAM
> > chips, then get back to us ?
> 
> Ah, Alan,
> I can see that you dislike seeing me say bad things about Linux.
> I dislike having to say them.
> 
> On the other hand, my definition of reliability does not require
> infinite storage. After all, earlier Unix flavours did not need
> an OOM killer either, and my editor was not killed under Unix V6
> on 64k when I started some other process.
> 
> Linux is unreliable because a program can be killed at random,
> without warning, because of bugs in some other program.
> The old Unix guarantee that a program only crashes because of
> its own behaviour is lost. That is very sad.
> 
> What can one do? I need not tell you - you know better than I do.
> The main point is letting malloc fail when the memory cannot be
> guaranteed. There are various solutions for stack space, none of
> them very elegant, but all have in common that when we run out of
> stack space the program doing that gets SIGSEGV, and not some
> random other program. (And a well-written program could catch this
> SIGSEGV and do cleanup, preserving the integrity of its data base.
> Clearly one would want to guarantee a certain minimum stack space
> at fork time.)
> 
> Will this setup be very inefficient? I don't know. Perhaps.
> If my programs actually use 10 MB but have a guarantee for
> 200 MB then the rest of that memory is not wasted. But it can
> only be used for things that can be freed when needed, like
> inode and buffer cache.
> 
> But inefficient or not, I much prefer a system with guarantees,
> something that is reliable by default, above something that
> works well if you are lucky and fails at unpredictable moments.
> 
> Andries
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

