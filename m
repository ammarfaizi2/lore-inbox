Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290747AbSBLP5V>; Tue, 12 Feb 2002 10:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291038AbSBLP5M>; Tue, 12 Feb 2002 10:57:12 -0500
Received: from boink.boinklabs.com ([162.33.131.250]:22288 "EHLO
	boink.boinklabs.com") by vger.kernel.org with ESMTP
	id <S290747AbSBLP47>; Tue, 12 Feb 2002 10:56:59 -0500
Date: Tue, 12 Feb 2002 10:56:58 -0500
From: Charlie Wilkinson <cwilkins@boinklabs.com>
To: linux-kernel@vger.kernel.org
Subject: Hard lock-ups on RH7.2 install - Via Chipset?
Message-ID: <20020212105658.D11655@boink.boinklabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
X-Home-Sweet-Home: RedHat 6.0 / Linux 2.2.12 on an AMD K6-225
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings fellow bit jockeys,
This has been driving me nuts for over a week now.  All discussion
found and solutions tried so far have proven fruitless.  If someone
could point me at a fix or offer any insights, I would be most thrilled.
I've read about some Athlon/Via related problems, so I'm hoping it fits
in with that somehow.

The box is a AMD 1.3GHz Athlon with a "bcm Advanced Research" BC133KT-100
motherboard (Via KT133/VT8363/686B), two Promise Ultra100Tx2 cards, and
an IBM 75gb drive on each IDE channel (four drives in all).  The graphics
card is an Nvidia TNT2 AGP, but I'm thinking that doesn't matter too
much as the problem occurs just fine in character mode with no activity
on the screen.  I've yanked out network cards, disabled unused ports,
picked conservative BIOS settings, but to no avail.

The problem first occurred when I tried to do a RH7.2 install.  I set
each drive up identically, creating a software RAID5 container across all
four drives.  The box consistently freezes solid either while creating
the ext3 filesystem on RAID5, or in the early phases of the .rpm march.
(Note that means concurrent load on all four drives...)

Numerous things tried...  Finally booted into rescue mode (starting with
the latest RH7.2 updated boot image, FWIW) and tried running concurrent
dd's out to the drives in various combinations, as in:

(dd if=/dev/zero of=/dev/hde2 &) ; (dd if=/dev/zero of=/dev/hdg2 &) ; etc...

What I found was that writing out to any two drives was fine.  Writing to
all four will consistently lock up the machine after about 5-10 seconds.
So it seems load related.  (No, I didn't try three drives.)

Any clues?  Any fixes?  Pretty please?  :)

-cw-
