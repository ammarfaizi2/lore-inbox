Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271241AbRHTOaS>; Mon, 20 Aug 2001 10:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271237AbRHTOaJ>; Mon, 20 Aug 2001 10:30:09 -0400
Received: from [195.63.194.11] ([195.63.194.11]:58384 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S271244AbRHTO3z>; Mon, 20 Aug 2001 10:29:55 -0400
Message-ID: <3B811DD6.9648BE0E@evision-ventures.com>
Date: Mon, 20 Aug 2001 16:25:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
CC: Johan Adolfsson <johan.adolfsson@axis.com>, Robert Love <rml@tech9.net>,
        Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com> <2248596630.998319423@[10.132.112.53]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel wrote:
> 
> > The device get's powerd up at a random time for the attacker.
> > That's entierly sufficient if you assume that your checksum function
> > f(i) hat the property that there is no function g, where we have
> > f(i+1)=g(f(i)), where g has a polynomial order over the time domain.
> > i is unknown for the attacker.
> 
> So, your argument is that there is no point in all this
> entropy collection anyway. So if everything is hunky dory,
> why have /dev/random block under such a circumstance?

You are entierly right. 

The primary reson of invention of /dev/random was the need
for a bit of salt to the initial packet sequence number inside
the networking code in linux. And for this purspose the
whole /dev/*random stuff is INDEED a gratitious overdesign.
For anything else crypto related it just doesn't cut the corner.
If you look at the archives I have objected it strongly in the history.
