Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWCTD4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWCTD4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 22:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWCTD4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 22:56:17 -0500
Received: from bluesky.ret.me.uk ([82.71.120.246]:2577 "EHLO bluesky.ret.me.uk")
	by vger.kernel.org with ESMTP id S1751364AbWCTD4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 22:56:16 -0500
Date: Mon, 20 Mar 2006 03:56:02 +0000
From: Richard Thrippleton <ret28@cam.ac.uk>
To: rubini@vision.unipv.it
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Defaults PS/2 mouse rate to 40 on the toshiba m300
Message-ID: <20060320035602.GF28913@ret.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some models of Toshiba laptop have issues handling high rate data from an
onboard synaptics PS/2 touchpad. There already exists a blacklist of models
suffering from this problem which is used to cap the rate to 40pps. This patch
adds the Toshiba Portege M300 to the blacklist, as it also suffers from the
same problem.


Signed-off-by: Richard Thrippleton <ret28@cam.ac.uk>

---

--- drivers/input/mouse/synaptics.c.orig        2006-03-20 03:36:05.000000000 +0
000
+++ drivers/input/mouse/synaptics.c     2006-03-20 03:37:17.000000000 +0000
@@ -615,6 +615,13 @@ static struct dmi_system_id toshiba_dmi_
                        DMI_MATCH(DMI_PRODUCT_NAME , "dynabook"),
                },
        },
+       {
+               .ident = "Toshiba Portege M300",
+               .matches = {
+                       DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+                       DMI_MATCH(DMI_PRODUCT_NAME , "PORTEGE M300"),
+               },
+       },
        { }
 };
 #endif
