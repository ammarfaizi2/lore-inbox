Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278967AbRKFK3f>; Tue, 6 Nov 2001 05:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278962AbRKFK30>; Tue, 6 Nov 2001 05:29:26 -0500
Received: from addleston.eee.nott.ac.uk ([128.243.70.70]:33716 "HELO
	addleston.eee.nott.ac.uk") by vger.kernel.org with SMTP
	id <S278924AbRKFK3N>; Tue, 6 Nov 2001 05:29:13 -0500
Date: Tue, 6 Nov 2001 10:29:12 +0000 (GMT)
From: Matthew Clark <matt@eee.nott.ac.uk>
X-X-Sender: <matt@perry>
To: <linux-kernel@vger.kernel.org>
Subject: PCI interrupts (round 2) + PCI bus question
Message-ID: <Pine.OSF.4.31.0111061000420.25740-100000@perry>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The first part of this mail follows up a previous request-
 "PCI interrupts" 5/11/2001-

***** Q1

I had a 1/2 dozen replies -all sensible- but between them there
was still a few questions.

I am writing a dev driver for a PCI card- this card will
generate a large number of interrupts (at ~1kHz) which can be
serviced very quickly.  The interrupt the card uses is the same
as another device in the computer (usb controller).

It looks like I must share the interrupt with the USB
controller-

How do I ensure that I get <my> interrupt and not the the USB
one?  (is this done automagically from my point of view?)

Is there anyway of getting a unique IRQ?

Is there a performance penalty with a shared penalty, if so
would it be significant at a kHz IRQ repetition?

(Thanks to the previous replies)

****** Q2

I have the nasty task of reverse engineering a semi-auto written
windows driver rather than using a hardware manual for writing
the driver-  so my information is sketchy.

The hardware is known to have a few problems and one of these
problems involves locking the machine solid.

It is suspected that this occurs when the hardware (for some
reason that is unknown to the hardware developers) stops
accepting data from the PCI bus.

Is it possible that the bus can over run and that this can lock
the machine?  If so is it possible to probe the bus to prevent
the overruns- The hardware comes with a "fix it" register that
can be used provided the problem can be detected prior to the
lock.

I know where the lockups occur- when I shove data from RAM to
PCI memory (using writel)- the driver will work for hours on end
and the lock the machine solid in one of these regions.

It looks like a hardware problem- I want to see if I can side
step it unitl the hardware developers fix it (maybe a long
time).

Any thoughts gratefully received


Thanks matt


