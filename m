Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbTDIWRp (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTDIWRp (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:17:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62601 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263874AbTDIWRk convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:17:40 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10499274992999@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.67
In-Reply-To: <10499274993729@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Apr 2003 15:31:39 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1033.3.3, 2003/04/07 09:38:53-07:00, greg@kroah.com

i2c: fix up via686a.c driver based on previous i2c api changes.


 drivers/i2c/chips/via686a.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Wed Apr  9 15:16:40 2003
+++ b/drivers/i2c/chips/via686a.c	Wed Apr  9 15:16:40 2003
@@ -390,8 +390,7 @@
 static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
 
 static int via686a_attach_adapter(struct i2c_adapter *adapter);
-static int via686a_detect(struct i2c_adapter *adapter, int address,
-			  unsigned short flags, int kind);
+static int via686a_detect(struct i2c_adapter *adapter, int address, int kind);
 static int via686a_detach_client(struct i2c_client *client);
 
 static inline int via686a_read_value(struct i2c_client *client, u8 reg)
@@ -665,8 +664,7 @@
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
 
-static int via686a_detect(struct i2c_adapter *adapter, int address,
-		   unsigned short flags, int kind)
+static int via686a_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct via686a_data *data;

