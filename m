Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWIYO76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWIYO76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWIYO76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:59:58 -0400
Received: from v813.rev.tld.pl ([195.149.226.213]:39835 "EHLO
	smtp.host4.kei.pl") by vger.kernel.org with ESMTP id S1750891AbWIYO75 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:59:57 -0400
X-clamdmail: clamdmail 0.18a
From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Organization: OpenEmbedded
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm updated] PCMCIA: Add few IDs into ide-cs
Date: Mon, 25 Sep 2006 16:59:43 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       linux-pcmcia@lists.infradead.org
References: <20060920135438.d7dd362b.akpm@osdl.org>
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609251659.44848.openembedded@hrw.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia �roda, 20 wrze�nia 2006 22:54, Andrew Morton napisa�:

> When replying to this email, please rewrite the Subject: to something
> appropriate.  Please also attempt to cc the appropriate developer(s).

> pcmcia-add-few-ids-into-ide-cs.patch

I got another submission from user so had to update patch.

From: Marcin Juszkiewicz <openembedded@hrw.one.pl>

Few cards informations submitted by OpenZaurus users.

Seagate 8GB microdrive:
 product info: "SEAGATE", "ST1"
 manfid 0x0111, 0x0000

One CF card:
 product info: "SAMSUNG", "04/05/06", "", ""
 manfid : 0x0000, 0x0000

Ridata 8GB Pro 150X Compact Flash Card:
 product info: "SMI VENDOR", "SMI PRODUCT", ""
 manfid: 0x000a, 0x0000

 product info: "M-Systems", "CF500", ""
 manfid: 0x000a, 0x0000

 product info: "TRANSCEND", "TS4GCF120", ""
 manfid: 0x000a, 0x0000

Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>

---
Patch follow kernel version 2.6.18

Please Cc: me - I'm not subscribed to linux-pcmcia or linux-kernel

 ide-cs.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/drivers/ide/legacy/ide-cs.c
===================================================================
--- linux-2.6.orig/drivers/ide/legacy/ide-cs.c	2006-08-23 11:02:37.958306000 +0200
+++ linux-2.6/drivers/ide/legacy/ide-cs.c	2006-09-25 16:45:35.765780000 +0200
@@ -398,12 +398,17 @@
 	PCMCIA_DEVICE_PROD_ID12("IO DATA", "PCIDE", 0x547e66dc, 0x5c5ab149),
 	PCMCIA_DEVICE_PROD_ID12("IO DATA", "PCIDEII", 0x547e66dc, 0xb3662674),
 	PCMCIA_DEVICE_PROD_ID12("LOOKMEET", "CBIDE2      ", 0xe37be2b5, 0x8671043b),
+	PCMCIA_DEVICE_PROD_ID12("M-Systems", "CF500", 0x7ed2ad87, 0x7a13045c),
 	PCMCIA_DEVICE_PROD_ID2("NinjaATA-", 0xebe0bd79),
 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "CD-ROM", 0x281f1c5d, 0x66536591),
 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "PnPIDE", 0x281f1c5d, 0x0c694728),
 	PCMCIA_DEVICE_PROD_ID12("SHUTTLE TECHNOLOGY LTD.", "PCCARD-IDE/ATAPI Adapter", 0x4a3f0ba0, 0x322560e1),
+	PCMCIA_DEVICE_PROD_ID12("SEAGATE", "ST1", 0x87c1b330, 0xe1f30883),
+	PCMCIA_DEVICE_PROD_ID12("SAMSUNG", "04/05/06", 0x43d74cb4, 0x6a22777d),
+	PCMCIA_DEVICE_PROD_ID12("SMI VENDOR", "SMI PRODUCT", 0x30896c92, 0x703cc5f6),
 	PCMCIA_DEVICE_PROD_ID12("TOSHIBA", "MK2001MPL", 0xb4585a1a, 0x3489e003),
 	PCMCIA_DEVICE_PROD_ID1("TRANSCEND    512M   ", 0xd0909443),
+	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS4GCF120", 0x709b1bf1, 0xf54a91c8),
 	PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),
 	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
 	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),


-- 
JID: hrw-jabber.org
Sharp Zaurus C-760 (OZ 3.5.x)
OpenEmbedded/OpenZaurus/OPIE developer
