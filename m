Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUDNU6D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUDNU6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:58:02 -0400
Received: from cpe-024-033-224-95.neo.rr.com ([24.33.224.95]:62084 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261706AbUDNU52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:57:28 -0400
Date: Wed, 14 Apr 2004 04:58:15 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.5
Message-ID: <20040414045815.GG12732@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20040414045552.GB12732@neo.rr.com> <20040414045622.GC12732@neo.rr.com> <20040414045645.GD12732@neo.rr.com> <20040414045711.GE12732@neo.rr.com> <20040414045743.GF12732@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414045743.GF12732@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Wed Apr 14 04:40:54 2004
+++ b/drivers/pnp/isapnp/core.c	Wed Apr 14 04:40:54 2004
@@ -995,7 +995,7 @@
 			res->port_resource[tmp].flags = IORESOURCE_IO;
 		}
 		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
-			ret = isapnp_read_dword(ISAPNP_CFG_MEM + (tmp << 3));
+			ret = isapnp_read_word(ISAPNP_CFG_MEM + (tmp << 3)) << 8;
 			if (!ret)
 				continue;
 			res->mem_resource[tmp].start = ret;
