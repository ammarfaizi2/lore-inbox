Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274513AbRIYGR7>; Tue, 25 Sep 2001 02:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274515AbRIYGRs>; Tue, 25 Sep 2001 02:17:48 -0400
Received: from femail30.sdc1.sfba.home.com ([24.254.60.20]:21996 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274513AbRIYGRk>; Tue, 25 Sep 2001 02:17:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Date: Mon, 24 Sep 2001 23:17:58 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.30.0109251335520.18440-100000@gamma.student.ljbc>
In-Reply-To: <Pine.LNX.4.30.0109251335520.18440-100000@gamma.student.ljbc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010925061757.MRRX14971.femail30.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 September 2001 11:00 pm, Beau Kuiper wrote:
> On Mon, 24 Sep 2001, Nicholas Knight wrote:

> > It's a very remote possability of failure, like most instances
> > where write-cache would cause problems. Catastrophic failure of the
> > IDE cable in mid-write will cause problems. If write cache is
> > enabled, the write stands a higher chance of having made it to the
> > drive before the cable died, with it off, it stands a higher chance
> > of NOT having made it entirely to the drive.
>
> Catastrophic failure of the IDE cable???.
> What are you doing to the poor thing, jumping on it?

actually, jumping on it while it's flat probably wouldn't cause too 
many problems... :P
It's not neccisarily that the cable failed, poor choice of words on my 
part probably, the instance I was thinking of was the cable pulled out 
of the drive while it's in operation, I've seen cables pulled and 
nearly pulled out of drives in operation, it can happen with a slip of 
your hand while checking a fan, I poke around in my system while it's 
on all the time, luckily I've yet to pull out the cable on my own 
system, but I've seen it done.

>
> Anyway, with a UPS, the issue of IDE device write caching is fairly
> moot. As long as power is applied, any write issued to the drive will
> be completed regardless of whether write caching is on or off. I am

This was my point in all this really, aside from failure of the drive 
itself, add a cheap UPS and the only risk is that your HDD controller 
decides to write garbage :)

> fairly certain the write caching is pretty conservative, which is
> write as soon as possible after elavating with other write requests
> and giving read requests priority.
>
> I can imagine how it improves sequenial write performace too. With
> the write cache off, the computer cannot send another write request
> to the IDE device until the last one had finished. By the time the
> computer is told the request was finished and it has sent a new
> request to the drive, the disk would have spun out of the place it
> was supposed to be placed. The drive will then have to wait for the
> disk to spin around fully again before doing the write. With the
> write cache enabled, several requests can be placed into the drive
> buffer and written in the single revolution of the drive.

OK, now THIS makes sense! Thanks.

>
> Beau Kuiper
> kuib-kl@ljbc.wa.edu.au
