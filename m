Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbUBYJxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 04:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUBYJxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 04:53:52 -0500
Received: from holomorphy.com ([199.26.172.102]:22545 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262582AbUBYJxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 04:53:51 -0500
Date: Wed, 25 Feb 2004 01:53:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org
Subject: PRD_ENTRIES is 256
Message-ID: <20040225095317.GJ693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PRD_ENTRIES is specified to be precisely 256; on platforms where
PAGE_SIZE varies from 4KB the calculation in the current expression
defining it is inaccurate, which may cause crashes. This patch changes
it to the constant literal 256.


-- wli


===== include/linux/ide.h 1.88 vs edited =====
--- 1.88/include/linux/ide.h	Tue Feb 10 07:35:39 2004
+++ edited/include/linux/ide.h	Wed Feb 25 01:46:45 2004
@@ -224,7 +224,7 @@
  * allowing each to have about 256 entries (8 bytes each) from this.
  */
 #define PRD_BYTES       8
-#define PRD_ENTRIES     (PAGE_SIZE / (2 * PRD_BYTES))
+#define PRD_ENTRIES     256
 
 /*
  * Some more useful definitions
