Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264398AbRFHXQx>; Fri, 8 Jun 2001 19:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264399AbRFHXQn>; Fri, 8 Jun 2001 19:16:43 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:28310 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S264398AbRFHXQd>; Fri, 8 Jun 2001 19:16:33 -0400
Date: Fri, 8 Jun 2001 19:16:00 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Michael H. Warfield" <mhw@wittsend.com>, Chris Boot <bootc@worldnet.fr>,
        mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
        "L. K." <lk@aniela.eu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
Message-ID: <20010608191600.A12143@alcove.wittsend.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"Michael H. Warfield" <mhw@wittsend.com>,
	Chris Boot <bootc@worldnet.fr>,
	mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
	"L. K." <lk@aniela.eu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010608140553.C20944@alcove.wittsend.com> <200106082116.f58LGd2497562@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <200106082116.f58LGd2497562@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Fri, Jun 08, 2001 at 05:16:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2001 at 05:16:39PM -0400, Albert D. Cahalan wrote:

> The bits are free; the API is hard to change.
> Sensors might get better, at least on high-end systems.
> Rounding gives a constant 0.15 degree error.
> Only the truly stupid would assume accuracy from decimal places.
> Again, the bits are free; the API is hard to change.

	Twice a year I'm a judge at science fairs.  Once at the local
level and once at the state level.  I generally judge on the senior
level in the physics category.  All too often I have a hard time even
convincing some of my fellow judges.

	Each year there is at least one project where some student has
used "fancy scientific equipment" to make measurements of impressive
precision and beautiful results.  Till you look closer and you find that
their standard deviation is as large as their averages and their raw
test results are all over the map.  With 5 or more decimal places of
precision, you find that their sample sizes and proceedures don't even
support one or two decimal places, if they are lucky.

	If it were not for the fact that I don't think they are really
that good at it, I would give them an award for "if you can't dazzle them
with brilliance, baffle them with bullshit".  Unfortunately, they honestly
don't KNOW the difference between precision and accuracy.  We often
judge between a half a dozen and a dozen exhibits.  This comes up
every year and gets written up in comments every year.  Of course, you
can't be harse in judging these things and most of them really do make a
legitimate effort, but it is difficult to tactfully explain to someone
why their elaborate and extremely detailed results amount to utter
jibberish.  (To the smartasses who are about to fire off the obligatory
smart remarks:  Trust me, I am much more tactful with those students
than I am on this list...  Maybe I shouldn't be.  Read that either way.)

	What's more apalling is that their teachers did not catch this
and I have to point out the fatal flaws to a lot of my co-judges who
were impressed with the scientific prowess of these individuals.

	No...  The average person, NO, the vast majority of people,
DO assume accuracy from decimal places and honestly do not know the
difference between precision and accuracy.  I've had comments on this
thread in private E-Mail the reinforce this impression.

	Yes, bits are free, sort of...  That's why an extra decimal
place is "ok".  Keeping precision within an order of magnitude of
accuracy is within the realm of reasonable.  Running out to two decimal
places for this particular application is just silly.  If it were for
calibrated lab equipment, fine.  But not for CPU temperatures.

	Yes, APIs are difficult to change.  But can you honestly say
that, even if we magically get off the shelf economical temperature sensors
that are two orders of magnitude more accurate (without need of constant
tracible recalibration - these things DO drift), that this level of
precision would have any real meaning at all?  I would expect the
CPU temperature to vary by a few hundreths of a degree just by how
many people were sweating in the cube next to me.

	Even the rounding error vis-a-vis the .15 is silly and irrelevant!
If the sensor is +- 1 degree, you can't even measure the rounding error,
even if you HAVE two decimal places.  With that degree of accuracy, you
are no better off than 273 with no decimal places.  Worrying about rounding
error on .15 when the accuracy is in the units is exactly the kind of
misinformed false precision that I worry about.  You actually though that
the .15 was significant enough to worry about round error when, in fact,
it will be impossible to measure with the equipment available in the
environment of discourse.

> One might provide other numbers to specify accuracy and precision.

	Now...  That I can agree with and it would make absolute sense.
Especially if we were discussing lab grade or scientific grade measure
equipment and measurements.  In fact, that would be a requirement for
any validity to be attached to measurements of that level of precision.
But that's not what we are talking about here, is it?  We're not talking
about a lab grade instrumentation API here, are we?  If we are, then
everything changes.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

