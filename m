Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTJMPyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTJMPyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:54:08 -0400
Received: from imladris.surriel.com ([66.92.77.98]:54974 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261823AbTJMPyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:54:06 -0400
Date: Mon, 13 Oct 2003 11:53:47 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] initialise variable in eata_dma.c
Message-ID: <Pine.LNX.4.55L.0310131152150.27244@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shut up gcc warning, since real assignment to variable happens inside
an if branch.

diff -urNp linux-5110/drivers/scsi/eata_dma.c linux-10010/drivers/scsi/eata_dma.c
--- linux-5110/drivers/scsi/eata_dma.c	2001-09-30 21:26:07.000000000 +0200
+++ linux-10010/drivers/scsi/eata_dma.c
@@ -1067,7 +1067,7 @@ short register_HBA(u32 base, struct get_
     char *buff = 0;
     unchar bugs = 0;
     struct Scsi_Host *sh;
-    hostdata *hd;
+    hostdata *hd=NULL;
     int x;


