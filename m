Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUGROUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUGROUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 10:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUGROUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 10:20:37 -0400
Received: from [80.190.193.18] ([80.190.193.18]:5041 "EHLO mx.vsadmin.de")
	by vger.kernel.org with ESMTP id S264147AbUGROUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 10:20:33 -0400
From: Stefan Meyknecht <sm0407@nurfuerspam.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.8-rc2: MO-drive write open fix
Date: Sun, 18 Jul 2004 16:20:29 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tco+AjF4tRRFGGe"
Message-Id: <200407181620.29001.sm0407@nurfuerspam.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tco+AjF4tRRFGGe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

the attached patch allows me to mount my mo-drive readwrite. Please 
review.

Stefan

-- 
Stefan Meyknecht
stefan at meyknecht dot org

--Boundary-00=_tco+AjF4tRRFGGe
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-cdrom"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-cdrom"

--- linux/drivers/cdrom/cdrom.c.orig	2004-07-18 15:01:17.087953545 +0200
+++ linux/drivers/cdrom/cdrom.c	2004-07-18 15:32:26.325231750 +0200
@@ -899,7 +899,7 @@
 			ret = -EROFS;
 			if (cdrom_open_write(cdi))
 				goto err;
-			if (!CDROM_CAN(CDC_RAM))
+			if (!CDROM_CAN(CDC_RAM) && !CDROM_CAN(CDC_MO_DRIVE))
 				goto err;
 			ret = 0;
 		}

--Boundary-00=_tco+AjF4tRRFGGe--
