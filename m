Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUDNU6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUDNU6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:58:09 -0400
Received: from cpe-024-033-224-95.neo.rr.com ([24.33.224.95]:61316 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261745AbUDNU45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:56:57 -0400
Date: Wed, 14 Apr 2004 04:57:43 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.5
Message-ID: <20040414045743.GF12732@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20040414045552.GB12732@neo.rr.com> <20040414045622.GC12732@neo.rr.com> <20040414045645.GD12732@neo.rr.com> <20040414045711.GE12732@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414045711.GE12732@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/pnp/pnpbios/proc.c b/drivers/pnp/pnpbios/proc.c
--- a/drivers/pnp/pnpbios/proc.c	Wed Apr 14 04:41:10 2004
+++ b/drivers/pnp/pnpbios/proc.c	Wed Apr 14 04:41:10 2004
@@ -139,7 +139,7 @@
 		/* 26 = the number of characters per line sprintf'ed */
 		if ((p - buf + 26) > count)
 			break;
-		if (pnp_bios_get_dev_node(&nodenum, PNPMODE_STATIC, node))
+		if (pnp_bios_get_dev_node(&nodenum, PNPMODE_DYNAMIC, node))
 			break;
 		p += sprintf(p, "%02x\t%08x\t%02x:%02x:%02x\t%04x\n",
 			     node->handle, node->eisa_id,
