Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTETW44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTETWxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:53:34 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.27]:23106 "EHLO
	mwinf0403.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261422AbTETWxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:53:05 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 13/14] USB speedtouch: receive path micro optimization
Date: Wed, 21 May 2003 01:06:00 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210106.00186.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the most discriminating comparison first.

 speedtch.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:41:10 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:41:10 2003
@@ -257,7 +257,7 @@
 	struct udsl_vcc_data *vcc;
 
 	list_for_each_entry (vcc, &instance->vcc_list, list)
-		if ((vcc->vpi == vpi) && (vcc->vci == vci))
+		if ((vcc->vci == vci) && (vcc->vpi == vpi))
 			return vcc;
 	return NULL;
 }

