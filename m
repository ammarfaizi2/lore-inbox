Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319076AbSIDGRB>; Wed, 4 Sep 2002 02:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319077AbSIDGRB>; Wed, 4 Sep 2002 02:17:01 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:14864 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319076AbSIDGRA>;
	Wed, 4 Sep 2002 02:17:00 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209040621.g846LTO10461@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <3D75A0DB.AAA60362@aitel.hist.no> from Helge Hafting at "Sep 4,
 2002 07:57:47 am"
To: Helge Hafting <helgehaf@aitel.hist.no>
Date: Wed, 4 Sep 2002 08:21:29 +0200 (MET DST)
Cc: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Helge Hafting wrote:"
> "Peter T. Breuer" wrote:
> > "A month of sundays ago David Lang wrote:"
> > > Peter, the thing that you seem to be missing is that direct mode only
> > > works for writes, it doesn't force a filesystem to go to the hardware for
> > > reads.
> > 
> > Yes it does. I've checked! Well, at least I've checked that writing
> > then reading causes the reads to get to the device driver. I haven't
> > checked what reading twice does.
> 
> You tried reading from a file?  For how long are you going to

Yes I did. And I tried readingtwice too, and it reads twice at device
level.

> work on that data you read?  The other machine may ruin it anytime,

Well, as long as I want to. What's the problem? I read file X at time
T and got data Y. That's all I need.

> even instantly after you read it.

So what?

> Now, try "ls -l" twice instead of reading from a file.  Notice
> that no io happens the second time.  Here we're reading

Directory data is cached. 

> metadata instead of file data.  This sort of stuff
> is cached in separate caches that assumes nothing
> else modifies the disk.

True, and I'm happy to change it. I don't think we always had a
directory cache.

> > > filesystem you end up only haivng this option on the one(s) that you
> > > modify.
> > 
> > I intend to make the generic mechanism attractive.
> 
> It won't be attractive, for the simple reason that a no-cache fs
> will be devastatingly slow.  A program that read a file one byte at

A generic mechanism is not a "no cache fs". It's a generic mechanism.

> Nobody will have time to wait for this, and this alone makes your

Try arguing logically. I really don't like it when people invent their
own straw men and then procede to  reason as though it were *mine*.

> The main reason I can imagine for letting two machines write to
> the *same* disk is performance.  Going cacheless won't give you

Then imagine some more. I'm not responsible for your imagination ...

> that.  But you *can* beat nfs and friends by going for
> a "distributed ext2" or similiar where the participating machines
> talks to each other about who writes where.  
> Each machine locks down the blocks they want to cache, with
> either a shared read lock or a exclusive write lock.

That's already done.

> There is a lot of performance tricks you may use, such as

No tricks. Let's be simple.

Peter
