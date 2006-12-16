Return-Path: <linux-kernel-owner+w=401wt.eu-S1030916AbWLPMqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030916AbWLPMqV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 07:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030917AbWLPMqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 07:46:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49119 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030916AbWLPMqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 07:46:20 -0500
Date: Sat, 16 Dec 2006 12:54:29 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: torvalds@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix help text for CONFIG_ATA_PIIX
Message-ID: <20061216125429.68e5cdc5@localhost.localdomain>
In-Reply-To: <200612142006.49406.s0348365@sms.ed.ac.uk>
References: <200612141714.55948.s0348365@sms.ed.ac.uk>
	<200612141832.50587.s0348365@sms.ed.ac.uk>
	<20061214195314.GC10955@nostromo.devel.redhat.com>
	<200612142006.49406.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for clarifying Bill, and sorry Alan. ata_piix does indeed work 
> correctly. The help text is a bit confusing:
> 
> config ATA_PIIX
>         tristate "Intel PIIX/ICH SATA support"
>         depends on PCI
>         help
>           This option enables support for ICH5/6/7/8 Serial ATA.
>           If PATA support was enabled previously, this enables
>           support for select Intel PIIX/ICH PATA host controllers.

New help text

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.20-rc1/drivers/ata/Kconfig	2006-12-14 17:23:30.000000000 +0000
+++ linux-2.6.20-rc1/drivers/ata/Kconfig	2006-12-16 12:29:50.198153800 +0000
@@ -40,9 +40,9 @@
 	tristate "Intel PIIX/ICH SATA support"
 	depends on PCI
 	help
-	  This option enables support for ICH5/6/7/8 Serial ATA.
-	  If PATA support was enabled previously, this enables
-	  support for select Intel PIIX/ICH PATA host controllers.
+	  This option enables support for ICH5/6/7/8 Serial ATA
+	  and support for PATA on the Intel PIIX3/PIIX4/ICH series
+	  PATA host controllers.
 
 	  If unsure, say N.
 
