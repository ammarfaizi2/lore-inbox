Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVA0P7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVA0P7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVA0P7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:59:40 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:53447 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262650AbVA0P7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:59:38 -0500
Date: Thu, 27 Jan 2005 09:59:23 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] ftape syntax error
Message-ID: <20050127155923.GA3252@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.11-rc2-bk5 introduces two syntax errors under drivers/char/ftape.  The following
patch replaces ");" at the end of two printks which were accidentally removed.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.10/drivers/char/ftape/compressor/zftape-compress.c
===================================================================
--- linux-2.6.10.orig/drivers/char/ftape/compressor/zftape-compress.c	2005-01-27 10:25:52.000000000 -0600
+++ linux-2.6.10/drivers/char/ftape/compressor/zftape-compress.c	2005-01-27 11:10:42.750424360 -0600
@@ -1172,7 +1172,7 @@ int zft_compressor_init(void)
         if (TRACE_LEVEL >= ft_t_info) {
 		printk(
 KERN_INFO "(c) 1997 Claus-Justus Heine (claus@momo.math.rwth-aachen.de)\n"
-KERN_INFO "Compressor for zftape (lzrw3 algorithm)\n"
+KERN_INFO "Compressor for zftape (lzrw3 algorithm)\n");
         }
 #else /* !MODULE */
 	/* print a short no-nonsense boot message */
Index: linux-2.6.10/drivers/char/ftape/lowlevel/ftape-init.c
===================================================================
--- linux-2.6.10.orig/drivers/char/ftape/lowlevel/ftape-init.c	2005-01-27 10:25:52.000000000 -0600
+++ linux-2.6.10/drivers/char/ftape/lowlevel/ftape-init.c	2005-01-27 11:11:12.683873784 -0600
@@ -72,7 +72,7 @@ static int __init ftape_init(void)
 KERN_INFO "(c) 1993-1996 Bas Laarhoven (bas@vimec.nl)\n"
 KERN_INFO "(c) 1995-1996 Kai Harrekilde-Petersen (khp@dolphinics.no)\n"
 KERN_INFO "(c) 1996-1997 Claus-Justus Heine (claus@momo.math.rwth-aachen.de)\n"
-KERN_INFO "QIC-117 driver for QIC-40/80/3010/3020 floppy tape drives\n"
+KERN_INFO "QIC-117 driver for QIC-40/80/3010/3020 floppy tape drives\n");
         }
 #else /* !MODULE */
 	/* print a short no-nonsense boot message */

