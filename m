Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261730AbTCVBDQ>; Fri, 21 Mar 2003 20:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261702AbTCVAyC>; Fri, 21 Mar 2003 19:54:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53256 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261690AbTCVAxn>;
	Fri, 21 Mar 2003 19:53:43 -0500
Subject: Re: [PATCH] More i2c driver changes for 2.5.65
In-reply-to: <10482950852454@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Fri, 21 Mar 2003 17:04 -0800
Message-id: <1048295086481@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1191, 2003/03/21 16:00:39-08:00, greg@kroah.com

i2c: add struct device to i2c_client structure

Not quite ready to hook it up to the driver core yet.


 include/linux/i2c.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Fri Mar 21 16:53:17 2003
+++ b/include/linux/i2c.h	Fri Mar 21 16:53:17 2003
@@ -170,8 +170,9 @@
 	void *data;			/* for the clients		*/
 	int usage_count;		/* How many accesses currently  */
 					/* to the client		*/
+	struct device dev;		/* the device structure		*/
 };
-
+#define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
 /*
  * The following structs are for those who like to implement new bus drivers:

