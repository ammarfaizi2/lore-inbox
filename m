Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbTFSD47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbTFSD4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:56:52 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:54660 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265362AbTFSDzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:55:25 -0400
Date: Wed, 18 Jun 2003 23:46:17 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030618234617.GH333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618234418.GC333@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1419  -> 1.1420 
#	drivers/pnp/support.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/18	ambx1@neo.rr.com	1.1420
# [PNP] Trivial Typo fix regarding DMAs
# 
# The irq index is used instead of the dma index when parsing dmas.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	Wed Jun 18 23:01:34 2003
+++ b/drivers/pnp/support.c	Wed Jun 18 23:01:34 2003
@@ -635,7 +635,7 @@
 		{
 			if (len != 2)
 				goto sm_err;
-			write_dma(p, &res->dma_resource[irq]);
+			write_dma(p, &res->dma_resource[dma]);
 			dma++;
 			break;
 		}
