Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263973AbRFIFrx>; Sat, 9 Jun 2001 01:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263976AbRFIFrn>; Sat, 9 Jun 2001 01:47:43 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:34067 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263973AbRFIFr2>;
	Sat, 9 Jun 2001 01:47:28 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106090545.f595jxp478161@saturn.cs.uml.edu>
Subject: Re: temperature standard - global config option?
To: mhw@wittsend.com (Michael H. Warfield)
Date: Sat, 9 Jun 2001 01:45:59 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        mhw@wittsend.com (Michael H. Warfield), bootc@worldnet.fr (Chris Boot),
        isch@ecce.homeip.net (mirabilos {Thorsten Glaser}),
        lk@aniela.eu.org (L. K.),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <20010608191600.A12143@alcove.wittsend.com> from "Michael H. Warfield" at Jun 08, 2001 07:16:00 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael H. Warfiel writes:
> On Fri, Jun 08, 2001 at 05:16:39PM -0400, Albert D. Cahalan wrote:

>> The bits are free; the API is hard to change.
>> Sensors might get better, at least on high-end systems.
>> Rounding gives a constant 0.15 degree error.
>> Only the truly stupid would assume accuracy from decimal places.
>> Again, the bits are free; the API is hard to change.
...
> 	No...  The average person, NO, the vast majority of people,
> DO assume accuracy from decimal places and honestly do not know the
> difference between precision and accuracy.  I've had comments on this
> thread in private E-Mail the reinforce this impression.

Fine. Most user apps can round to the nearest degree, or even
display the values "cool", "warm", "hot", and "BURNING!".
The kernel API should not be so limiting.

> 	Even the rounding error vis-a-vis the .15 is silly and irrelevant!
> If the sensor is +- 1 degree, you can't even measure the rounding error,
> even if you HAVE two decimal places.  With that degree of accuracy, you
> are no better off than 273 with no decimal places.  Worrying about rounding
> error on .15 when the accuracy is in the units is exactly the kind of
> misinformed false precision that I worry about.  You actually though that
> the .15 was significant enough to worry about round error when, in fact,
> it will be impossible to measure with the equipment available in the
> environment of discourse.

The 0.15 may mean the difference between:

a.  less than 0.005 chance of exceeding 370 degrees
b.  less than 0.01 chance of exceeding 370 degrees

for a measurement that might be 365 degrees.

>> One might provide other numbers to specify accuracy and precision.
>
> 	Now...  That I can agree with and it would make absolute sense.
> Especially if we were discussing lab grade or scientific grade measure
> equipment and measurements.  In fact, that would be a requirement for
> any validity to be attached to measurements of that level of precision.

No, at any level of precision. I'd sure want to know if the device
is specified as "resolution 8 degrees, standard deviation 23".

This information is fairly important. The user is responsible for
defining acceptable risk, and the app should be able to provide a
warning or shutdown based on this.

For typical PC hardware, one might assume that the device is a
cheap piece of junk 2 mm below the CPU. (with quite a bit of lag!)
The lag ought to be specified too of course.
