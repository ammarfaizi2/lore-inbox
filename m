Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTJMQTw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbTJMQTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:19:52 -0400
Received: from imladris.surriel.com ([66.92.77.98]:20160 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261923AbTJMQSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:18:41 -0400
Date: Mon, 13 Oct 2003 12:18:26 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] initialise variable in sym53c8xx.c
Message-ID: <Pine.LNX.4.55L.0310131218000.27244@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urNp linux-5110/drivers/scsi/sym53c8xx.c linux-10010/drivers/scsi/sym53c8xx.c
--- linux-5110/drivers/scsi/sym53c8xx.c
+++ linux-10010/drivers/scsi/sym53c8xx.c
@@ -6992,7 +6992,7 @@ static void ncr_chip_reset (ncb_p np)

 static void ncr_soft_reset(ncb_p np)
 {
-	u_char istat;
+	u_char istat=0;
 	int i;

 	if (!(np->features & FE_ISTAT1) || !(INB (nc_istat1) & SRUN))
