Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWACOdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWACOdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWACOdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:33:13 -0500
Received: from alpha.uhasselt.be ([193.190.2.30]:56080 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S932356AbWACOdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:33:12 -0500
To: torvalds@osdl.org
Subject: [PATCH] cs53l32a: kzalloc conversion
Cc: linux-kernel@vger.kernel.org
Reply-To: takis@issaris.org
Message-Id: <20060103143301.0D98E5BC3@localhost.localdomain>
Date: Tue,  3 Jan 2006 15:33:01 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

Conversion of kmalloc+memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 drivers/media/video/cs53l32a.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

d27ad6f2f4c46ed0b29034c413cc8f948506fdc6
diff --git a/drivers/media/video/cs53l32a.c b/drivers/media/video/cs53l32a.c
index 780b352..f9e3b8b 100644
--- a/drivers/media/video/cs53l32a.c
+++ b/drivers/media/video/cs53l32a.c
@@ -146,11 +146,10 @@ static int cs53l32a_attach(struct i2c_ad
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return 0;
 
-	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (client == 0)
 		return -ENOMEM;
 
-	memset(client, 0, sizeof(struct i2c_client));
 	client->addr = address;
 	client->adapter = adapter;
 	client->driver = &i2c_driver;
-- 
0.99.9.GIT
