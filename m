Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131723AbRAAPXN>; Mon, 1 Jan 2001 10:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131813AbRAAPXD>; Mon, 1 Jan 2001 10:23:03 -0500
Received: from [195.180.174.143] ([195.180.174.143]:3973 "EHLO
	ghanima.neukum.org") by vger.kernel.org with ESMTP
	id <S131723AbRAAPWx>; Mon, 1 Jan 2001 10:22:53 -0500
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: IRNET depending on PPP
Date: Mon, 1 Jan 2001 15:32:47 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
Cc: mec@shout.net
MIME-Version: 1.0
Message-Id: <01010115524900.10792@ghanima>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi,

IRNET depends on PPP, but that is not reflected in the configuration files.
A patch is attached.

	Regards
		Oliver

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain;
  name="irda.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="irda.diff"

--- linux-vanilla/net/irda/irnet/Config.in	Mon Jan  1 14:34:02 2001
+++ linux/net/irda/irnet/Config.in	Mon Jan  1 15:35:15 2001
@@ -1 +1,3 @@
-dep_tristate '  IrNET protocol' CONFIG_IRNET $CONFIG_IRDA
+if [ "$CONFIG_PPP" != "n" ]; then
+	dep_tristate '  IrNET protocol' CONFIG_IRNET $CONFIG_IRDA
+fi

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
