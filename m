Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVCUUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVCUUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVCUUs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:48:28 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.16]:5686 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261877AbVCUUoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:44:39 -0500
Date: Mon, 21 Mar 2005 21:44:29 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <greg@kroah.com>, Kylene Hall <kjhall@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] TPM depends on PCI
Message-ID: <Pine.LNX.4.62.0503212142520.29192@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


TPM depends on PCI.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.12-rc1/drivers/char/tpm/Kconfig	2005-03-18 13:30:48.000000000 +0100
+++ linux-m68k-2.6.12-rc1/drivers/char/tpm/Kconfig	2005-03-21 21:29:36.739986209 +0100
@@ -6,7 +6,7 @@ menu "TPM devices"
 
 config TCG_TPM
 	tristate "TPM Hardware Support"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && PCI
 	---help---
 	  If you have a TPM security chip in your system, which
 	  implements the Trusted Computing Group's specification,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
