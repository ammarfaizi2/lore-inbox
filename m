Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271468AbTGQQcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271383AbTGQQ04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:26:56 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:59046 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S271340AbTGQQ0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:26:07 -0400
Date: Thu, 17 Jul 2003 18:39:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (6/6): siginfo_t for s390x.
Message-ID: <20030717163955.GG2045@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct size of siginfo_t for s390x (from 136 to 128).

diffstat:
 include/asm-s390/siginfo.h |    3 +++
 1 files changed, 3 insertions(+)

diff -urN linux-2.6.0-test1/include/asm-s390/siginfo.h linux-2.6.0-s390/include/asm-s390/siginfo.h
--- linux-2.6.0-test1/include/asm-s390/siginfo.h	Mon Jul 14 05:37:33 2003
+++ linux-2.6.0-s390/include/asm-s390/siginfo.h	Thu Jul 17 17:27:34 2003
@@ -10,6 +10,9 @@
 #define _S390_SIGINFO_H
 
 #define HAVE_ARCH_SI_CODES
+#ifdef __s390x__
+#define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
+#endif
 
 #include <asm-generic/siginfo.h>
 
