Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263034AbVCEG0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbVCEG0C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbVCEGUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:20:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:23436 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263024AbVCEGKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:10:43 -0500
Date: Fri, 4 Mar 2005 21:56:55 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-sound@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: [PATCH] oss/nm256: fix section references
Message-Id: <20050304215655.0987a017.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oss/nm256_audio: fix init text section reference:

Error: ./sound/oss/nm256_audio.o .text refers to 0000000000001847 R_X86_64_PC32     .init.text+0x0000000000000018

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/nm256_audio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./sound/oss/nm256_audio.c~oss_nm256_sections ./sound/oss/nm256_audio.c
--- ./sound/oss/nm256_audio.c~oss_nm256_sections	2005-03-01 23:38:08.000000000 -0800
+++ ./sound/oss/nm256_audio.c	2005-03-04 21:25:20.000000000 -0800
@@ -1047,7 +1047,7 @@ nm256_peek_for_sig (struct nm256_info *c
  * VERSTR is a human-readable version string.
  */
 
-static int __init
+static int __devinit
 nm256_install(struct pci_dev *pcidev, enum nm256rev rev, char *verstr)
 {
     struct nm256_info *card;


---
