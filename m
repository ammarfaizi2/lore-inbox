Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbQLHV2E>; Fri, 8 Dec 2000 16:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132604AbQLHV14>; Fri, 8 Dec 2000 16:27:56 -0500
Received: from cs.columbia.edu ([128.59.16.20]:60833 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S132625AbQLHV1u>;
	Fri, 8 Dec 2000 16:27:50 -0500
Date: Fri, 8 Dec 2000 12:57:17 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <3A3143D5.98E8E948@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.LNX.4.21.0012081254360.26353-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Udo A. Steinberg wrote:

> > +               /* disable advertising the flow-control capability */
> > +               sp->advertising &= ~0x0400;
> > +               mdio_write(ioaddr, sp->phy[0] & 0x1f, sp->advertising);
> 
>                                                       ^^^
>                                                  missing a 4 here?

Yes, sorry about that.

> I've tried the patch putting a 4 in the place noted above. It doesn't
> help with the issue at all. 

Ok. Can you send me the entire dump? Also, it would be helpful if you
could try to determine when exactly it happens (upon insmod, upon ifconfig
up, or upon receiving some packets later).

> Also interesting is the fact that my kernel
> hangs upon bootup around starting syslogd/klogd or around setting up the
> NIC (haven't quite figured out), if I pull the network plug and continues
> when I plug it back in.

Stupid question: are you sure this is not due to the DNS server being
unreachable?...

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
