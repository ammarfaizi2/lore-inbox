Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbQLQMZg>; Sun, 17 Dec 2000 07:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130635AbQLQMZ0>; Sun, 17 Dec 2000 07:25:26 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:21508 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129604AbQLQMZL>;
	Sun, 17 Dec 2000 07:25:11 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2) 
In-Reply-To: Your message of "Sun, 17 Dec 2000 11:39:50 -0000."
             <Pine.LNX.4.30.0012171134540.14423-100000@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Dec 2000 22:54:39 +1100
Message-ID: <2750.977054079@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2000 11:39:50 +0000 (GMT), 
David Woodhouse <dwmw2@infradead.org> wrote:
>On Sun, 17 Dec 2000, Keith Owens wrote:
>
>> The rest of the kernel already depends totally on these "subtle" issues
>> with link order.  Why should mtd be different?
>
>Because I maintain the MTD code and I want it to be. I think the link
>order dependencies are ugly, unnecessary and far more likely to be
>problematic then the alternatives. I'll code an alternative which is
>cleaner than the current code, and Linus can either accept it or not, as
>he sees fit.

Your choice.  Just bear in mind that if CONFIG_MODULES=y but mtd
objects are built into the kernel then mtd _must_ have a correct link
order.  Consider a config with CONFIG_MODULES=y but every mtd option is
set to 'y', link order is critical.  The moment you have two or more
mtd modules built in then you are stuck with link order issues, no
matter what you do.  Of course you could invent and maintain your own
unique method for controlling mtd initialisation order ...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
