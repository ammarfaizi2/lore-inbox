Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263254AbUJ2AiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbUJ2AiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbUJ2Ahc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:37:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11015 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263273AbUJ2Aas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:30:48 -0400
Date: Fri, 29 Oct 2004 02:30:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: stern@rowland.harvard.edu
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] USB uhci-debug.c: remove an unused function
Message-ID: <20041029003016.GG29142@stusta.de>
References: <20041028232931.GN3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028232931.GN3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from 
drivers/usb/host/uhci-debug.c


diffstat output:
 drivers/usb/host/uhci-debug.c |   11 -----------
 1 files changed, 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/usb/host/uhci-debug.c.old	2004-10-28 23:30:40.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/usb/host/uhci-debug.c	2004-10-28 23:30:49.000000000 +0200
@@ -34,17 +34,6 @@
 	}
 }
 
-static inline int uhci_is_skeleton_qh(struct uhci_hcd *uhci, struct uhci_qh *qh)
-{
-	int i;
-
-	for (i = 0; i < UHCI_NUM_SKELQH; i++)
-		if (qh == uhci->skelqh[i])
-			return 1;
-
-	return 0;
-}
-
 static int uhci_show_td(struct uhci_td *td, char *buf, int len, int space)
 {
 	char *out = buf;
