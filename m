Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266445AbUGOWwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266445AbUGOWwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266448AbUGOWwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:52:47 -0400
Received: from bart.webpack.hosteurope.de ([217.115.142.76]:18629 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S266445AbUGOWwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:52:45 -0400
Date: Fri, 16 Jul 2004 00:57:59 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
cc: Andi Kleen <ak@muc.de>, Jeff Garzik <jgarzik@pobox.com>,
       <netdev@oss.sgi.com>, <irda-users@lists.sourceforge.net>,
       Jean Tourrilhes <jt@hpl.hp.com>, <the_nihilant@autistici.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop ISA dependencies from IRDA drivers
In-Reply-To: <20040715224235.GA5164@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0407160055360.14037-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2004, Jean Tourrilhes wrote:

> 	irda_setup_dma was (supposedly) fixed in 2.6.8-rc1, and no
> longer depend on CONFIG_ISA. Those driver are supposed to work on 64
> bits.

Ok, so maybe the following is missing in addition to Andi's patch?

Martin

-----------

--- linux-2.6.8-rc1/net/irda/irda_device.c	Tue Jul 13 00:31:34 2004
+++ v2.6.8-rc1-md/net/irda/irda_device.c	Fri Jul 16 00:45:08 2004
@@ -529,7 +529,6 @@ int irda_device_set_mode(struct net_devi
 	return ret;
 }
 
-#ifdef CONFIG_ISA
 /*
  * Function setup_dma (idev, buffer, count, mode)
  *
@@ -552,4 +551,3 @@ void irda_setup_dma(int channel, dma_add
 	release_dma_lock(flags);
 }
 EXPORT_SYMBOL(irda_setup_dma);
-#endif

