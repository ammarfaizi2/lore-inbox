Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286841AbRL1LBp>; Fri, 28 Dec 2001 06:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286844AbRL1LBg>; Fri, 28 Dec 2001 06:01:36 -0500
Received: from fepD.post.tele.dk ([195.41.46.149]:26342 "EHLO
	fepD.post.tele.dk") by vger.kernel.org with ESMTP
	id <S286841AbRL1LBX>; Fri, 28 Dec 2001 06:01:23 -0500
Date: Fri, 28 Dec 2001 11:59:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Stodden <stodden@in.tum.de>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20011228115956.E2973@suse.de>
In-Reply-To: <20011227155403.A1730@suse.de> <Pine.LNX.4.10.10112271046070.24491-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10112271046070.24491-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27 2001, Andre Hedrick wrote:
> 
> I would provide patches if you had not goat screwed the block layer and
> had taken a little more thought in design, but GAWD forbid we have design.

You still have zero, absolutely zero facts. _What_ is screwed?

> You have made it clear that you do not believe in testing the data
> transport layers in storage.

That's not true. I would not mind such a framework. What I opposed was
you claiming that you can _proof_ data correctness. Verifying data
integrity and proof are two different things.

> Translation: You do not care if data gets to disk correctly or not.

Bullshit.

> You have stated you do not believe in standards, thus you believe less in
> me because I "Co-Author" one for NCITS.

Please stop misquoting me. _You_ claim that if you have the states down
100% from the specs, then your driver is proofen correct. I say that
believing that is an illusion, only in a perfect world with perfect
hardware would that be the case.

> You have stated the tools of the trade are worthless but you have an ATA
> and SCSI analyzer but you refuse to use them.  I know you have them
> because I know who provided them to you.

Again, I've _never_ made such claims. I have the tools, yes, and they
are handy at times.

> Maybe when you get off your high horse and begin to listen, I will quit
> being the ASS pointing out your faulty implimentation of BIO.  Maybe when
> you decide it is important we can try to work togather again.

... obviously no need for me to comment on this.

> One thing you need to remember, BLOCK is everybodies "BITCH".
> FileSystems dictate to BLOCK there requirements.
> Low_Level Drivers dictate to BLOCK there rulesets.
> BLOCK is there to bend over backwards to make the transition work.
> BLOCK is not a RULE-SETTER, it is nothing but a SLAVE, and it has to be
> damn clever.  One of you assests is you are "clever", but that will not
> cover your knowledge defecits in pure storage transport.

I agree.

> Now I am tired of this game you are playing, so lets spell it out.
> 
> Congratulations of your copying of the rq->special for the CDB transport
> out of the ACB driver that myself and two other people authored.

Strictly a cleanup, what's your point?

> Congratulations on you first attempts to create the "pre-builder" model
> that myself and one other has described to you, to bad you did not listen
> 9 months ago or you would have the bigger picture.

I did it now because it's easy to do, comprende? It can be done cleanly
because elv_next_request is there now.

> BUZZIT on mixing two issues that are volitale on there own rights to sort
> out.  The high memory bounce and block are two different changes, and one
> is dependent on the other, regardless if you see it or not.

Explain.

> BUZZIT on your short sightedness on the immediate intercept of command
> mode

Explain

> BUZZIT on you himem operations that is not able to perform the vaddr
> windowing for the entire request, but choose to suffer the latency of
> single sector transaction repetion.

s/single sector/single segment. And that temp mapping is done for _PIO_
for christ sakes, I challenge you to show me that being a bottleneck in
any way at all. Red herring.

> BUZZIT on your total lack of documention the the changes to the
> request_struct, otherwise I could follow your mindset and it would not be
> a pissing contest.

Tried reading the source?

> BUZZIT on your moving CDROM operations to create a bogus BLOCK_IOCTL, for
> what?  Who know it may have some valid usage, but CDROM is not it.

That part isn't even started yet, block_ioctl is just to show that
rq->cmd[] and ide-cd does work with passing packet commands around.

> BUZZIT on your cut and past in block to make an effective rabbit warren or
> chaotic maze to make it total opaque in what is really going on.

Again, what are you talking about?

Congratulations on spending so much time writing an email with very
little factual content. Here's an idea -- try backing up your statements
and claims with something besides hot air.

-- 
Jens Axboe

