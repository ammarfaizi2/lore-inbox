Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129220AbQKQRmC>; Fri, 17 Nov 2000 12:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129227AbQKQRlw>; Fri, 17 Nov 2000 12:41:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20997 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129220AbQKQRli>;
	Fri, 17 Nov 2000 12:41:38 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011171711.RAA01375@raistlin.arm.linux.org.uk>
Subject: Re: VGA PCI IO port reservations
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Fri, 17 Nov 2000 17:11:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, mj@suse.cz
In-Reply-To: <3A1564D9.2AC70F6F@mandrakesoft.com> from "Jeff Garzik" at Nov 17, 2000 12:03:21 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Dig through the video card docs, even older ISA video cards let you
> disable I/O decoding on all but a few ports, and/or relocate the ports
> it does use to other areas.  Different with every video card, of course,
> but most of them can do this to a greater or lesser extent.

Unfortunately, when you start thinking about x86 and running the BIOSes
to (re-)initialise VGA cards back to text mode, they don't take it well
if you do this sort of messing.

However, I believe that my problem is sorted by use of that function from
pci-i386.c.

Thanks to people who helped.
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
