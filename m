Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279377AbRJWLVm>; Tue, 23 Oct 2001 07:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279374AbRJWLVc>; Tue, 23 Oct 2001 07:21:32 -0400
Received: from hermes.domdv.de ([193.102.202.1]:17924 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S279375AbRJWLVY>;
	Tue, 23 Oct 2001 07:21:24 -0400
Message-ID: <XFMail.20011023132048.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.6-3.Linux:20011023130436:5243=_"
Date: Tue, 23 Oct 2001 13:20:48 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ext2 module build failure (2.4.13pre6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.6-3.Linux:20011023130436:5243=_
Content-Type: text/plain; charset=us-ascii

ext2 build as a module fails to missing export of generic_direct_IO which the
attached patch fixes.

<grumble>
posted this at 2.4.13pre2 time, now we're up to pre6 and nobody cares...
</grumble>

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--_=XFMail.1.4.6-3.Linux:20011023130436:5243=_
Content-Disposition: attachment; filename="ksyms.patch"
Content-Transfer-Encoding: 7bit
Content-Description: ksyms.patch
Content-Type: text/plain; charset=us-ascii; name=ksyms.patch; SizeOnDisk=375

--- linux/kernel/ksyms.c	Tue Oct 23 12:58:28 2001
+++ linux-fixed/kernel/ksyms.c	Tue Oct 23 12:55:02 2001
@@ -205,6 +205,7 @@
 EXPORT_SYMBOL(block_sync_page);
 EXPORT_SYMBOL(cont_prepare_write);
 EXPORT_SYMBOL(generic_commit_write);
+EXPORT_SYMBOL(generic_direct_IO);
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(generic_block_bmap);
 EXPORT_SYMBOL(waitfor_one_page);

--_=XFMail.1.4.6-3.Linux:20011023130436:5243=_--
End of MIME message
