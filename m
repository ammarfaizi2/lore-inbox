Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRAYUgn>; Thu, 25 Jan 2001 15:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130946AbRAYUgd>; Thu, 25 Jan 2001 15:36:33 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:7184 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129172AbRAYUgW>;
	Thu, 25 Jan 2001 15:36:22 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101252036.XAA10500@ms2.inr.ac.ru>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
To: ionut@moisil.cs.columbia.edu (Ion Badulescu)
Date: Thu, 25 Jan 2001 23:36:03 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, andrewm@uow.EDU.AU
In-Reply-To: <200101252028.f0PKSJR02124@moisil.dev.hydraweb.com> from "Ion Badulescu" at Jan 25, 1 12:28:19 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Starfire card does, maybe the 3com is different. :-)

3com _is_ different. 8)

I is not an issue, we do not make zerocopy on IP fragments.


> Are we even bothering with the partial checksums at this point, or
> are we falling back to CPU checksumming if the packet is fragmented?

Of course, we are not bothering.



> And, on a related note: what's involved in making a driver
> zerocopy-aware? I haven't looked too closely to the current patch,
> but I was thinking of playing with the starfire driver, since I
> have all the chipset docs..

Nothing especially clever. Gather plus checksumming, as described
in comment in linux/netdevice.h. Well, just look into one of existing
drivers: better, sunhme. 3com and acenic are too stupid to learn something.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
