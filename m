Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129744AbQLGPi7>; Thu, 7 Dec 2000 10:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129845AbQLGPit>; Thu, 7 Dec 2000 10:38:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6919 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129744AbQLGPie>;
	Thu, 7 Dec 2000 10:38:34 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012071411.eB7EB4Y11843@flint.arm.linux.org.uk>
Subject: Re: 2.4.0-test12-pre7
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 7 Dec 2000 14:11:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10012061728180.2606-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 06, 2000 05:29:14 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
>     - me: UHCI drivers really need to enable bus mastering.

But it'll already be turned on if pci_assign_unassigned_resources() is
called.  This calls pdev_enable_device for every single device, which
turns on the bus master bit in the PCI command register.

Is it intentional that pci_assign_unassigned_resources should:
1. enable all devices?
2. enable bus master on all devices?
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
