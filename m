Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVL2TCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVL2TCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVL2TCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:02:13 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47068 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750849AbVL2TCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:02:12 -0500
Message-Id: <200512291901.jBTJ1rOm017519@laptop11.inf.utfsm.cl>
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver 
In-Reply-To: Message from "Bryan O'Sullivan" <bos@pathscale.com> 
   of "Wed, 28 Dec 2005 16:31:19 -0800." <patchbomb.1135816279@eng-12.pathscale.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Thu, 29 Dec 2005 16:01:53 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 29 Dec 2005 16:01:59 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan <bos@pathscale.com> wrote:
> Following Roland's submission of our InfiniPath InfiniBand HCA driver
> earlier this month, we have responded to people's comments by making a
> large number of changes to the driver.

Many thanks!

> Here is another set of driver patches for review.  Roland is on
> vacation until January 4, so I'm posting these in his place.  Once
> again, your comments are appreciated.  We'd like to submit this driver
> for inclusion in 2.6.16, so we'll be responding quickly to all
> feedback.
> 
> A short summary of the changes we have made is as follows:

Some comments, just based on this:

[...]

>   - Renamed _BITS_PER_BYTE to BITS_PER_BYTE, and moved it into
>     linux/types.h

Haven't come across anything with this not 8 for a /long/ time now, and no
Linux on that in sight.

[...]

> There are a few requested changes we have chosen to omit for now:
> 
>   - The driver still uses EXPORT_SYMBOL, for consistency with other
>     code in drivers/infiniband

I'd suppose that is your choice...

>   - Someone asked for the kernel's i2c infrastructure to be used, but
>     our i2c usage is very specialised, and it would be more of a mess
>     to use the kernel's

Problem with that is that if everybody and Aunt Tillie does the same, the
kernel as a whole gets to be a mess.

>   - We're still using ioctls instead of sysfs or configfs in some
>     cases, to maintain userspace compatibility

With what? You can very well ask people to upgrade to the latest userland
utilities, and even make them run the old versions when they find that the
new interface isn't there. Happened recently with modprobe/modutils.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
