Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbTCYBcL>; Mon, 24 Mar 2003 20:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbTCYBaZ>; Mon, 24 Mar 2003 20:30:25 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26384 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261345AbTCYB2I>;
	Mon, 24 Mar 2003 20:28:08 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <10485563193095@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
Message-id: <10485563201543@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.357.4, 2003/03/21 16:00:39-08:00, greg@kroah.com

i2c: add struct device to i2c_client structure

Not quite ready to hook it up to the driver core yet.


 include/linux/i2c.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Mon Mar 24 17:28:24 2003
+++ b/include/linux/i2c.h	Mon Mar 24 17:28:24 2003
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

