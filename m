Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282177AbRK1QhW>; Wed, 28 Nov 2001 11:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282173AbRK1QhM>; Wed, 28 Nov 2001 11:37:12 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:51335 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S282175AbRK1Qgz>; Wed, 28 Nov 2001 11:36:55 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200111281635.QAA02768@mauve.demon.co.uk>
Subject: Re: Journaling pointless with today's hard disks?
To: nitrax@giron.wox.org (Martin Eriksson)
Date: Wed, 28 Nov 2001 16:35:55 +0000 (GMT)
Cc: matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        linux-kernel@vger.kernel.org
In-Reply-To: <007d01c1776a$d11d4680$0201a8c0@HOMER> from "Martin Eriksson" at Nov 27, 2001 06:42:00 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> ----- Original Message -----
> =46rom: "Matthias Andree" <matthias.andree@stud.uni-dortmund.de>
> To: <linux-kernel@vger.kernel.org>
> Sent: Tuesday, November 27, 2001 5:39 PM
> Subject: Re: Journaling pointless with today's hard disks?
> 
<snip>

> I think most people here are convinced that there is not time to write  a
> several-MB (worst case) cache to the platters in case of a power failure.
> Special drives for this case could of course be manufactured, and here's
> a theory of mine: Wouldn't a battery backed-up SRAM cache do the thing?

No.
Sram is expensive, as are batteries (they also tend to have poor
cycle life, and mean that you only keep the data until the battery dies.

Numbers...

Taking again as an example, something that's in my machine:
The Fujitsu MPG3409AT, a bargain basement 40G drive.
2 platters, 5400RPM.
It has (at the high end) 798 sec/track.
Worst case, to write a journal track takes a full seek, and at least one
complete rev.
Assuming that we want to write it over two tracks, 
This is 18ms + 11*2ms = 40ms.
Now, how much power? 
6.3W is needed, so that's .252J

Assuming that the 12V line can be allowed to sag to 10V, that'll take 20%^2 
of the energy of the cap out, so we need a cap that stores about .7J, or 
a 2500uF cap.

12V 2500uf aluminium electrolytic is rather large, 25mm long *10mm diameter.
There is space for this, in the overall package, but it would need a slight
redesign.
The cost of the component is about 10 cents US.
Another 20-80 cents may be needed for the power switch.
This assumes that no power can be used from the spindle motor, which may
well be wrong.
