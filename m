Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282945AbRL2OQT>; Sat, 29 Dec 2001 09:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282934AbRL2OQJ>; Sat, 29 Dec 2001 09:16:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35589 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282823AbRL2OP7>;
	Sat, 29 Dec 2001 09:15:59 -0500
Date: Sat, 29 Dec 2001 15:15:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Stodden <stodden@in.tum.de>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20011229151534.D609@suse.de>
In-Reply-To: <20011228115956.E2973@suse.de> <Pine.LNX.4.10.10112281023000.24491-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10112281023000.24491-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28 2001, Andre Hedrick wrote:
> > On Thu, Dec 27 2001, Andre Hedrick wrote:
> > > 
> > > I would provide patches if you had not goat screwed the block layer and
> > > had taken a little more thought in design, but GAWD forbid we have design.
> > 
> > You still have zero, absolutely zero facts. _What_ is screwed?
> 
> Well your total lack of documentation.

Please stop making an even bigger as of yourself -- there are plenty of
docs, commented source, etc.

> You have changed portions of struct request * and no referrences.

Ditto

> You have change the behavor of calculating ones position of the
> rq->buffer, wrt "nr_sectors - current_nr_sectors".  There is still no
> valid reason yet given by you.

That you reference ->buffer and nr_sectors in the same sentence shows
that you never had a grasp of how this worked.

> > > You have made it clear that you do not believe in testing the data
> > > transport layers in storage.
> > 
> > That's not true. I would not mind such a framework. What I opposed was
> > you claiming that you can _proof_ data correctness. Verifying data
> > integrity and proof are two different things.
> 
> You have strange defs.
> 
> PROOF it works is done but "Verifying data integrity".
> 	thus
> "Verifying data integrity" is PROOF it works.
> 
> One of those silly mathmatic rules of equality.

Whatever

> > > Translation: You do not care if data gets to disk correctly or not.
> > 
> > Bullshit.
> 
> Really, then why did you not use the BUS Analyzers given to you to test
> your changes to the new BLOCK translation between FS and DRIVER.
> Obviously you have the tools, but you neglected to even look.

Did you see any data corruption in the intial bio patches? If you did,
you failed to report them.

> > > You have stated you do not believe in standards, thus you believe less in
> > > me because I "Co-Author" one for NCITS.
> > 
> > Please stop misquoting me. _You_ claim that if you have the states down
> > 100% from the specs, then your driver is proofen correct. I say that
> > believing that is an illusion, only in a perfect world with perfect
> > hardware would that be the case.
> 
> This is where you fail to understand, I do not know how to teach you
> anymore, nor does having you visit the folks in the drive making
> industry help because even they could not instruct you.

You keep trying to teach me industry talk, I keep trying to teach you
how the kernel works. Apparently we are both failing.

> > > You have stated the tools of the trade are worthless but you have an ATA
> > > and SCSI analyzer but you refuse to use them.  I know you have them
> > > because I know who provided them to you.
> > 
> > Again, I've _never_ made such claims. I have the tools, yes, and they
> > are handy at times.
> 
> Really! well let me replay an irc-log
> 
> *andre* maybe I trust it because it passes signal correctness on an ata-bus analizer
> *axboe* who has proven the analyzer? :)
> *andre* are you serious ?
> *axboe* of course
> *andre* that is all I want to know -- sorry I asked
> 
> Electrons do not lie.

This translates into I think analyzers are worthless?

> > > Maybe when you get off your high horse and begin to listen, I will quit
> > > being the ASS pointing out your faulty implimentation of BIO.  Maybe when
> > > you decide it is important we can try to work togather again.
> > 
> > ... obviously no need for me to comment on this.
> 
> Yes because you have no intention of getting off your high-horse.

No it means that I refuse to fall back to the petty name calling game
you are now playing. You have yet to single out a single flaw in bio
general or design. All you do is bitch and complain without facts --
makes me wonder how much of the stuff you actually understand. Welcome
to my kill file.

> > > One thing you need to remember, BLOCK is everybodies "BITCH".
> > > FileSystems dictate to BLOCK there requirements.
> > > Low_Level Drivers dictate to BLOCK there rulesets.
> > > BLOCK is there to bend over backwards to make the transition work.
> > > BLOCK is not a RULE-SETTER, it is nothing but a SLAVE, and it has to be
> > > damn clever.  One of you assests is you are "clever", but that will not
> > > cover your knowledge defecits in pure storage transport.
> > 
> > I agree.
> 
> Really, now that you are backed into a corner I will tell you how the
> driver is to work and you will adjust block to conform to that ruleset.

Lets rephrase that into "you are free to make suggestions and send
patches", then I agree. Block may be everyones bitch, I'm certainly not
yours.

> > > BUZZIT on mixing two issues that are volitale on there own rights to sort
> > > out.  The high memory bounce and block are two different changes, and one
> > > is dependent on the other, regardless if you see it or not.
> > 
> > Explain.
> 
> Given the volitale nature of these two areas on their own, why would
> anyone in their right mind mix the two.

They are two seperate layers still. Maybe you need to read this code
again. Let me recommend Suparna's doc again.

> > > BUZZIT on your short sightedness on the immediate intercept of command
> > > mode
> > 
> > Explain
> 
> Well the obvious usage for "immediate immediate" is for domain-validation.
> This allows one to test and access the behavor of the codebase before
> assuming it is valid and it gives you a way to compare expected v/s
> observed when using a bus analyzer.  This is another way to verify if the
> code written is doing what is expected.

That may be so, how this relates to any complaints about bio design or
whatever is not clear. As usual.

> > > BUZZIT on you himem operations that is not able to perform the vaddr
> > > windowing for the entire request, but choose to suffer the latency of
> > > single sector transaction repetion.
> > 
> > s/single sector/single segment. And that temp mapping is done for _PIO_
> > for christ sakes, I challenge you to show me that being a bottleneck in
> > any way at all. Red herring.
> 
> "bottleneck" no, it breaks a valid and tested method for using the
> buffer, and PIO is where we land if we have DMA problems.

No it doesn't, you can use ->buffer any way you want still. 

> > > BUZZIT on your total lack of documention the the changes to the
> > > request_struct, otherwise I could follow your mindset and it would not be
> > > a pissing contest.
> > 
> > Tried reading the source?
> 
> I would if there were any docs.

Andre, want me to comment on that again?

> Maybe you could finally explain your new recipe for the changes in the
> request struct.  I have been asking you in private for more than a month
> and you have yet to disclose the usage.

I've _explained_ it to you several times. I have better things to do
than keep doing so. Especially if you either cannot or don't want to
read the souce and see for yourself, or the external bio reference that
is Suparna's bio notes.

> Recall above where you agree that BLOCK is a SLAVE to the DRIVER.
> Now I require that upon entry the following be set and only released upon
> the dequeuing of the request.
> 
> 
> to = ide_map_buffer(rq, &flags);
> 
> This is to be performed upon entry for the given request.
> It is to be released upon a dequeuing.
> 
> ide_unmap_buffer(to, &flags);
> 
> This will allow me to walk "to" and not "buffer" so that BLOCK can
> properly map into the DRIVER.

You don't know how the kmap stuff works, do you?

> As you can see "rq->nr_sectors" is not touched, nor is "rq->buffer".
> This was your primary bender and I fixed it but you choose not to use it.
> I only modify "rq->current_nr_sectors" and no longer bastardize the rest
> of the request.

current_nr_sectors was the only problem, hard_nr_sectors and hard_sector
have been in place for some time. hard_cur_sectors is there too in 2.5
now, so you can screw current_nr_sectors as much as you want now too.

> > > BUZZIT on your moving CDROM operations to create a bogus BLOCK_IOCTL, for
> > > what?  Who know it may have some valid usage, but CDROM is not it.
> > 
> > That part isn't even started yet, block_ioctl is just to show that
> > rq->cmd[] and ide-cd does work with passing packet commands around.
> 
> Well maybe if you had or would disclose a model then people could help and
> not be left wondering about the mess created, while working to clean up a
> bigger mess from the past.

Still babbling about docs?? Please show me a sub system change as widely
documented as the bio change in recent times? Funny how everyone else
thinks the docs are good. Have you read them? Did you understand them?
Did you read the source? Or are you just too busy moaning on irc or here
to do so?

> > > BUZZIT on your cut and past in block to make an effective rabbit warren or
> > > chaotic maze to make it total opaque in what is really going on.
> > 
> > Again, what are you talking about?
> 
> Well after discussing w/ Suparna, I now understand that it is related to
> the multi-segments but I am sure that most do not see that because it is
> not comments or explained in any model.  Much of what I saw was a glorious
> cut-n-paste job to make a readable (but rather large function) now
> scattered and run through a whopper-chopper.  However I see some of the
> validity of the changes but still much needs explaining.

There are no big and glorious cut-n-paste jobs. I'm so sick of you
making claims that are nothing but Andre FUD.

> > Congratulations on spending so much time writing an email with very
> > little factual content. Here's an idea -- try backing up your statements
> > and claims with something besides hot air.
> 
> And for you in a total waste of communication requests from the past that
> have yet to appear, thus I have to be a BOHA to get your attention.
> However you still ignore valid questions and concerns.

I don't ingore valid questions and concerns. I ignore _you_ from time to
time, you are time consuming and I usually have better ways
to spend my time.

-- 
Jens Axboe

