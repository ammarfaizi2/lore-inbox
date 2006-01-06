Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWAFLlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWAFLlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWAFLlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:41:14 -0500
Received: from webmail-outgoing2.us4.outblaze.com ([205.158.62.67]:17055 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S932431AbWAFLlN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:41:13 -0500
X-OB-Received: from unknown (205.158.62.16)
  by wfilter.us4.outblaze.com; 6 Jan 2006 11:41:09 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
From: "1qay beer" <1qay@beer.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 06 Jan 2006 07:41:09 -0400
Subject: Re: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver
 for PDC202XX
X-Originating-Ip: 10.0.0.198
X-Originating-Server: ws5-10.us4.outblaze.com
Message-Id: <20060106114109.23E587B386@ws5-10.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanx to everyone.

The Controller Board is fine.

What i noticed is that if you have the controller in a 
full PCI Bus Master Slot without IRQ sharing - the Controller works better
than in shared slot.

Generally the first PCI Slot is shared with AGP.
The Second is normaly complet "IRQ share free" and the way to go.

Slot 4/5 is mostly shared (as long you have that many slots).
Slot 3 may be shared with onboard stuff like sound, onboard graphic, usb or others.

The Board is now working without Problems.
What I did is Remove the IDE-Driver from the Kernel and use the Libata Driver,
which now even works with S.M.A.R.T. without Problem.

I removed the UDMA-133 Drive and have now only connected UDMA-100 Drives to the Controller. The UDMA-133 is connected to the Motherboard now.

Mostly Maxtor produced UDMA-133 Drives which are going to fail in half a year anyway ;-(.

Now i use only Seagate Drives which have 5 Years warranty and I never had Problem with them. (too bad maxtor is part of seagate now...I hope they will not fail in their good quality)

Cheers

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "1qay beer" <1qay@beer.com>
Subject: Re: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver	for PDC202XX
Date: Mon, 02 Jan 2006 22:35:51 +0000

> 
> On Sul, 2006-01-01 at 13:39 -0400, 1qay beer wrote:
> > Hello,
> > Dear Alan Cox,
> > Dear Jeff Garzik,
> >
> > Everyone a happy new year!
> 
> Ditto
> 
> > -The IDE Driver (pdc202xx_new) has still problems with "DMA Timeout".
> 
> The legacy IDE layer is handled by Bartlomiej so you should direct your
> enquiries and requests to him and the linux-ide list.
> 
> > -The Libata Driver (pata_pdc2027x) seems to be still somewhat experimental.
> 
> and while I'm working on libata pata a fair bit the pdc202xx driver is
> the excellent work of Albert Lee.
> 
> The 20269 has always shown up as a problem for some users but not for
> most. Nobody ever really got to the bottom of it to be honest. Please
> send Albert your reports about which hardware works and which fails
> (<albertcc@tw.ibm.com>) as it may be very useful. In particular the
> drive that works appears to be UDMA 100 and the failing one UDMA 133
> 
> Alan


-- 
_______________________________________________
The coolest e-mail address on the web and it’s FREE!  Sign-up today for Beer Mail @ beer.com.

