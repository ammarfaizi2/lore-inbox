Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129977AbQLKALQ>; Sun, 10 Dec 2000 19:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbQLKALG>; Sun, 10 Dec 2000 19:11:06 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:36778 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129977AbQLKAKv>; Sun, 10 Dec 2000 19:10:51 -0500
Message-Id: <5.0.2.1.2.20001210232808.04affbd0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 10 Dec 2000 23:34:18 +0000
To: Ion Badulescu <ionut@cs.columbia.edu>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: eepro100 driver update for 2.4
Cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012081254360.26353-100000@age.cs.columbia.e
 du>
In-Reply-To: <3A3143D5.98E8E948@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:57 08/12/2000, Ion Badulescu wrote:
>On Fri, 8 Dec 2000, Udo A. Steinberg wrote:
>
> > > +               /* disable advertising the flow-control capability */
> > > +               sp->advertising &= ~0x0400;
> > > +               mdio_write(ioaddr, sp->phy[0] & 0x1f, sp->advertising);
> >
> >                                                       ^^^
> >                                                  missing a 4 here?
>
>Yes, sorry about that.
>
> > I've tried the patch putting a 4 in the place noted above. It doesn't
> > help with the issue at all.

Just to say that the patch (including added 4) fixed the "card reports no 
resources" messages for me. - Looking at my logs the messages appeared once 
every 10-40 minutes. - Now the box is up for more than 5 hours with the 
patch and test12-pre7 and not a single no resources message logged so far. 
(Note, I upgraded the kernel at the same time as adding the patch so it is 
actually possible that test12-pre7 vanilla is fixed as well.)

My card is an Ether Express Pro 100, lcpci says: Intel Corporation 82557 
[Ethernet Pro 100] (rev 04) and lspci -n gives: class 0200: 10b7:9004

Just my 2p.

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
