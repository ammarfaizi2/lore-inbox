Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVA3Wex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVA3Wex (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVA3Wex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:34:53 -0500
Received: from ns.suse.de ([195.135.220.2]:17285 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261813AbVA3Weu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:34:50 -0500
Date: Sun, 30 Jan 2005 23:34:48 +0100
From: Karsten Keil <kkeil@suse.de>
To: LKML <linux-kernel@vger.kernel.org>,
       isdn4linux <isdn4linux@listserv.isdn4linux.de>
Subject: Re: [PATCH] remove unused label and obsolete preprocessor gunk from hisax
Message-ID: <20050130223448.GA7901@pingi3.kke.suse.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	isdn4linux <isdn4linux@listserv.isdn4linux.de>
References: <Pine.LNX.4.62.0501302133220.2731@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0501302133220.2731@dragon.hygekrogen.localhost>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 09:43:05PM +0100, Jesper Juhl wrote:
> 
> 
> Here's a patch to remove an unused label and some obsolete preprocessor 
> magic around it. Thus killing this warning:
> drivers/isdn/hisax/hisax_fcpcipnp.c:1014: warning: label `out_unregister_isapnp' defined but not used
>  Please apply.
> 

Agree.


Signed-off-by: Karsten Keil <kkeil@suse.de>
Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc2-bk7-orig/drivers/isdn/hisax/hisax_fcpcipnp.c	2005-01-22 21:59:37.000000000 +0100
+++ linux-2.6.11-rc2-bk7/drivers/isdn/hisax/hisax_fcpcipnp.c	2005-01-30 20:04:00.000000000 +0100
@@ -1010,12 +1010,6 @@ static int __init hisax_fcpcipnp_init(vo
 #endif
 	return 0;
 
-#if !defined(CONFIG_HOTPLUG) || defined(MODULE)
- out_unregister_isapnp:
-#ifdef __ISAPNP__
-	pnp_unregister_driver(&fcpnp_driver);
-#endif
-#endif
  out_unregister_pci:
 	pci_unregister_driver(&fcpci_driver);
  out:





 
-- 
Karsten Keil
SuSE Labs
ISDN development
