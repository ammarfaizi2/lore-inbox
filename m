Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbQKPPde>; Thu, 16 Nov 2000 10:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbQKPPdZ>; Thu, 16 Nov 2000 10:33:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10508 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130177AbQKPPdP>;
	Thu, 16 Nov 2000 10:33:15 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011161120.eAGBKUm08641@flint.arm.linux.org.uk>
Subject: Re: 2.4. continues after Aieee...
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Thu, 16 Nov 2000 11:20:30 +0000 (GMT)
Cc: dennis@etinc.com (Dennis), linux-kernel@vger.kernel.org
In-Reply-To: <200011151630.RAA04141@cave.bitwizard.nl> from "Rogier Wolff" at Nov 15, 2000 05:30:29 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> Dennis wrote:
> > network card driver) and leave the system running make linux unusable in
> > unattended environments as the machine is functionally dead.
> 
> Which doesn't help in this case, as your network card COULD be dead,
> while the system simply hasn't crashed....

Not every case causes a panic either.  This week, I had an instance of
an i686 box lock solid with a DFE-530TX net card.  Rebooting/power
cycling it didn't recover it (despite it working for the past month
without any problems).  It only started working again after I moved
it into a different PCI slot.

I've seen a couple of instances now on totally different hardware where
it is possible to lock a PCI bus solid by improper connections on some
of the PCI bus lines, so a faulty PCI socket seem to be the most likely
cause.

In this case, a "panic" doesn't help you; the machine experiances a
hardware lockup.  To catch these, you'd need a hardware watchdog.

What I'm basically saying is that there is only a limited amount that
Linux (or any OS) can do against these types of hardware failure.  If
you need better protection, try a hardware with user-space policy
implementations.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
