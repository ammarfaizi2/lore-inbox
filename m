Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129434AbQKWBWB>; Wed, 22 Nov 2000 20:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129385AbQKWBVw>; Wed, 22 Nov 2000 20:21:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17167 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129792AbQKWBVX>;
        Wed, 22 Nov 2000 20:21:23 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011230050.eAN0ofN13755@flint.arm.linux.org.uk>
Subject: Re: Patch(?): pci_device_id tables for linux-2.4.0-test11/drivers/block
To: adam@yggdrasil.com (Adam J. Richter)
Date: Thu, 23 Nov 2000 00:50:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200011222201.OAA29131@baldur.yggdrasil.com> from "Adam J. Richter" at Nov 22, 2000 02:01:36 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter writes:
> + { PCI_VENDOR_ID_DEC,   PCI_DEVICE_ID_DEC_21285,       PCI_ANY_ID, PCI_ANY_ID},

No no no no no no no.

This "device" should be identified by either the class code OR the
subsystem device/vendor IDs.

By using "PCI_VENDOR_ID_DEC" and "PCI_DEVICE_ID_DEC_21285" you are referring
to a chip which can be:

1. A host bridge
2. A non-I2O add in card performing non-I2O functions
3. An I2O card
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
