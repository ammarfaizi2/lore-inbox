Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbTKLTyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 14:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbTKLTyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 14:54:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:20693 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264288AbTKLTye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 14:54:34 -0500
Date: Wed, 12 Nov 2003 20:54:29 +0100 (MET)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <kai.germaschewski@gmx.de>, <isdn4linux@listserv.isdn4linux.de>,
       <kkeil@suse.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.6 eicon/ and hardware/eicon/ drivers using the
 samesymbols (fwd)
In-Reply-To: <20031112183817.GB5962@fs.tum.de>
Message-ID: <Pine.LNX.4.31.0311122051300.6019-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already send a patch to Linus and asked him to remove the
old driver in drivers/isdn/eicon.

The new driver in drivers/isdn/hardware/eicon will take over
for the Eicon ISDN PCI cards including a lot of new features.

Armin

On Wed, 12 Nov 2003, Adrian Bunk wrote:
>
> The patch forwarded below is still required in -test9.
>
> Please apply
> Adrian
>
>
> ----- Forwarded message from Armin Schindler <armin@melware.de> -----
>
> Date:	Thu, 25 Sep 2003 13:33:53 +0200 (MEST)
> From: Armin Schindler <armin@melware.de>
> To: Adrian Bunk <bunk@fs.tum.de>
> Cc: <isdn4linux@listserv.isdn4linux.de>,
> 	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
> Subject: [PATCH] Re: 2.6 eicon/ and hardware/eicon/ drivers using the samesymbols
>
> On Thu, 25 Sep 2003, Adrian Bunk wrote:
> > I got the link error below in 2.6.0-test5-mm4 (but it doesn't seem to be
> > specific to -mm).
> >
> > It seems some drivers under eicon/ and hardware/eicon/ use the same
> > symbols. Either some symbols should be renamed or Kconfig dependencies
> > should ensure that you can't build two such drivers statically into the
> > kernel at the same time.
>
> The legacy eicon driver in drivers/isdn/eicon is the old one and will be
> removed as soon as all features went to the new driver.
> Anyway this old driver was never meant to be non-module.
>
> This patch should do it.
>
> Armin
>
>
>
> --- linux-2.5/drivers/isdn/eicon/Kconfig.orig	Thu Sep 25 13:28:07 2003
> +++ linux-2.5/drivers/isdn/eicon/Kconfig	Thu Sep 25 13:27:01 2003
> @@ -13,7 +13,7 @@
>  choice
>  	prompt "Eicon active card support"
>  	optional
> -	depends on ISDN_DRV_EICON && ISDN
> +	depends on ISDN_DRV_EICON && ISDN && m
>
>  config ISDN_DRV_EICON_DIVAS
>  	tristate "Eicon driver"
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> ----- End forwarded message -----
>
> _______________________________________________
> isdn4linux mailing list
> isdn4linux@listserv.isdn4linux.de
> https://www.isdn4linux.de/mailman/listinfo/isdn4linux
>

