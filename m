Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbVIEVnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbVIEVnm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbVIEVnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:43:41 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:18258 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932660AbVIEVni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:38 -0400
Date: Mon, 05 Sep 2005 18:26:15 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 05/24] V4L: Changes the prefix of msp34xx and error while
 reading chip version
Message-ID: <431cb7f7.DjlZVZaWNw9uhUc2%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f7.pEOko3CRE6K3VaGm+UC5voVz9k8knhaP9E1pTmKJM8h1B+Jj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f7.pEOko3CRE6K3VaGm+UC5voVz9k8knhaP9E1pTmKJM8h1B+Jj
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f7.pEOko3CRE6K3VaGm+UC5voVz9k8knhaP9E1pTmKJM8h1B+Jj
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-05-patch.diff"

- Changes the prefix to 'msp34xx' instead of 'msp3400'.
- Changes the message 'error while reading chip version' to a debug printk at
   msp3400.c

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/msp3400.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -u /tmp/dst.31930 linux/drivers/media/video/msp3400.c
--- /tmp/dst.31930	2005-09-05 11:42:41.000000000 -0300
+++ linux/drivers/media/video/msp3400.c	2005-09-05 11:42:41.000000000 -0300
@@ -1452,7 +1452,7 @@
         client_template.addr = addr;
 
         if (-1 == msp3400c_reset(&client_template)) {
-                dprintk("msp3400: no chip found\n");
+                dprintk("msp34xx: no chip found\n");
                 return -1;
         }
 
@@ -1478,7 +1478,7 @@
 	if (-1 == msp3400c_reset(c)) {
 		kfree(msp);
 		kfree(c);
-		dprintk("msp3400: no chip found\n");
+		dprintk("msp34xx: no chip found\n");
 		return -1;
 	}
 
@@ -1488,7 +1488,7 @@
 	if ((-1 == msp->rev1) || (0 == msp->rev1 && 0 == msp->rev2)) {
 		kfree(msp);
 		kfree(c);
-		printk("msp3400: error while reading chip version\n");
+		dprintk("msp34xx: error while reading chip version\n");
 		return -1;
 	}
 

--=_431cb7f7.pEOko3CRE6K3VaGm+UC5voVz9k8knhaP9E1pTmKJM8h1B+Jj--
