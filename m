Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136733AbRAMMog>; Sat, 13 Jan 2001 07:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136749AbRAMMoQ>; Sat, 13 Jan 2001 07:44:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S136733AbRAMMoN>;
	Sat, 13 Jan 2001 07:44:13 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101131237.f0DCb8g15518@flint.arm.linux.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
To: andrewm@uow.edu.au (Andrew Morton)
Date: Sat, 13 Jan 2001 12:37:08 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        frank@unternet.org (Frank de Lange),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        manfred@colorfullife.com (Manfred Spraul), dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <3A5FCA86.4DB4682F@uow.edu.au> from "Andrew Morton" at Jan 13, 2001 02:24:54 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Linus Torvalds wrote:
> > I'm also nervous about the complete lack of locking in vortex_timer():
> > disabling interrupts doesn't mean that transmits couldn't be
> > pending. But maybe the hardware is ok with changing status concurrently.
> 
> disable_irq() is very useful in functions such as this.  It
> would be a shame to have to stop using it.

Doesn't the NCR53C9x SCSI drivers use disable_irq() a lot?  Do they have
any problems?
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
