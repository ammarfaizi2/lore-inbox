Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137111AbRA1OHr>; Sun, 28 Jan 2001 09:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137110AbRA1OHi>; Sun, 28 Jan 2001 09:07:38 -0500
Received: from cx739861-a.dt1.sdca.home.com ([24.5.249.153]:30725 "EHLO gnuppy")
	by vger.kernel.org with ESMTP id <S137070AbRA1OHU>;
	Sun, 28 Jan 2001 09:07:20 -0500
Date: Sun, 28 Jan 2001 06:07:04 -0800
To: yodaiken@fsmlabs.com
Cc: Nigel Gamble <nigel@nrg.org>, Paul Barton-Davis <pbd@Op.Net>,
        Andrew Morton <andrewm@uow.edu.au>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Message-ID: <20010128060704.A2181@gnuppy.monkey.org>
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org> <20010128061428.A21416@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010128061428.A21416@hq.fsmlabs.com>; from yodaiken@fsmlabs.com on Sun, Jan 28, 2001 at 06:14:28AM -0700
From: Bill Huey <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jan 28, 2001 at 06:14:28AM -0700, yodaiken@fsmlabs.com wrote:
> > Yes, I most emphatically do disagree with Victor!  IRIX is used for
> > mission-critical audio applications - recording as well playback - and
> And it has bloat, it's famously buggy, it is impossible to maintain, ...

However, that doesn't fault its concepts and its original goals. This
kind stuff is often more of an implementation and bad abstraction issue than
about faulty design and end goals.

> > used.  I will be very happy when Linux is as good in all these areas,
> > and I'm working hard to achieve this goal with negligible impact on the
> > current Linux "sweet-spot" applications such as web serving.
> As stated previously: I think this is a proven improbability and I have
> not seen any code or designs from you to show otherwise.

Andrew Morton's patch uses < 10 rescheduling points (maybe less from memory)
and in controlled, focused and logical places. It's certainly not a unmaintainable
mammoth unlike previous attempts, since Riel (many thanks) has massively
cleaned up the VM layer by using more reasonable algorithms, etc...

> I suggest that you get your hearing checked. I'm fully in favor of sensible
> low latency Linux. I believe however that low latency  in Linux will
> 	A. be "soft realtime", close to deadline most of the time.

Which is very good and maintainable with Andrew's patches.

> 	B. millisecond level on present hardware

Also very good an useable for many applications short of writting dedicated
code on specialized DSP cards.

> 	C. Best implemented by careful algorithm design instead of 
> 	"stuff the kernel with resched points" and hope for the best.

Algorithms ? which ones ? VM layer, scheduler ?  It seems there's enough
there in the Linux kernel to start doing interesting stuff, assuming that
there's a large enough media crowd willing to do the userspace programming.

> > for low-latency tasks.  RTLinux is not Linux, it is a separate
> > environment with a separate, limited set of APIs.  You can't run XMMS,
> > or any other existing Linux audio app in RTLinux.  I want a low-latency
> > Linux, not just another RTOS living parasitically alongside Linux.
 
> Nice marketing line, but it is not working code.

Mean what ? How does that response answer his criticism ?

bill

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
