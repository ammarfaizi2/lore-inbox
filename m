Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVF0NH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVF0NH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVF0NF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:05:27 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:11749 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262054AbVF0MQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:29 -0400
Message-Id: <20050627121415.840680000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:32 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <clucas@rotomalug.org>,
       Domen Puncer <domen@coderock.org>
Content-Disposition: inline; filename=dvb-ttpci-kj-printk.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 32/51] ttpci: kj printk fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>

printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110_ipack.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_ipack.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110_ipack.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_ipack.c	2005-06-27 13:24:25.000000000 +0200
@@ -24,7 +24,7 @@ int av7110_ipack_init(struct ipack *p, i
 		      void (*func)(u8 *buf, int size, void *priv))
 {
 	if (!(p->buf = vmalloc(size*sizeof(u8)))) {
-		printk ("Couldn't allocate memory for ipack\n");
+		printk(KERN_WARNING "Couldn't allocate memory for ipack\n");
 		return -ENOMEM;
 	}
 	p->size = size;

--

