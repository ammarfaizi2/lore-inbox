Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRAaR6b>; Wed, 31 Jan 2001 12:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129990AbRAaR6V>; Wed, 31 Jan 2001 12:58:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11785 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129811AbRAaR6E>; Wed, 31 Jan 2001 12:58:04 -0500
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
To: manfred@colorfullife.com (Manfred Spraul)
Date: Wed, 31 Jan 2001 17:57:43 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse),
        acme@conectiva.com.br (Arnaldo Carvalho de Melo),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A7459AA.84CDCF7B@colorfullife.com> from "Manfred Spraul" at Jan 28, 2001 06:40:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O1Vp-0002mv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And one more point for the Janitor's list:
> Get rid of superflous irqsave()/irqrestore()'s - in 90% of the cases
> either spin_lock_irq() or spin_lock() is sufficient. That's both faster
> and better readable.

Expect me to drop any submissions that do this. I'd rather take the two
clock hit in most cases because the effect of spin_lock_irq() being used
and people then changing which functions call each other and producing 
impossible to debug irq mishandling cases is unacceptable.

The original Linux network code did this with sti() not save/restore flags.
I've been there before, I am not going to allow a rerun of that disaster for
a few cycles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
