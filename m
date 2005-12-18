Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbVLRDrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVLRDrh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVLRDrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:47:37 -0500
Received: from www.swissdisk.com ([216.144.233.50]:41129 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S965020AbVLRDrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:47:36 -0500
Date: Sat, 17 Dec 2005 18:38:35 -0800
From: Ben Collins <bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH 2.6.15-git] alps: Add Fujitsu Siemens S6010 support to alps driver.
Message-ID: <20051218023835.GA15232@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PatchAuthor: andrew.waldrom@siemens.com
Reference: http://bugzilla.ubuntu.com/13404
    
Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index a80d6b9..3cffe1d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -42,7 +42,7 @@ static struct alps_model_info alps_model
 	{ { 0x53, 0x02, 0x14 },	0xf8, 0xf8, 0 },
 	{ { 0x63, 0x02, 0x0a },	0xf8, 0xf8, 0 },
 	{ { 0x63, 0x02, 0x14 },	0xf8, 0xf8, 0 },
-	{ { 0x63, 0x02, 0x28 },	0xf8, 0xf8, 0 },
+	{ { 0x63, 0x02, 0x28 },	0xf8, 0xf8, ALPS_FW_BK_2 },		/* Fujitsu Siemens S6010 */
 	{ { 0x63, 0x02, 0x3c },	0x8f, 0x8f, ALPS_WHEEL },		/* Toshiba Satellite S2400-103 */
 	{ { 0x63, 0x02, 0x50 },	0xef, 0xef, ALPS_FW_BK_1 },		/* NEC Versa L320 */
 	{ { 0x63, 0x02, 0x64 },	0xf8, 0xf8, 0 },
