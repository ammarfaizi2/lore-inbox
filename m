Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280836AbRLDAmu>; Mon, 3 Dec 2001 19:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282858AbRLDAmh>; Mon, 3 Dec 2001 19:42:37 -0500
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:63887 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S280947AbRLDAlV>; Mon, 3 Dec 2001 19:41:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ghozlane Toumi <ghoz@sympatico.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.2.20 compilation on alpha
Date: Mon, 3 Dec 2001 19:43:34 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011204004115.DOIE25459.tomts20-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

2.2.20 won't compile out of the box on my alpha: I had to apply this patch .
The kernel builds and boots fine so far, so I can say that "it works for me" .
Sorry if this has already be beaten to death ...

ghoz

--- include/asm/pci.h.orig	Sun Dec  2 21:08:08 2001
+++ include/asm/pci.h	Mon Dec  3 13:43:32 2001
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/pci.h>
+#include <linux/errno.h>
 
 
 /*
@@ -59,7 +60,7 @@
 	if (bus2hose[pdev->bus->number] == NULL)
 		return -ENXIO;
 
-	return bus2hose[pdev->bus->number]->pci_host_index;
+	return bus2hose[pdev->bus->number]->pci_hose_index;
 }
 
 #endif /* __ALPHA_PCI_H */
