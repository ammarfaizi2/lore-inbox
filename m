Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKQLdr>; Fri, 17 Nov 2000 06:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbQKQLdi>; Fri, 17 Nov 2000 06:33:38 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:17321 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129097AbQKQLd2>; Fri, 17 Nov 2000 06:33:28 -0500
Message-Id: <5.0.2.1.2.20001117105359.00adbec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 17 Nov 2000 11:03:56 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: How to add a drive to DMA black list?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E13wj7l-0000US-00@the-village.bc.nu>
In-Reply-To: <5.0.0.25.2.20001116182436.00ab3160@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:52 17/11/2000, Alan Cox wrote:
> > I tried adding the string that is output for the bad drive by hdparm -i
> > into drivers/ide/ide-dma.c::drive_blacklist and
> > drivers/ide/ide-dma.c::bad_dma_drives but the kernel still says that it is
> > using DMA and the kernel hangs after displaying:
>
>The black list is for drives with problems, not for controller bugs. 
>Controller bugs in the Linux code just have to be fixed.

That is obvious. I may be of course wrong, but I would consider this a 
drive problem, considering that another ide drive on the same controller 
works fine with DMA enabled (a QUANTUM TRB850A) while the Conner 
Peripherals 1275MB - CFS1275A fails with DMA enabled. They are in fact both 
attached simultaneously  to the PIIX controller (on different IDE channels, 
both being masters) and one works and the other doesn't... - I should 
probably have stated that when posting but I didn't consider it important 
at the time (and copying by hand from one screen to another doesn't 
encourage copying everything but the essentials...). - Am I missing something?

Regards,

Anton


-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
