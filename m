Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264224AbTICXXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTICXXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:23:41 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43517 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264224AbTICXXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:23:37 -0400
Date: Thu, 4 Sep 2003 01:23:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.6 patch] let "PCMCIA SCSI adapter support" menu depend on MODULES
Message-ID: <20030903232334.GL18025@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When configuring a kernel without modules support "PCMCIA SCSI adapter 
support" is a menu with no available items in it (all drivers depend on 
"m").

The patch below only shows this menu when MODULES is enabled.

Please apply
Adrian

--- linux-2.6.0-test4-mm5/drivers/scsi/pcmcia/Kconfig.old	2003-09-04 01:18:17.000000000 +0200
+++ linux-2.6.0-test4-mm5/drivers/scsi/pcmcia/Kconfig	2003-09-04 01:19:03.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menu "PCMCIA SCSI adapter support"
-	depends on SCSI!=n && PCMCIA!=n
+	depends on SCSI!=n && PCMCIA!=n && MODULES
 
 config PCMCIA_AHA152X
 	tristate "Adaptec AHA152X PCMCIA support"
