Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129214AbQJ3BJt>; Sun, 29 Oct 2000 20:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129660AbQJ3BJj>; Sun, 29 Oct 2000 20:09:39 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:12550 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129214AbQJ3BJY>;
	Sun, 29 Oct 2000 20:09:24 -0500
Message-ID: <39FCCA3C.27EDB2FF@mandrakesoft.com>
Date: Sun, 29 Oct 2000 20:09:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rasmus Andersen <rasmus@jaquet.dk>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org,
        David Hinds <dhinds@valinux.com>, corey@world.std.com
Subject: Re: Compile error in drivers/ide/osb4.c in 240-t10p6
In-Reply-To: <20001029144822.B622@jaquet.dk> <m13psPR-000OXnC@amadeus.home.nl> <20001029231257.J625@jaquet.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Andersen wrote:
> Thanks for the pointer. However my test build still barfs in the final
> link phase because we (in t10p6) morphed drivers/pcmcia/cs.c::pcmcia_
> request_irq into (the static) cs_request_irq. The rename part
> broke the two other places in cs.c where pcmcia_request_irq was
> referenced and the static part made its usage in drivers/net/pcmcia/
> ray_cs.c a bit awkward.
> 
> Since I won't presume to question the decision to rename the function
> the following patch propagates the rename to the rest of the kernel.
> Furthermore, I presumed to remove the static part so that the ray_cs
> driver was free to use it. I have added David Hinds and Corey Thomas
> (the raylink driver maintainer) to the cc on this mail so they can
> decide what the proper solution is.

This is what went to Linus, and David Hinds ack'd it.

http://gtf.org/garzik/kernel/files/patches/2.4/2.4.0-test10/pcmcia-2.4.0.10.6.patch.gz

	Jeff



-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
