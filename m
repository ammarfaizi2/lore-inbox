Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131737AbQKUXfH>; Tue, 21 Nov 2000 18:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131600AbQKUXer>; Tue, 21 Nov 2000 18:34:47 -0500
Received: from 213-120-136-183.btconnect.com ([213.120.136.183]:39172 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131589AbQKUXei>;
	Tue, 21 Nov 2000 18:34:38 -0500
Date: Tue, 21 Nov 2000 23:04:53 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>,
        linux-kernel@vger.kernel.org, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
In-Reply-To: <20001121235529.E925@werewolf.able.es>
Message-ID: <Pine.LNX.4.21.0011212300590.950-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, J . A . Magallon wrote:

> 
> On Tue, 21 Nov 2000 22:25:01 Bartlomiej Zolnierkiewicz wrote:
> > 
> > Quick removal of unnecessary initialization to 0.
> > 
> >  
> > -static int basePort = 0;	/* base port address */
> > -static int regPort = 0;		/* port for register number */
> > -static int dataPort = 0;	/* port for register data */
> > +static int basePort;	/* base port address */
> > +static int regPort;	/* port for register number */
> > +static int dataPort;	/* port for register data */
> 
> That is not too much confidence on the ANSI-ness of the compiler ???
> 

Quite the contrary. The patch seems correct and useful to me. What do you
think is wrong with it? (Linus accepted megabytes worth of the above in
the past...)

(see arch/i386/kernel/head.S and look for surprised. This is becoming FAQ,
Richard, how about putting it into your FAQ mentioned at the bottom of
this message?)

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
