Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264055AbTKLSi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 13:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbTKLSi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 13:38:28 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30404 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264055AbTKLSi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 13:38:26 -0500
Date: Wed, 12 Nov 2003 19:38:17 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Armin Schindler <armin@melware.de>, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de
Subject: [PATCH] Re: 2.6 eicon/ and hardware/eicon/ drivers using the samesymbols (fwd)
Message-ID: <20031112183817.GB5962@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below is still required in -test9.

Please apply
Adrian


----- Forwarded message from Armin Schindler <armin@melware.de> -----

Date:	Thu, 25 Sep 2003 13:33:53 +0200 (MEST)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: <isdn4linux@listserv.isdn4linux.de>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: 2.6 eicon/ and hardware/eicon/ drivers using the samesymbols

On Thu, 25 Sep 2003, Adrian Bunk wrote:
> I got the link error below in 2.6.0-test5-mm4 (but it doesn't seem to be
> specific to -mm).
>
> It seems some drivers under eicon/ and hardware/eicon/ use the same
> symbols. Either some symbols should be renamed or Kconfig dependencies
> should ensure that you can't build two such drivers statically into the
> kernel at the same time.

The legacy eicon driver in drivers/isdn/eicon is the old one and will be
removed as soon as all features went to the new driver.
Anyway this old driver was never meant to be non-module.

This patch should do it.

Armin



--- linux-2.5/drivers/isdn/eicon/Kconfig.orig	Thu Sep 25 13:28:07 2003
+++ linux-2.5/drivers/isdn/eicon/Kconfig	Thu Sep 25 13:27:01 2003
@@ -13,7 +13,7 @@
 choice
 	prompt "Eicon active card support"
 	optional
-	depends on ISDN_DRV_EICON && ISDN
+	depends on ISDN_DRV_EICON && ISDN && m

 config ISDN_DRV_EICON_DIVAS
 	tristate "Eicon driver"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

