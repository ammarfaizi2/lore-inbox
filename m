Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUDLO0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbUDLOUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:20:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:31461 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262917AbUDLOTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:19:08 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Device-Mapper 6/9
Date: Mon, 12 Apr 2004 09:18:55 -0500
User-Agent: KMail/1.6
References: <200404120912.45870.kevcorry@us.ibm.com>
In-Reply-To: <200404120912.45870.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120918.55331.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correctly align the dm_target_spec structures during retrieve_status().

--- diff/drivers/md/dm-ioctl.c	2004-04-03 21:36:53.000000000 -0600
+++ source/drivers/md/dm-ioctl.c	2004-04-09 09:42:29.000000000 -0500
@@ -828,7 +828,7 @@
 		outptr += strlen(outptr) + 1;
 		used = param->data_start + (outptr - outbuf);
 
-		align_ptr(outptr);
+		outptr = align_ptr(outptr);
 		spec->next = outptr - outbuf;
 	}
 
