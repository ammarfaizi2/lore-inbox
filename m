Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274990AbRJNJPR>; Sun, 14 Oct 2001 05:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274991AbRJNJPI>; Sun, 14 Oct 2001 05:15:08 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:29068 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S274990AbRJNJO6>; Sun, 14 Oct 2001 05:14:58 -0400
Message-ID: <3BC957AC.FFA61194@welho.com>
Date: Sun, 14 Oct 2001 12:15:24 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <3BC9441C.887258DA@welho.com>
		<20011014.011246.59654800.davem@redhat.com>
		<3BC94F3A.7F842182@welho.com> <20011014.020326.18308527.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Mika Liljeberg <Mika.Liljeberg@welho.com>
>    Date: Sun, 14 Oct 2001 11:39:22 +0300
> 
>    [Otherwise a sender can force us into a permanent quickack mode
>    simply by setting PSH on every segment.]
> 
> "A sending TCP can send us garbage so bad that it hinders
> performance."
> 
> So, your point is? :-)  A sensible sending application, and a sensible
> TCP should not being setting PSH every single segment.

Like apache and linux? :-)

>  And we're not
> coding up hacks to make the Linux receiver handle this case better.

By the same logic we could throw away Nagle and SWS avoidance! Whatever
happened to "be conservative in what you send" (i.e. acks, in this
case)?

Frankly, I see no reason for acking PSH segments immediately. What's the
rationale for doing so? Looks like a hack to me...

I don't mean to be a pest, but it would be nice to get some technical
grounds for this behavour, since you're obviously convinced that there
are some. Please?

> You'll have much better luck convincing us to implement ECN black hole
> workarounds :-)

Oh, no. I'm not going to be dragged into that discussion! :) [Do we have
such workarounds for PMTUD detection, I wonder...]

Cheers,

	MikaL
