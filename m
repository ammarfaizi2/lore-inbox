Return-Path: <linux-kernel-owner+w=401wt.eu-S1754798AbWLTMCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbWLTMCY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWLTMCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:02:16 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1578 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964974AbWLTMB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:01:59 -0500
Date: Wed, 20 Dec 2006 12:01:55 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 05/10] if_fddi.h: Add a missing inclusion
Message-ID: <Pine.LNX.4.64N.0612201113410.11005@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is a change to include <linux/netdevice.h> in <linux/if_fddi.h> 
which is needed for "struct fddi_statistics".

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-if_fddi-netdev-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/linux/if_fddi.h linux-mips-2.6.18-20060920/include/linux/if_fddi.h
--- linux-mips-2.6.18-20060920.macro/include/linux/if_fddi.h	2006-09-20 20:51:20.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/linux/if_fddi.h	2006-12-14 04:36:58.000000000 +0000
@@ -103,6 +103,8 @@ struct fddihdr
 	} __attribute__ ((packed));
 
 #ifdef __KERNEL__
+#include <linux/netdevice.h>
+
 /* Define FDDI statistics structure */
 struct fddi_statistics {
 
