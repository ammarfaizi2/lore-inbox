Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130406AbQKXXow>; Fri, 24 Nov 2000 18:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130579AbQKXXop>; Fri, 24 Nov 2000 18:44:45 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61712 "EHLO
        havoc.gtf.org") by vger.kernel.org with ESMTP id <S130406AbQKXXod>;
        Fri, 24 Nov 2000 18:44:33 -0500
Message-ID: <3A1EF64C.BFE05CE8@mandrakesoft.com>
Date: Fri, 24 Nov 2000 18:14:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, andrewm@uow.edu.au,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 3c59x: Using bad IRQ 0
In-Reply-To: <Pine.LNX.4.10.10011211723380.4687-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 21 Nov 2000, Jeff Garzik wrote:
> >
> > A caveat to this whole scheme is that usb-uhci -already- calls
> > pci_enable_device before checking dev->irq, and yet cannot get around
> > the "assign IRQ to USB: no" setting in BIOS.  I hope that is an
> > exception rather than the rule.
> 
> Do we have a recent report of this with full PCI debug output? It might
> just be another unlisted intel irq router..

Actually, I -was- able to reproduce this problem on my SMP PIIX4 box
here.  But as of test11-final, I am no longer able to reproduce it.

Maybe some intrepid testers are willing to test 2.4.0-test11 with these
BIOS settings:
	PNP OS: Yes
	Assign IRQ to USB: No

It works for me... :)

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
