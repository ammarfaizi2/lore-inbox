Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWERUeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWERUeY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWERUeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:34:24 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:16553 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1750923AbWERUeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:34:23 -0400
Message-ID: <446CDA6E.7000400@keyaccess.nl>
Date: Thu, 18 May 2006 22:34:54 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] missing newline in scsi/st.c
Content-Type: multipart/mixed;
 boundary="------------040308060606020505010307"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040308060606020505010307
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Missing closing \n:

===
st: Version 20050830, fixed bufsize 32768, s/g segs 256
st 0:0:6:0: Attached scsi tape st0<4>st0: try direct i/o: yes (alignment 
512 B)
===

Rene.

--------------040308060606020505010307
Content-Type: text/plain;
 name="st_newline.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="st_newline.diff"

Index: local/drivers/scsi/st.c
===================================================================
--- local.orig/drivers/scsi/st.c	2006-05-08 20:47:03.000000000 +0200
+++ local/drivers/scsi/st.c	2006-05-18 22:10:19.000000000 +0200
@@ -4054,7 +4054,7 @@ static int st_probe(struct device *dev)
 	}
 
 	sdev_printk(KERN_WARNING, SDp,
-		    "Attached scsi tape %s", tape_name(tpnt));
+		    "Attached scsi tape %s\n", tape_name(tpnt));
 	printk(KERN_WARNING "%s: try direct i/o: %s (alignment %d B)\n",
 	       tape_name(tpnt), tpnt->try_dio ? "yes" : "no",
 	       queue_dma_alignment(SDp->request_queue) + 1);

--------------040308060606020505010307--
