Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbQKPQFd>; Thu, 16 Nov 2000 11:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbQKPQFY>; Thu, 16 Nov 2000 11:05:24 -0500
Received: from et-gw.etinc.com ([207.252.1.2]:51720 "EHLO etinc.com")
	by vger.kernel.org with ESMTP id <S130139AbQKPQFK>;
	Thu, 16 Nov 2000 11:05:10 -0500
Message-Id: <5.0.0.25.0.20001116103133.02162c80@mail.etinc.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Thu, 16 Nov 2000 10:34:30 -0500
To: Russell King <rmk@arm.linux.org.uk>, R.E.Wolff@BitWizard.nl (Rogier Wolff)
From: Dennis <dennis@etinc.com>
Subject: Re: 2.4. continues after Aieee...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200011161120.eAGBKUm08641@flint.arm.linux.org.uk>
In-Reply-To: <200011151630.RAA04141@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>Not every case causes a panic either.  This week, I had an instance of
>an i686 box lock solid with a DFE-530TX net card.  Rebooting/power
>cycling it didn't recover it (despite it working for the past month
>without any problems).  It only started working again after I moved
>it into a different PCI slot.
>
>I've seen a couple of instances now on totally different hardware where
>it is possible to lock a PCI bus solid by improper connections on some
>of the PCI bus lines, so a faulty PCI socket seem to be the most likely
>cause.


theres nothing that software can do with a pci bus lockup. You need a 
hardware watchdog to reboot the system for this type of failure.

PCI has a very tight spec, and running a card (say on an extender) or with 
another card that has too many loads can cause a bus failure. If you have 
more than 4 cards on the bus you are out of spec, for example.

But that doesnt change the panic issue. if you have hardware problems you 
cant expect any OS to help you, you need new  hardware.

Dennis


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
