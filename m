Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVCNJmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVCNJmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVCNJiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:38:14 -0500
Received: from ozlabs.org ([203.10.76.45]:25738 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262088AbVCNJes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:34:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16949.23273.612040.768216@cargo.ozlabs.ibm.com>
Date: Mon, 14 Mar 2005 20:35:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: domen@coderock.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 delete unused file iSeries_fixup.h
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Domen Puncer <domen@coderock.org>.

Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -L include/asm-ppc64/iSeries/iSeries_fixup.h -puN include/asm-ppc64/iSeries/iSeries_fixup.h~remove_file-include_asm_ppc64_iSeries_iSeries_fixup.h /dev/null
--- kj/include/asm-ppc64/iSeries/iSeries_fixup.h
+++ /dev/null	2005-03-02 11:34:59.000000000 +0100
@@ -1,25 +0,0 @@
-
-#ifndef	__ISERIES_FIXUP_H__
-#define	__ISERIES_FIXUP_H__
-#include <linux/pci.h>
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-void iSeries_fixup (void);
-void iSeries_fixup_bus (struct pci_bus*);
-unsigned int iSeries_scan_slot (struct pci_dev*, u16, u8, u8);
-
-
-/* Need to store information related to the PHB bucc and make it accessible to the hose */
-struct iSeries_hose_arch_data {
-	u32 hvBusNumber;
-};
-
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __ISERIES_FIXUP_H__ */
