Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTEVBOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 21:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTEVBOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 21:14:33 -0400
Received: from dp.samba.org ([66.70.73.150]:33682 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262431AbTEVBOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 21:14:32 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16076.10099.291372.253949@argo.ozlabs.ibm.com>
Date: Thu, 22 May 2003 11:27:15 +1000
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix drivers/ide/ppc/pmac.c compile
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch fixes a compile error in drivers/ide/ppc/pmac.c and has
been approved by Bartlomiej.  Please apply.

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
