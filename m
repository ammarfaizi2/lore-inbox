Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129173AbRBKMMn>; Sun, 11 Feb 2001 07:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129279AbRBKMMd>; Sun, 11 Feb 2001 07:12:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5139 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129173AbRBKMMW>;
	Sun, 11 Feb 2001 07:12:22 -0500
Message-ID: <3A86819F.799C4311@mandrakesoft.com>
Date: Sun, 11 Feb 2001 07:12:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More network pci_enable cleanups.
In-Reply-To: <Pine.LNX.4.31.0102111159430.6348-100000@athlon.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:
> > > -       int     cards_found = 0;
> > > +       int     cards_found;
> > Rejected.  Introduces bug.  That zero is required!
> 
> Refresh my memory here. I thought unitialised vars go to bss,
> and get zeroed at boot time ?

cards_found is on the stack, which can contain random crap..

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
