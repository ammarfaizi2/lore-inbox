Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135571AbRALXfZ>; Fri, 12 Jan 2001 18:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135757AbRALXfQ>; Fri, 12 Jan 2001 18:35:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42757 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135571AbRALXfH>; Fri, 12 Jan 2001 18:35:07 -0500
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
To: manfred@colorfullife.com (Manfred Spraul)
Date: Fri, 12 Jan 2001 23:35:45 +0000 (GMT)
Cc: frank@unternet.org (Frank de Lange), dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu,
        alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com
In-Reply-To: <3A5F5BFB.69134DB9@colorfullife.com> from "Manfred Spraul" at Jan 12, 2001 08:33:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HDjY-0005Ei-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you disable both bandaids? I disabled them, no problems so far.
> Now back to the disable_irq_nosync().

Ok so it looks like the disable_irq code is buggy. Unfortunately its not
just used for these drivers they are just the heaviest users.

Given that we can see the IRQ is still set on the APIC can we fake an IRQ in
that condition ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
