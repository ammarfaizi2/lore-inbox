Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTESB0e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 21:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbTESB0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 21:26:34 -0400
Received: from dp.samba.org ([66.70.73.150]:30353 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262285AbTESB0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 21:26:33 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16072.13753.498811.834748@argo.ozlabs.ibm.com>
Date: Mon, 19 May 2003 11:39:05 +1000
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH] Compile fix for pmac IDE driver
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart,

The version of drivers/ide/ppc/pmac.c in Linus' tree at the moment
doesn't compile.  The one-liner below fixes it.  Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/ide/ppc/pmac.c pmac-2.5/drivers/ide/ppc/pmac.c
--- linux-2.5/drivers/ide/ppc/pmac.c	2003-05-12 17:41:32.000000000 +1000
+++ pmac-2.5/drivers/ide/ppc/pmac.c	2003-05-13 16:48:42.000000000 +1000
@@ -721,7 +721,7 @@
 		}
 	}
 
-	return NODEV;
+	return 0;
 }
 
 void __init
