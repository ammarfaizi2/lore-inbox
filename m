Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSHXJ4y>; Sat, 24 Aug 2002 05:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSHXJ4x>; Sat, 24 Aug 2002 05:56:53 -0400
Received: from ns2.sea.interquest.net ([66.135.144.2]:39340 "EHLO ns2.sea")
	by vger.kernel.org with ESMTP id <S315491AbSHXJ4w>;
	Sat, 24 Aug 2002 05:56:52 -0400
Date: Sat, 24 Aug 2002 03:06:46 -0700
From: silvio@qualys.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH TRIVIAL]: drivers/acorn/char/pcf8583.c
Message-ID: <20020824030646.D1616@hamsec.aurora.sfo.interquest.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

trivial patch to fix memory leak

--
Silvio

--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.linux4"

--- linux-2.4.19/drivers/acorn/char/pcf8583.c	Fri Mar  2 18:38:37 2001
+++ linux-2.4.19-dev/drivers/acorn/char/pcf8583.c	Sat Aug 24 02:35:07 2002
@@ -73,6 +73,7 @@
 pcf8583_detach(struct i2c_client *client)
 {
 	i2c_detach_client(client);
+	kfree(client);
 	return 0;
 }
 

--WYTEVAkct0FjGQmd--
