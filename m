Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVHPV4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVHPV4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVHPV4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:56:15 -0400
Received: from magic.adaptec.com ([216.52.22.17]:17597 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750986AbVHPV4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:56:14 -0400
Message-ID: <430260F2.9000100@adaptec.com>
Date: Tue, 16 Aug 2005 17:56:02 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Jim Houston <jim.houston@ccur.com>
Subject: [PATCH 2.4.12.5 2/2] include/linux: enclose idr.h in #ifndef
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 21:53:43.0089 (UTC) FILETIME=[F820A210:01C5A2AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch encloses the idr.h header file in
#ifndef __IDR_H__ macro.

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

--- linux-2.6.12.5/include/linux/idr.h.old	2005-08-16 17:20:15.000000000 -0400
+++ linux-2.6.12.5/include/linux/idr.h	2005-08-16 17:21:11.000000000 -0400
@@ -8,6 +8,10 @@
  * Small id to pointer translation service avoiding fixed sized
  * tables.
  */
+
+#ifndef __IDR_H__
+#define __IDR_H__
+
 #include <linux/types.h>
 #include <linux/bitops.h>
 
@@ -76,3 +80,5 @@
 int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
 void idr_remove(struct idr *idp, int id);
 void idr_init(struct idr *idp);
+
+#endif /* __IDR_H__ */
