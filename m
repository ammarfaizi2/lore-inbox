Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143807AbRA1TEI>; Sun, 28 Jan 2001 14:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143830AbRA1TD6>; Sun, 28 Jan 2001 14:03:58 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:24036 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S143807AbRA1TDz>; Sun, 28 Jan 2001 14:03:55 -0500
Date: Sun, 28 Jan 2001 19:51:57 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Manfred Spraul <manfred@colorfullife.com>
cc: David Woodhouse <dwmw2@infradead.org>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <3A7459AA.84CDCF7B@colorfullife.com>
Message-ID: <Pine.GSO.4.10.10101281949200.13259-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 28 Jan 2001, Manfred Spraul wrote:

> And one more point for the Janitor's list:
> Get rid of superflous irqsave()/irqrestore()'s - in 90% of the cases
> either spin_lock_irq() or spin_lock() is sufficient. That's both faster
> and better readable.
> 
> spin_lock_irq(): you know that the function is called with enabled
> interrupts.
> spin_lock(): can be used in hardware interrupt handlers when only one
> hardware interrupt uses that spinlocks (most hardware drivers), or when
> all hardware interrupt handler set the SA_INTERRUPT flag (e.g. rtc and
> timer interrupt)

This is not a bug and only helps to make drivers nonportable. Please,
don't do this.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
