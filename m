Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbTFWStj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266098AbTFWStj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:49:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53489 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266097AbTFWStf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:49:35 -0400
Date: Mon, 23 Jun 2003 21:03:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] postfix a constant in efi.h with ULL
Message-ID: <20030623190335.GJ3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below postfixes a constant in efi.h with ULL, on 32 bit archs 
this constant is too big for an int.

cu
Adrian

--- linux-2.5.73-not-full/fs/partitions/efi.h.old	2003-06-23 21:01:29.000000000 +0200
+++ linux-2.5.73-not-full/fs/partitions/efi.h	2003-06-23 21:01:42.000000000 +0200
@@ -40,7 +40,7 @@
 #define EFI_PMBR_OSTYPE_EFI_GPT 0xEE
 
 #define GPT_BLOCK_SIZE 512
-#define GPT_HEADER_SIGNATURE 0x5452415020494645L
+#define GPT_HEADER_SIGNATURE 0x5452415020494645ULL
 #define GPT_HEADER_REVISION_V1 0x00010000
 #define GPT_PRIMARY_PARTITION_TABLE_LBA 1
 
