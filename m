Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLNRXE>; Thu, 14 Dec 2000 12:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQLNRWy>; Thu, 14 Dec 2000 12:22:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12295 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129289AbQLNRWu>;
	Thu, 14 Dec 2000 12:22:50 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012141525.PAA00867@raistlin.arm.linux.org.uk>
Subject: Re: Fwd: [Fwd: [PATCH] cs89x0 is not only an ISA card]
To: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw)
Date: Thu, 14 Dec 2000 15:25:07 +0000 (GMT)
Cc: nico@cam.org (Nicolas Pitre), morton@nortelnetworks.com,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <20001214011415.E15157@arthur.ubicom.tudelft.nl> from "Erik Mouw" at Dec 14, 2000 01:14:15 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw writes:
> The Crystal CS89x0 ethernet chip is also used in quite some embedded
> systems that don't have an ISA bus at all, so the CONFIG_ISA option in
> drivers/net/Config.in is inapropriate. Here is a patch against
> 2.4.0-test12 to fix that. Please consider applying.

I don't think this is the right way to fix the problem.  Take for instance
an EBSA285 platform which has only PCI sockets.  It is possible to plug in
a card with an ISA bridge on, with a ESS SB clone on board (I have one here).

Maybe the right thing to do is to define CONFIG_ISA on these architectures/
machine types where the device itself is actually an ISA device, instead of
going through special-casing the driver configuration entries?
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
