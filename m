Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWIFXDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWIFXDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWIFXDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:03:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:35789 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965157AbWIFXDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:13 -0400
Date: Wed, 6 Sep 2006 15:57:36 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 28/37] Missing PCI id update for VIA IDE
Message-ID: <20060906225736.GC15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="missing-pci-id-update-for-via-ide.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Alan Cox <alan@lxorguk.ukuu.org.uk>


The following change from -mm is important to 2.6.18 (actually to 2.6.17
but its too late for that). This was contributed over three months ago
by VIA to Bartlomiej and nothing happened. As a result the new chipset
is now out and Linux won't run on it. By the time 2.6.18 is finalised
this will be the defacto standard VIA chipset so support would be a good
plan.

Tested in -mm for a while, its essentially a PCI ident update but for
the bridge chip because VIA do things in weird ways.


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/ide/pci/via82cxxx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.11.orig/drivers/ide/pci/via82cxxx.c
+++ linux-2.6.17.11/drivers/ide/pci/via82cxxx.c
@@ -6,7 +6,7 @@
  *
  *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
  *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233, vt8233c, vt8233a,
- *   vt8235, vt8237
+ *   vt8235, vt8237, vt8237a
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -82,6 +82,7 @@ static struct via_isa_bridge {
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },

--
