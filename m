Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbTGCWz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbTGCWy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:54:58 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:18316 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265521AbTGCWxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:53:50 -0400
Date: Thu, 3 Jul 2003 18:42:24 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.5.74
Message-ID: <20030703184224.GD31086@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030703184109.GB31086@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703184109.GB31086@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- a/drivers/pnp/manager.c	2003-07-03 15:28:06.000000000 +0000
+++ b/drivers/pnp/manager.c	2003-07-03 15:03:08.000000000 +0000
@@ -400,25 +400,24 @@
 	dev->res = *res;
 	if (!(mode & PNP_CONFIG_FORCE)) {
 		for (i = 0; i < PNP_MAX_PORT; i++) {
-			if(pnp_check_port(dev,i))
+			if(!pnp_check_port(dev,i))
 				goto fail;
 		}
 		for (i = 0; i < PNP_MAX_MEM; i++) {
-			if(pnp_check_mem(dev,i))
+			if(!pnp_check_mem(dev,i))
 				goto fail;
 		}
 		for (i = 0; i < PNP_MAX_IRQ; i++) {
-			if(pnp_check_irq(dev,i))
+			if(!pnp_check_irq(dev,i))
 				goto fail;
 		}
 		for (i = 0; i < PNP_MAX_DMA; i++) {
-			if(pnp_check_dma(dev,i))
+			if(!pnp_check_dma(dev,i))
 				goto fail;
 		}
 	}
 	up(&pnp_res_mutex);
 
-	pnp_auto_config_dev(dev);
 	kfree(bak);
 	return 0;
 
