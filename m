Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRHTKwi>; Mon, 20 Aug 2001 06:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRHTKw1>; Mon, 20 Aug 2001 06:52:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:6159 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S267520AbRHTKwW>;
	Mon, 20 Aug 2001 06:52:22 -0400
Message-ID: <3B80EADC.234B39F0@evision-ventures.com>
Date: Mon, 20 Aug 2001 12:47:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Johan Adolfsson <johan.adolfsson@axis.com>
CC: Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org> <998193404.653.12.camel@phantasy> <3B80E01B.2C61FF8@evision-ventures.com> <21a701c12963$bcb05b60$0a070d0a@axis.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Adolfsson wrote:
> 
> Martin Dalecki <dalecki@evision-ventures.com> wrote:
> > I think you are just wrong - nobody really needs this patch. /dev/random
> > or /dev/urandom ar *both* anyway just complete overkill in terms of
> > practical security. /dev/urandom is in esp silly, since it is providing
> > a md5 hash implementation inside the kernel, which could be *compleatly*
> and
> > entierly done inside user land.
> 
> And I think you are wrong, this patch is needed.
> Keep up the good work Robert!
> 
> > You mean - there is no known algorithm with polynomial time
> > behaviour enabling us to calculate the next value of this function
> > from the previous ones - Not more nor less - no pysics and
> > entropy involved. If you assume this holds true it's mathematically
> > entierly sufficient that a single only seed value is not known.
> 
> Where would you get the single seed from in an embedded head
> less system if you don't have a hardware random generator,
> no disk and don't seed it from the network interrupts?

The device get's powerd up at a random time for the attacker.
That's entierly sufficient if you assume that your checksum function
f(i) hat the property that there is no function g, where we have
f(i+1)=g(f(i)), where g has a polynomial order over the time domain.
i is unknown for the attacker.
