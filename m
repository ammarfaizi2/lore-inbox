Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131507AbRAUHVi>; Sun, 21 Jan 2001 02:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135405AbRAUHV2>; Sun, 21 Jan 2001 02:21:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23560 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131507AbRAUHVK>;
	Sun, 21 Jan 2001 02:21:10 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101202315.f0KNFTV01790@flint.arm.linux.org.uk>
Subject: Re: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Sat, 20 Jan 2001 23:15:28 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul), linux-kernel@vger.kernel.org
In-Reply-To: <20010120130848.I9156@sventech.com> from "Johannes Erdfelt" at Jan 20, 2001 01:08:49 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt writes:
> They need to be visible via DMA. They need to be 16 byte aligned. We
> also have QH's which have similar requirements, but we don't use as many
> of them.

Can we get away from the "16 byte aligned" and make it "n byte aligned"?
I believe that slab already has support for this?
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
