Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVDFPyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVDFPyC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVDFPyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:54:02 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:8359 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262233AbVDFPxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:53:50 -0400
Subject: [PATCH] fix minor "defaults" issue in mm/Kconfig
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-4qanU5sHLIAcw2duyqQJ"
Date: Wed, 06 Apr 2005 08:53:43 -0700
Message-Id: <1112802823.19430.155.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4qanU5sHLIAcw2duyqQJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch applies on top of 2.6.12-rc2-mm1.  It fixes a minor
user interaction issue, and removes an early reference to SPARSEMEM.

Without this patch. the "choice" menu would always default to FLATMEM,
as it was listed first.  Move it to the end so that the other defaults
have a chance first.

-- Dave

--=-4qanU5sHLIAcw2duyqQJ
Content-Disposition: attachment; filename=A6.1-mm-Kconfig-defaults.patch
Content-Type: text/x-patch; name=A6.1-mm-Kconfig-defaults.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

The following patch applies on top of 2.6.12-rc2-mm1.  It fixes a
minor user interaction issue, and an early reference to SPARSEMEM.

This "choice" menu would always default to FLATMEM, as it was listed
first.  Move it to the end so that the other defaults have a chance
first.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

---

 memhotplug-dave/mm/Kconfig |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN mm/Kconfig~A6.1-mm-Kconfig-defaults mm/Kconfig
--- memhotplug/mm/Kconfig~A6.1-mm-Kconfig-defaults	2005-04-05 10:40:32.000000000 -0700
+++ memhotplug-dave/mm/Kconfig	2005-04-06 08:42:43.000000000 -0700
@@ -1,8 +1,7 @@
 choice
 	prompt "Memory model"
-	default FLATMEM
-	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
 	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
+	default FLATMEM
 
 config FLATMEM
 	bool "Flat Memory"
_

--=-4qanU5sHLIAcw2duyqQJ--

