Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLGCBe>; Wed, 6 Dec 2000 21:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLGCBY>; Wed, 6 Dec 2000 21:01:24 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:48908 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129257AbQLGCBJ>; Wed, 6 Dec 2000 21:01:09 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDFA@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Linus Torvalds'" <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: test12-pre6
Date: Wed, 6 Dec 2000 17:30:23 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Linus Torvalds [mailto:torvalds@transmeta.com]
> 
...
> Now, this is with a bog-standard PIIX irq router, so we 
> definitely know
> that we have the pirq table parsing right. I even have unofficial
> confirmation from intel engineers on this.
> 
> But I see something obviously wrong there: you have busmaster 
> disabled.
> 
> Looking into the UHCI controller code, I notice that neither 
> UHCI driver actually does the (required)
> 
> 	pci_set_master(dev);
> 
> Please add that to just after a successful 
> "pci_enable_device(dev)", and I
> just bet your USB will start working.
> 
> Johannes, Georg, the above is a fairly embarrassing bug, and 
> is likely to
> explain a _lot_ of USB failures (the OHCI driver does do this, btw).
> 
> 		Linus

Gawd, I'm embarrassed even if they aren't.
You probably just wiped out a significant portion of the
USB bug list.

Thanks,
~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
