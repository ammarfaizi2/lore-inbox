Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130635AbQLQMfx>; Sun, 17 Dec 2000 07:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131234AbQLQMfo>; Sun, 17 Dec 2000 07:35:44 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:26628 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130635AbQLQMfd>; Sun, 17 Dec 2000 07:35:33 -0500
Date: Sun, 17 Dec 2000 12:04:53 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Rasmus Andersen <rasmus@jaquet.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2) 
In-Reply-To: <2750.977054079@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0012171158140.14423-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2000, Keith Owens wrote:

> Your choice.  Just bear in mind that if CONFIG_MODULES=y but mtd
> objects are built into the kernel then mtd _must_ have a correct link
> order.  Consider a config with CONFIG_MODULES=y but every mtd option is
> set to 'y', link order is critical.

Yep, I'd just noticed that one. The patch was actually put in by someone
to fix 2.0 compilation - and I noticed that it made the link order
problem go away for certain configs.

> Of course you could invent and maintain your own unique method for
> controlling mtd initialisation order ...

I'll try to find a clean way to make the MTD code work in all
configurations without having to do that. If it really comes to doing the
above, I'll probably just give up and let it stay 'broken' (IMO) along
with the rest of the kernel code which as you say already has link order
dependencies.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
