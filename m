Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUFUVRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUFUVRy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 17:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266480AbUFUVRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 17:17:54 -0400
Received: from baikonur.stro.at ([213.239.196.228]:6082 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S266473AbUFUVRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 17:17:46 -0400
Date: Mon, 21 Jun 2004 23:17:48 +0200
From: maximilian attems <janitor@sternwelten.at>
To: minyard@mvista.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch-kj] sparse checks ipmi
Message-ID: <20040621211748.GO1545@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Alexander Nyberg <alexn@telia.com>

Sparse checks for include/linux/ipmi.h

Signed-off-by: Alexander Nyberg <alexn@telia.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>


---

 linux-2.6.7-max/include/linux/ipmi.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/linux/ipmi.h~sparse-ipmi include/linux/ipmi.h
--- linux-2.6.7/include/linux/ipmi.h~sparse-ipmi	2004-06-18 10:34:55.000000000 +0200
+++ linux-2.6.7-max/include/linux/ipmi.h	2004-06-18 10:34:55.000000000 +0200
@@ -159,7 +159,7 @@ struct ipmi_msg
 	unsigned char  netfn;
 	unsigned char  cmd;
 	unsigned short data_len;
-	unsigned char  *data;
+	unsigned char  __user *data;
 };
 
 /*
@@ -539,7 +539,7 @@ struct ipmi_recv
 	int     recv_type; /* Is this a command, response or an
 			      asyncronous event. */
 
-	unsigned char *addr;    /* Address the message was from is put
+	unsigned char __user *addr;/* Address the message was from is put
 				   here.  The caller must supply the
 				   memory. */
 	unsigned int  addr_len; /* The size of the address buffer.

_
