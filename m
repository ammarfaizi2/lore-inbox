Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbRFQS7G>; Sun, 17 Jun 2001 14:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbRFQS6q>; Sun, 17 Jun 2001 14:58:46 -0400
Received: from unthought.net ([212.97.129.24]:48849 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S262616AbRFQS6h>;
	Sun, 17 Jun 2001 14:58:37 -0400
Date: Sun, 17 Jun 2001 20:58:35 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 VM & swap question
Message-ID: <20010617205835.A12767@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010617104836.B11642@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010617104836.B11642@opus.bloom.county>; from trini@kernel.crashing.org on Sun, Jun 17, 2001 at 10:48:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001 at 10:48:36AM -0700, Tom Rini wrote:
> 'lo all.  I've got a question about swap and RAM requirements in 2.4.  Now,
> when 2.4.0 was kicked out, the fact that you need swap=2xRAM was mentioned.
> But what I'm wondering is what exactly are the limits on this.  Right now
> I've got an x86 box w/ 128ram and currently 256swap.  When I had 128, I'd get
> low on ram/swap after some time in X, and doing this seems to 'fix' it, in
> 2.4.4.  However, I've also got 2 PPC boxes, both with 256:256 in 2.4.  One
> of which never has X up, but lots of other activity, and swap usage seems
> to be about the same as 2.2.x (right now 'free' says i'm ~40MB into swap,
> 18day+ uptime).  The other box is a laptop and has X up when it's awake and
> that too doesn't seem to have any problem.  So what exactly is the real
> minium swap ammount?

It completely totally and absolutely depends on the kind of workloads you put
your system under.

I have a database server with 1G phys and 1G swap. It uses 950+ MB for cache,
as it should, and doesn't even *touch* swap.  This is 2.4.5.

I have another box with 384MB phys and 1G swap, and it's usually a few hundred
megs into swap.  That's what long-running memory hogs and big compilers do.

There is no simple answer.  swap = 2*phys may be reasonable for some desktop
uses, I don't know.  But there *is* *no* *simple* *answer*.

With the amount of work that's gone into just *understanding* why the VM
behaves as it does (even after the VM rewrite that was done exactly in order to
come up with a VM we could *understand*), it's beyond me how anyone can even
begin to think that one can define a set of simple and exact rules for minimum
or "optimal" (whatever that means) values for swap.


(if I sound pissed, don't worry, I'm not. I'm frustrated, that's different  ;)
-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
