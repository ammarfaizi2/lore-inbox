Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbRG2AiH>; Sat, 28 Jul 2001 20:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267419AbRG2Ah4>; Sat, 28 Jul 2001 20:37:56 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:46471 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267418AbRG2Ahn>; Sat, 28 Jul 2001 20:37:43 -0400
Message-ID: <047c01c117c6$a86d1890$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: "Kurt Garloff" <garloff@suse.de>, "David Lang" <dlang@diginsite.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <cw@f00f.org>, <ppeiffer@free.fr>,
        <linux-kernel@vger.kernel.org>, "Arjan van de Ven" <arjanv@redhat.com>,
        "Chris Brady" <crsbrady@earthlink.net>
In-Reply-To: <E15QEP3-0006TF-00@the-village.bc.nu> <Pine.LNX.4.33.0107271718550.29714-100000@dlang.diginsite.com> <20010728131159.B23174@pckurt.casa-etp.nl>
Subject: Re: VIA KT133A / athlon / MMX
Date: Sat, 28 Jul 2001 17:37:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

From: "Kurt Garloff" <garloff@suse.de>

On Fri, Jul 27, 2001 at 05:23:07PM -0700, David Lang wrote:
> I have a 1u box at my des that has two MSI boards in it with 1.2G athlons.
> at the moment they are both running 2.4.5 (athlon optimized), one box has
> no problems at all while the other dies (no video, no keyboard, etc)
> within an hour of being booted.

Somebody told he had the same MoBo already replaced a couple of times ...

Kurt, et al, I have been following this VIA vs Linux thing for some time
now. (My "big machine" is an Athlon based system. So it interests me.)
Comments have been made about the size of power supply needed to keep these
systems happy with 400 watts coming up in discussions frequently. But if you
pause to think on it a few minutes you begin to wonder about this concept.
The RAM runs at about 3.3 volts. The CPU core runs at about 1.7v (in my case.)
So both of these are running off of power supplies on the motherboards that
take the 5 volts down to something reasonable. If the problem is inadequate
power supply AND it is more of a problem with some motherboards than others
I look for the volts. Where are the losses which could cause this. One source
is the connector from the power supply to the motherboard. (This was a chronic
problem with A2000s, for example.) I don't see newer style connectors that
have less contact resistance on any systems. That is probably a factor. Since
the problem is greater with some boards than others I suspect that the
auxilliary power sipplies on the motherboards are better for some boards than
for others. Somebody with hardware access to a sufficient variety of mother-
boards should survey this. Do they all use exactly the same power supply parts?

Another issue is the speed of these systems. And the Athlon problem seems to
peak when driving the various buses at their peaks. RF crosstalk is an issue
that a lot of digital designers claim to understand when they design (and
model) their circuits. Now, I built my first circuit analysis program back
in about 1975. Results of that work fly on GPS satellites today. Since it was
MY program I used for design I was acutely aware of its deficiencies as well
as the modeling deficiencies. At some point in the analysis you cut a corner
or two in order to make the calculations tractable. You do not manage to get
all the "strays" into the models. What I ams saying is that board layout is
another area where problems may exist.

These are not thigs software settings in the VIA chips can cure. On another
mailinglist catering to developers for very exotic video cards some problems
with the latest INTEL based motherboards are appearing. (DigiSuite:E and its
kith and kin drive the PCI bus very hard.) I suspect we have a situation not
properly anticipated in modeling the backplanes on all these boards. And until
the designers can wrap their minds around the entire problem the software
solution may simply be, in the words of an old philospher, "Slow down! You move
too fast." At the same time someone with suitable test equipment needs to look
for voltage glitches out of the motherboard regulators and we need to develop
software tools for "forcing" the suspected crosstalk and ideally characterising
it with regards to data passing on the bus at the time of the bad data transfer.
The software based fixes seem to be shooting at black cats in a coal mine
without a flashlight or IR goggles.

{^_^}    Joanne Dow, jdow@earthlink.net


