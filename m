Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137041AbRA1NPd>; Sun, 28 Jan 2001 08:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137055AbRA1NPO>; Sun, 28 Jan 2001 08:15:14 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:26630 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S137041AbRA1NPB>;
	Sun, 28 Jan 2001 08:15:01 -0500
Date: Sun, 28 Jan 2001 06:14:28 -0700
From: yodaiken@fsmlabs.com
To: Nigel Gamble <nigel@nrg.org>
Cc: Paul Barton-Davis <pbd@Op.Net>, yodaiken@fsmlabs.com,
        Andrew Morton <andrewm@uow.edu.au>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Message-ID: <20010128061428.A21416@hq.fsmlabs.com>
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; from Nigel Gamble on Sun, Jan 21, 2001 at 06:21:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2001 at 06:21:05PM -0800, Nigel Gamble wrote:
> Yes, I most emphatically do disagree with Victor!  IRIX is used for
> mission-critical audio applications - recording as well playback - and
> other low-latency applications.  The same OS scales to large numbers of
> CPUs.  And it has the best desktop interactive response of any OS I've

And it has bloat, it's famously buggy, it is impossible to maintain, ...


> used.  I will be very happy when Linux is as good in all these areas,
> and I'm working hard to achieve this goal with negligible impact on the
> current Linux "sweet-spot" applications such as web serving.

As stated previously: I think this is a proven improbability and I have
not seen any code or designs from you to show otherwise.

> I agree.  I'm not wedded to any particular design - I just want a
> low-latency Linux by whatever is the best way of achieving that.
> However, I am hearing Victor say that we shouldn't try to make Linux
> itself low-latency, we should just use his so-called "RTLinux" environment

I suggest that you get your hearing checked. I'm fully in favor of sensible
low latency Linux. I believe however that low latency  in Linux will
	A. be "soft realtime", close to deadline most of the time.
	B. millisecond level on present hardware
	C. Best implemented by careful algorithm design instead of 
	"stuff the kernel with resched points" and hope for the best.

RTLinux main focus is hard realtime: a few microseconds here and there
are critical for us and for the applications we target. For consumer
audio, this is overkill and vanilla Linux should be able to provide
services reasonably well. But ...

> for low-latency tasks.  RTLinux is not Linux, it is a separate
> environment with a separate, limited set of APIs.  You can't run XMMS,
> or any other existing Linux audio app in RTLinux.  I want a low-latency
> Linux, not just another RTOS living parasitically alongside Linux.

Nice marketing line, but it is not working code.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
