Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLNTr5>; Thu, 14 Dec 2000 14:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132638AbQLNTrr>; Thu, 14 Dec 2000 14:47:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11277 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129383AbQLNTrg>;
	Thu, 14 Dec 2000 14:47:36 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012141915.TAA02512@raistlin.arm.linux.org.uk>
Subject: Re: Fwd: [Fwd: [PATCH] cs89x0 is not only an ISA card]
To: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw)
Date: Thu, 14 Dec 2000 19:15:54 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), nico@cam.org (Nicolas Pitre),
        morton@nortelnetworks.com, linux-kernel@vger.kernel.org
In-Reply-To: <20001214194221.K15157@arthur.ubicom.tudelft.nl> from "Erik Mouw" at Dec 14, 2000 07:42:21 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw writes:
> No, the cs89x0 can be used on systems that don't have an ISA bus at
> all. It just needs 16 data lines, a couple of address lines and some
> selection lines, but that's all. It's very nice for embedded designs
> because it's a single chip solution. Add a 20MHz crystal, a
> transformer, and a connector and you're set.

Umm, you're right; the manufacturer describes the chip as "10Mbps Embedded
Ethernet Controller" which just happens to be able to be used on an ISA
bus.

Therefore, it is NOT an ISA peripheral, but a general purpose peripheral.
As such, it should NOT be classified as an ISA bus device, and therefore
should NOT depend on CONFIG_ISA.

(I hope there are enough NOTs there).
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
