Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLMVfe>; Wed, 13 Dec 2000 16:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLMVfY>; Wed, 13 Dec 2000 16:35:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:272 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129267AbQLMVfN>;
	Wed, 13 Dec 2000 16:35:13 -0500
Message-ID: <3A37E465.19976EAD@mandrakesoft.com>
Date: Wed, 13 Dec 2000 16:04:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Ullrich <chris@chrullrich.de>
CC: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: insmod problem after modutils upgrading
In-Reply-To: <001b01c0652b$ec758de0$247d9cca@mindef> <20001213215915.A10848@christian.chrullrich.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ullrich wrote:
> 
> * Corisen schrieb am Donnerstag, 14.12.2000:
> 
> > executing "insmod 8139too" at the command prompt shows the following error
> > message:
> > using /lib/modules/2.4.0-test12/kernel/drivers/net/8139too.o
> > /lib/modules/2.4.0-test12/kernel/drivers/net/8139too.o: symbol for
> > parameter debug not found.
> 
> > how can i make insmod load the network module again pls?
> 
> I "fixed" the same problem in 2.2.18 by commenting out the line
> 
> MODULE_PARM (debug, "i");
> 
> near the end of drivers/net/8139too.c. Since I run modutils 2.3.22
> as well, it can't be related to the modutils.

Yep, that's the correct fix -- remove that line.

My apologies to Keith Owens for originally saying the opposite (I deal
with so many net drivers they all get jumbled up in my mind)

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
