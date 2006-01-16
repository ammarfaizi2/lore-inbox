Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWAPJaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWAPJaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWAPJWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:22:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33771 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932273AbWAPJWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:22:49 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Adrian Bunk <bunk@stusta.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 14/25] make some code static
Date: Mon, 16 Jan 2006 07:11:22 -0200
Message-id: <20060116091122.PS72871400014@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Adrian Bunk <bunk@stusta.de>

- This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx25840/cx25840-core.c |    2 +-
 drivers/media/video/tvp5150.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index 0da744c..c66c2c1 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -43,7 +43,7 @@ MODULE_LICENSE("GPL");
 static unsigned short normal_i2c[] = { 0x88 >> 1, I2C_CLIENT_END };
 
 
-int cx25840_debug;
+static int cx25840_debug;
 
 module_param_named(debug,cx25840_debug, int, 0644);
 
diff --git a/drivers/media/video/tvp5150.c b/drivers/media/video/tvp5150.c
index e86b522..8713c4d 100644
--- a/drivers/media/video/tvp5150.c
+++ b/drivers/media/video/tvp5150.c
@@ -634,7 +634,7 @@ struct i2c_vbi_ram_value {
 	unsigned char values[26];
 };
 
-struct i2c_vbi_ram_value vbi_ram_default[] =
+static struct i2c_vbi_ram_value vbi_ram_default[] =
 {
 	{0x010, /* WST SECAM 6 */
 		{ 0xaa, 0xaa, 0xff, 0xff , 0xe7, 0x2e, 0x20, 0x26, 0xe6, 0xb4, 0x0e, 0x0, 0x0, 0x0, 0x10, 0x0 }

