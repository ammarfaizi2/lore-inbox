Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269976AbUJVOTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269976AbUJVOTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269962AbUJVOTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:19:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52490 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269976AbUJVOSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:18:50 -0400
Date: Fri, 22 Oct 2004 16:18:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Rokos <michal@rokos.info>, linux-kernel@vger.kernel.org
Subject: [Patch 2.6] PCMCIA ds - Exclude uneeded code when ! CONFIG_PROC_FS (fwd)
Message-ID: <20041022141815.GE2831@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This trivial patch by Michal Rokos <michal@rokos.info> forwarded below 
still applies against 2.6.9-mm1.


Signed-off-by: Adrian Bunk <bunk@stusta.de>




----- Forwarded message from Michal Rokos <michal@rokos.info> -----

Date:	Fri, 15 Oct 2004 14:34:58 +0200
From: Michal Rokos <michal@rokos.info>
To: linux-kernel@vger.kernel.org
Subject: [Patch 2.6] PCMCIA ds - Exclude uneeded code when ! CONFIG_PROC_FS

Hello,

just a oneliner to remove unneeded definition that is done below in the 
code anyway.

Michal

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/15 13:28:23+02:00 michal@nb-rokos.nx.cz 
#   proc_pccard is declared below once again, so exclude it here and let 
it be in ifdef CONFIG_PROC_FS block.
# 
# drivers/pcmcia/ds.c
#   2004/10/15 13:28:02+02:00 michal@nb-rokos.nx.cz +0 -2
#   proc_pccard is declared below once again, so exclude it here and let 
it be in ifdef CONFIG_PROC_FS block.
# 
diff -Nru a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
--- a/drivers/pcmcia/ds.c 2004-10-15 14:26:19 +02:00
+++ b/drivers/pcmcia/ds.c 2004-10-15 14:26:19 +02:00
@@ -134,8 +134,6 @@
 
 static int major_dev = -1;
 
-static struct proc_dir_entry *proc_pccard;
-
 /*====================================================================*/
 
 /* code which was in cs.c before */

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

