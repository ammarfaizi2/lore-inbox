Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268691AbRGZUSr>; Thu, 26 Jul 2001 16:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268688AbRGZUS1>; Thu, 26 Jul 2001 16:18:27 -0400
Received: from [208.134.143.150] ([208.134.143.150]:59806 "EHLO
	mail.playnet.com") by vger.kernel.org with ESMTP id <S268686AbRGZUST>;
	Thu, 26 Jul 2001 16:18:19 -0400
Message-ID: <016801c11610$4ad44e40$0b32a8c0@playnet.com>
From: "Marty Poulin" <mpoulin@playnet.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: oops/bug in tcp, SACK doesn't work?
Date: Thu, 26 Jul 2001 15:19:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Perhaps this has been covered somewhere before, but for some reason it
doesn't look like the 2.4.7 (and previous 2.4.x?)  kernels responds to SACK
correctly. Instead of just resending the missing packet Linux resends the
entire packet stream as if it never received the SACK.

Only reason I noticed this was that I was debugging connection problems with
our servers that were running 2.4.5. I didn't figure the problem out for
several days, when I exhausted all else I decided it must be the checksum of
the retransmitted packets.  With that in hand a simple google search turned
up that there was already a patch for this included in the 2.4.7 kernel.
Doh!

Hence I am now scanning through 100-200 emails a day with the rest of you
just trying to keep up on the issues and bugs that affect me. There must be
a place to look for current and fixed bugs without pouring over change logs
and the entire mailing list?

In any case both of these problems were easily duplicated with three
machines. One of the machines was used as a router running NIST net emulator
( http://snad.ncsl.nist.gov/itg/nistnet/ ) that allows you to set packet
delay, bandwidth  and loss. This is a free implementation for Linux that is
currently in useable alpha (yup sometimes it crashes the router when
loaded), but hey it works reliable enough to get some testing done.


Marty Poulin
vandal@playnet.com
Lead Programmer
Host/Client Communications
Playnet Inc./Cornered Rat Software

