Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVBXEnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVBXEnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVBXERy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:17:54 -0500
Received: from ozlabs.org ([203.10.76.45]:16054 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261786AbVBXENY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:24 -0500
Date: Thu, 24 Feb 2005 15:00:24 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [7/14] Orinoco driver updates - use modern module_parm()
Message-ID: <20050224040024.GI32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035355.GA32001@localhost.localdomain> <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224035957.GH32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add descrptions to module parameters in the orinoco driver, and also
add permissions to allow them to be exported in sysfs.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-02-10 13:19:14.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-02-10 13:24:03.000000000 +1100
@@ -461,12 +461,14 @@
 /* Level of debugging. Used in the macros in orinoco.h */
 #ifdef ORINOCO_DEBUG
 int orinoco_debug = ORINOCO_DEBUG;
-module_param(orinoco_debug, int, 0);
+module_param(orinoco_debug, int, 0644);
+MODULE_PARM_DESC(orinoco_debug, "Debug level");
 EXPORT_SYMBOL(orinoco_debug);
 #endif
 
 static int suppress_linkstatus; /* = 0 */
-module_param(suppress_linkstatus, bool, 0);
+module_param(suppress_linkstatus, bool, 0644);
+MODULE_PARM_DESC(suppress_linkstatus, "Don't log link status changes");
 
 /********************************************************************/
 /* Compile time configuration and compatibility stuff               */


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
