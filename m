Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132660AbRALXva>; Fri, 12 Jan 2001 18:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135319AbRALXvT>; Fri, 12 Jan 2001 18:51:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50949 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132660AbRALXvJ>; Fri, 12 Jan 2001 18:51:09 -0500
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
To: mingo@elte.hu
Date: Fri, 12 Jan 2001 23:50:39 +0000 (GMT)
Cc: frank@unternet.org (Frank de Lange),
        manfred@colorfullife.com (Manfred Spraul),
        torvalds@transmeta.com (Linus Torvalds), dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.30.0101122130310.2772-100000@e2> from "Ingo Molnar" at Jan 12, 2001 09:31:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HDxw-0005Gb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> WITH. patched 8390.c, patched apic.c, sock io_apic.c. My very strong
> feeling is that this will be a stable combination, and that this is what
> we want as a final solution.

If you do that please #ifdef SMP all the changes. Its impossible to use a modem
and an ne2K together on a typical PC otherwise. The copy from the NE2K with
irq disabled is just _SO_ slow you drop bytes continually.

I did all the horrible magic in the ne2k driver for a reason. The other 
alternative is to provide a way to force the system back out of apic mode
so the ne2K driver can do a

	goodbye_apic_crap()

type call

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
