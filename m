Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbUC3OhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbUC3OhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:37:24 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:1676 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263684AbUC3OhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:37:22 -0500
Date: Tue, 30 Mar 2004 15:35:24 +0100
From: Dave Jones <davej@redhat.com>
To: pc300@cyclades.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] pc300 driver misplaced ;
Message-ID: <20040330143524.GB25834@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, pc300@cyclades.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.4/drivers/net/wan/pc300_drv.c~	2004-03-30 15:30:57.000000000 +0100
+++ linux-2.6.4/drivers/net/wan/pc300_drv.c	2004-03-30 15:32:11.000000000 +0100
@@ -3661,7 +3661,7 @@
 			release_mem_region(card->hw.falcphys, card->hw.falcsize);
 		}
 		for (i = 0; i < card->hw.nchan; i++)
-			if (card->chan[i].d.dev);
+			if (card->chan[i].d.dev)
 				free_netdev(card->chan[i].d.dev);
 		if (card->hw.irq)
 			free_irq(card->hw.irq, card);
