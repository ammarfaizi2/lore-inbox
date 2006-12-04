Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937105AbWLDQdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937105AbWLDQdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937102AbWLDQdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:33:10 -0500
Received: from [81.2.110.250] ([81.2.110.250]:46863 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-??-OK-FAIL) by vger.kernel.org with ESMTP
	id S937105AbWLDQdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:33:09 -0500
Date: Mon, 4 Dec 2006 16:38:25 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] pata_via: VIA 8251 bridged systems are now out and about
Message-ID: <20061204163825.0dba3bbf@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_via.c linux-2.6.19-rc6-mm1/drivers/ata/pata_via.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_via.c	2006-11-24 13:58:28.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_via.c	2006-12-04 13:50:06.357544152 +0000
@@ -23,6 +23,7 @@
  *	VIA VT8233c	-	UDMA100
  *	VIA VT8235	-	UDMA133
  *	VIA VT8237	-	UDMA133
+ *	VIA VT8251	-	UDMA133
  *
  *	Most registers remain compatible across chips. Others start reserved
  *	and acquire sensible semantics if set to 1 (eg cable detect). A few
@@ -94,6 +95,7 @@
 	u8 rev_max;
 	u16 flags;
 } via_isa_bridges[] = {
+	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST | VIA_NO_ENABLES},
 	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
