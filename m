Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274547AbRITPyS>; Thu, 20 Sep 2001 11:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274548AbRITPyJ>; Thu, 20 Sep 2001 11:54:09 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:57867 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S274547AbRITPx4>; Thu, 20 Sep 2001 11:53:56 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: 2.4.10pre10 aic7xxx problem
Date: Thu, 20 Sep 2001 17:54:52 +0200
Message-Id: <20010920155452.15612@smtp.adsl.oleane.com>
In-Reply-To: <200108170001.f7H01GI82362@aslan.scsiguy.com>
In-Reply-To: <200108170001.f7H01GI82362@aslan.scsiguy.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin !

I'm having a problem with the aic7xxx driver in 2.4.10pre10, it used to
work fine with 2.4.10pre8. The card is a 2960 single channel SCSI2, the
drive is a SEAGATE ST34520N rev. 1444.
Weirdly, the 2 drivers have the same rev. (maybe you didn't change it ?),
the other difference between those kernels is that I compiled 2.4.10pre10
SMP. The machine is a PowerMac dual G4/450

Basically, when probing for disks, my external <> gets stuck (activity
led on) and the driver displays those messages after a longer than usual
pause:

Attampting to queue an ABORT message
Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer expired
aic7xxx_abort returns 8195
Attempting to queue a TARGET RESET
aic7xxx_dev_reset returns 8195
Recovery SCB completes

and then more of it... the drive is not detected.

Any clue ?

Regards,
Ben.


