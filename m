Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129256AbQKSRT5>; Sun, 19 Nov 2000 12:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQKSRTs>; Sun, 19 Nov 2000 12:19:48 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:36521 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129256AbQKSRTh>; Sun, 19 Nov 2000 12:19:37 -0500
Message-Id: <5.0.2.1.2.20001119164807.00ae07b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 19 Nov 2000 16:50:17 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: How to add a drive to DMA black list?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E13wjex-0000XQ-00@the-village.bc.nu>
In-Reply-To: <5.0.2.1.2.20001117105359.00adbec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:26 17/11/2000, Alan Cox wrote:
> > drive problem, considering that another ide drive on the same controller
> > works fine with DMA enabled (a QUANTUM TRB850A) while the Conner
> > Peripherals 1275MB - CFS1275A fails with DMA enabled. They are in fact 
> both
>
>And the Conner drives work fine on a VIA MVP3 it seems. You need to try
>the drive with multiple controllers to be sure its not a PIIX bug that only
>trips on that drive (or indeed a bug in the combination)

I have now tried the drive (which is actually a seagate drive but it 
identifies itself as a conner) on my new Promise ATA-100 controller and the 
drive works fine with DMA enabled. So you were quite right, it's the PIIX 
driver/tuning which kills it.

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
