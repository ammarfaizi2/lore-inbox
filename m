Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264308AbRFHVRn>; Fri, 8 Jun 2001 17:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264311AbRFHVRd>; Fri, 8 Jun 2001 17:17:33 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:63501 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264308AbRFHVRU>;
	Fri, 8 Jun 2001 17:17:20 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106082116.f58LGd2497562@saturn.cs.uml.edu>
Subject: Re: temperature standard - global config option?
To: mhw@wittsend.com (Michael H. Warfield)
Date: Fri, 8 Jun 2001 17:16:39 -0400 (EDT)
Cc: bootc@worldnet.fr (Chris Boot), mhw@wittsend.com (Michael H. Warfield),
        isch@ecce.homeip.net (mirabilos {Thorsten Glaser}),
        lk@aniela.eu.org (L. K.), acahalan@cs.uml.edu (Albert D. Cahalan),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <20010608140553.C20944@alcove.wittsend.com> from "Michael H. Warfield" at Jun 08, 2001 02:05:53 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael H. Warfiel writes:

> We don't have sensors that are accurate to 1/10 of a K and certainly not
> to 1/100 of a K.  Knowing the CPU temperature "precise" to .01 K when
> the accuracy of the best sensor we are likely to see is no better than
> +- 1 K is just about as relevant as negative absolute temperatures.
...
> 	Even if we had or could, anticiplate, sensors with a +- .01 K,
> the relevance of knowing the CPU temperature to that precision is
> lost on me.  I see no sense in stuffing a field with meaningless
> bits just because the field will hold them.  In fact, this "false precision"
> quickly leads to the false impression of accuracy.  Based on several
> messages I have seen on this thread and in private E-Mail, there are a
> number of people who don't seem to grasp the fundamental difference
> between precision and accuracy and truely don't understand that adding
> meaningless precision like this adds nothing to the accuracy.
>
> 	I can see maybe making it precise to .1 K.  But stuffing the bits
> in there to be precise to .01 K just because we have the bits and not
> because we have any realistic information to fill the bits in with, is
> just silly to me.  Just as silly as allowing for negative numbers in an
> absolute temperature field.  We have the bits to support it, but why?

The bits are free; the API is hard to change.
Sensors might get better, at least on high-end systems.
Rounding gives a constant 0.15 degree error.
Only the truly stupid would assume accuracy from decimal places.
Again, the bits are free; the API is hard to change.

One might provide other numbers to specify accuracy and precision.

