Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbVALFgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbVALFgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVALFew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:34:52 -0500
Received: from ozlabs.org ([203.10.76.45]:3473 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263104AbVALF3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:29:47 -0500
Date: Wed, 12 Jan 2005 16:28:48 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, orinoco-devel@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [7/8] orinoco: Replace obsolete MODULE_PARM()
Message-ID: <20050112052848.GH30426@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20050112052352.GA30426@localhost.localdomain> <20050112052434.GB30426@localhost.localdomain> <20050112052543.GC30426@localhost.localdomain> <20050112052630.GD30426@localhost.localdomain> <20050112052711.GE30426@localhost.localdomain> <20050112052741.GF30426@localhost.localdomain> <20050112052814.GG30426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112052814.GG30426@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace obsolete MODULE_PARM() with module_param() in the orinoco
driver.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-01-12 15:47:48.215477920 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-01-12 15:50:14.156291544 +1100
@@ -461,12 +461,14 @@
 /* Level of debugging. Used in the macros in orinoco.h */
 #ifdef ORINOCO_DEBUG
 int orinoco_debug = ORINOCO_DEBUG;
-MODULE_PARM(orinoco_debug, "i");
+module_param(orinoco_debug, int, 0644);
+MODULE_PARM_DESC(orinoco_debug, "Debug level");
 EXPORT_SYMBOL(orinoco_debug);
 #endif
 
 static int suppress_linkstatus; /* = 0 */
-MODULE_PARM(suppress_linkstatus, "i");
+module_param(suppress_linkstatus, int, 0644);
+MODULE_PARM_DESC(suppress_linkstatus, "Don't log link status changes");
 
 /********************************************************************/
 /* Compile time configuration and compatibility stuff               */


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
