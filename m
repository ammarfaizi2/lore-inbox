Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266430AbTGETOe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266434AbTGETOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:14:34 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:7572 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266430AbTGETOb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:14:31 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Gerard Roudier <groudier@free.fr>
Subject: [PATCH 2.4.21-bk1] SYMBIOS/LSILOGIC 53C8XX and 53C1010 compile warning fix
Date: Sat, 5 Jul 2003 19:43:32 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307051943.32321.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

fixes "Warning: integer constant is too large for "long" type"
compiletime warning.

- --- drivers/scsi/sym53c8xx_2/sym_glue.c.orig    2002-11-29 19:26:38.000000000 +0100
+++ drivers/scsi/sym53c8xx_2/sym_glue.c 2003-07-05 19:40:13.000000000 +0200
@@ -1879,9 +1879,9 @@
                goto out_err32;
 #else
 #if   SYM_CONF_DMA_ADDRESSING_MODE == 1
- -#define        PciDmaMask      0xffffffffff
+#define        PciDmaMask      0xffffffffffULL
 #elif SYM_CONF_DMA_ADDRESSING_MODE == 2
- -#define        PciDmaMask      0xffffffffffffffff
+#define        PciDmaMask      0xffffffffffffffffULL
 #endif
        if (np->features & FE_DAC) {
                if (!pci_set_dma_mask(np->s.device, PciDmaMask)) {

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 19:37:11 up 40 min,  3 users,  load average: 1.05, 1.09, 1.08

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Bw5EoxoigfggmSgRAhpwAJ9hRJbZVnMGOemM+/TaL8GKx/azCQCfWTfW
w0kwmmVbLZA+u6/dWwNMHl4=
=UD4Q
-----END PGP SIGNATURE-----


