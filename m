Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135599AbRALX0c>; Fri, 12 Jan 2001 18:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135619AbRALX0W>; Fri, 12 Jan 2001 18:26:22 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38917 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135599AbRALX0N>; Fri, 12 Jan 2001 18:26:13 -0500
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 12 Jan 2001 23:27:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <93nich$1uq$1@penguin.transmeta.com> from "Linus Torvalds" at Jan 12, 2001 10:28:33 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HDbX-0005E0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> interrupt controllers (io-apic definitely included).  Drivers would
> generally be better off if they disabled their own chip from sending
> interrupts, rather than disabling the interrupt line the chip is on. 

That doesn't work very well because the device irq can arrive a measurable
number of clocks after you disable it on the source and there is no way to
say 'and be sure the stupid thing has propogated the apic bus'

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
