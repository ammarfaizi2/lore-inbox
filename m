Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129982AbQKRULu>; Sat, 18 Nov 2000 15:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130516AbQKRULl>; Sat, 18 Nov 2000 15:11:41 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129982AbQKRUL2>;
	Sat, 18 Nov 2000 15:11:28 -0500
Message-ID: <20001118122404.A128@bug.ucw.cz>
Date: Sat, 18 Nov 2000 12:24:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <E13wPFs-0007og-00@the-village.bc.nu> <12129.974384071@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <12129.974384071@redhat.com>; from David Woodhouse on Thu, Nov 16, 2000 at 02:14:31PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> alan@lxorguk.ukuu.org.uk said:
> >  Umm..  Linus drivers dont appear to be SMP safe on unload 
> 
> AFAIK, no kernel threads are currently SMP safe on unload. However, 
> the PCMCIA thread would be safe with the patch below, and we could fairly 
> easily convert the others to use up_and_exit() once it's available.
> 
> Anyone using PCMCIA or CardBus with 2.4, even if you have a non-CardBus
> i82365 or TCIC controller for which the driver was disabled in test11-pre5,
> please could you test this? Especially if you have TCIC, in fact, because
> it's already been tested successfully on yenta and i82365. 

Thanx a lot, it fixed problems with my i82365.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
