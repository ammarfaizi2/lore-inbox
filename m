Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbQLGTcC>; Thu, 7 Dec 2000 14:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbQLGTbx>; Thu, 7 Dec 2000 14:31:53 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:25849 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S130017AbQLGTbm>; Thu, 7 Dec 2000 14:31:42 -0500
Date: Thu, 7 Dec 2000 20:01:13 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12-pre7
In-Reply-To: <200012071411.eB7EB4Y11843@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10012071957480.13783-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Dec 2000, Russell King wrote:

> Linus Torvalds writes:
> >     - me: UHCI drivers really need to enable bus mastering.
> 
> But it'll already be turned on if pci_assign_unassigned_resources() is
> called.  This calls pdev_enable_device for every single device, which
> turns on the bus master bit in the PCI command register.

Maybe I'm stating something which is obvious to everybody, but note
that pci_assign_unassigned_resources is only called from

./arch/alpha/kernel/pci.c:  pci_assign_unassigned_resources();
./arch/mips/ddb5074/pci.c:  pci_assign_unassigned_resources();
./arch/arm/kernel/bios32.c:     pci_assign_unassigned_resources();

so it looks like most archs don't use it anyway. (And that's supposedly
why pci_set_master helped people on x86)

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
