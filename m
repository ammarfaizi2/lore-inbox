Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274108AbRISRPI>; Wed, 19 Sep 2001 13:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274109AbRISRO7>; Wed, 19 Sep 2001 13:14:59 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:50948 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S274108AbRISROs>; Wed, 19 Sep 2001 13:14:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
Date: Wed, 19 Sep 2001 13:15:08 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010919154701.A7381@stud.ntnu.no> <20010919165503.A16359@gondor.com> <9oafeu$1o0$1@penguin.transmeta.com>
In-Reply-To: <9oafeu$1o0$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010919171454Z274108-760+14176@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works fine on the KX133 chipset that is on the Abit KA7 motherboard.  So, 
i for one have not applied the patch. 


On Wednesday 19 September 2001 12:00, Linus Torvalds wrote:
> In article <20010919165503.A16359@gondor.com>,
>
> Jan Niehusmann  <jan@gondor.com> wrote:
> >Additionally, look at who tested the 'fix' up to now: Probably only
> >people who had a problem before. And for all of them, the problem got
> >fixed. But do we know what happens if we use this 'fix' on a computer
> >that is not broken? No. Perhaps it breaks when we apply the 'fix'?
>
> This is my personal main worry.
>
> The problem with things like these is that people for whom the old code
> works fine don't tend to be interested in "fixes" floating around on the
> net - whether it is for Athlon chipset problems or for driver bugs or
> anything else.
>
> Which means that the "statistical sampling" is very skewed by
> self-selection, and anybody who knows anything about statistics knows
> that sample selection is _very_ important.
the only way it'll get a good sampling is to put it in the kernel 
I suggest not adding this to the "athlon" cpu selection code.  Rather make it 
a sub-option like many other drivers have.  That way people can select 
whether they need it or not until we are sure it's totally safe for everyone 
to use it by Via saying so or something.   Just a suggestion, other drivers 
do the same thing, so why not the cpu selection screen for workarounds. 


>
> Right now, for example, I'm leaning towards applying the patch, but
> quite frankly I'm still not certain.  Getting _some_ kind of information
> out of VIA would be really good - even just an ACK from somebody who is
> under NDA and can say just "yes, it's safe to clear bit 7 of reg 0x55".
>

> It is _probably_ an undocumented performance thing, and clearing that
> bit may slow something down. But it might also change some behaviour,
> and knowing _what_ the behaviour is might be very useful for figuring
> out what it is that triggers the problem.
>
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
