Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266453AbUHIKYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUHIKYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUHIKXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:23:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55774 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266453AbUHIKWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:22:17 -0400
Date: Mon, 9 Aug 2004 12:21:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040809102146.GY10418@suse.de>
References: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Joerg Schilling wrote:
> >From axboe@suse.de  Fri Aug  6 17:10:35 2004
> 
> >> Let me give you a short answer: If DMA creates so many problem on Linux,
> >> how about imlementing a generic DMA abstraction layer like Solaris does?
> 
> >We do have that. But suddenly changing the alignment and length
> >restrictions on issuing dma to a device in the _end_ of a stable series
> >does not exactly fill me with joyful expectations. It's simply that,
> >not lack of infrastructure.
> 
> If you _really_ _had_ a DMA abstraction layer, then ide-scsi would use
> DMA for all sector sizes a CD may have. The fact that ide-scsi does
> not use DMA easily proves that you are wrong.

For someone who apparently doesn't even bother to look at the source,
it's hard to discuss these things. "DMA abstraction layer" continues
your fine history of being deliberatly vague in that it can mean
basically anything or nothing.

> >> Please try to distinct between threads I did start and threads I have
> >> been drawn into. I am open to any serious discussion, however if you
> >> like to insist in things that have been agreed on being suboptimal for
> >> more than 20 years, you should have very good reasons _and_ be willing
> >> to explain them.
> 
> >Agreed between whom? I don't agree that this naming is sound, in fact I
> >think it's quite stupid.
> 
> If you like to call the Sun developers and the FreeBSD developers
> (which means people like Bill Joy and Scott Mcusick) stupid, you seem
> to have a real strange idea from the world :-(

I'm not calling anyone stupid, I'm saying that applying that addressing
to all types of devices across all OS's is stupid. And I believe you are
the one trying to do that, not any of the above mentioned people.

> AGAIN: if you believe you did invent a better method, _describe_ it.
> As you did not describe a _working_ method different from the one I
> request, you need to agree that you are wrong - as long as your
> description is missing.

I did not invent a better method, but one exists - in Linux this is the
device special file.

> >I am focused on Linux, that's what I work on. And I truly think the
> >device naming option is so much easier for users that it's not even
> >funny.
> 
> So let me use other words: While I am focussed on the cdrtools uses on
> _all_ platforms, you are not :-(

Of course I'm not, I don't hack the beast. I believe your notion of
trying to use one grand unified addressing scheme all over is completely
broken. That you attempt to shove that down the throat of Linux is your
issue, I could not care less.

> >> As 50% of all problems reported for cdrecord on Linux look like Linux
> >> kernel problems, this is what I do every day.
> 
> >Just because they look like Linux kernel problems, doesn't mean that
> >they are :-)
> 
> I am able to distinct between something that only looks like a kernel
> problem and something that really is a kernel problem. As long as you

You've already shown that statement to be false many times in this
thread.

> define everything to be a non kernel problem :-( see the Linux Kernel
> bug with SG_SET_RESERVED_SIZE) I don't know how to continue the
> discussion with you.

As I've said before, of course there are bugs in the kernel. At least I
can stand up and say "yes that's a bug, my fault, I'll fix it". I don't
even need 20 years of experience to do that.

> >A textual description of the problem is not a fix. Or did I miss the
> >patch? If so, I apologize.
> 
> Being able to read seems to be a real advantage....

Listen, you silly little man: if you want things fixed in the kernel,
you provide a patch. Understand that concept?

> >> The importance could be limited if there were unique instance numbers
> >> for ATAPI devices using the same address space as the other SCSI
> >> devices.  For now, ide-scsi is really important.
> 
> >It's not the same address space, so there is not.
> 
> Well you just did prove that forcing people to send SCSI commands via
> non SCSI parts of the kernel is a design bug

Whatever.

> >> Let's see whether "Linux" is open enough to listen to the demands of
> >> the users......
> 
> >We try, when they make sense...
> 
> You should learn what "make sense" means, Linux-2.6 is a clear move
> away from the demands of a Linux user who likes to write CDs/DVDs.

It's a move away from your silly idea of what users want. It's a move in
the right direction.

-- 
Jens Axboe

