Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311244AbSDDHMs>; Thu, 4 Apr 2002 02:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311247AbSDDHM2>; Thu, 4 Apr 2002 02:12:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:8452 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311244AbSDDHM0>;
	Thu, 4 Apr 2002 02:12:26 -0500
Subject: Re: [PATCH] 2.5.8-pre1 wavelan_cs
From: Robert Love <rml@tech9.net>
To: flaniganr@intel.co.jp
Cc: linux-kernel@vger.kernel.org, jt@hpl.hp.com, dhinds@zen.stanford.edu
In-Reply-To: <87vgb8x8bt.fsf@hazuki.jp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 02:11:33 -0500
Message-Id: <1017904326.22304.458.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 01:54, flaniganr@intel.co.jp wrote:

> wavelan_cs.p.h:495:33: warning: extra tokens at end of #undef directive

Good ... and the attached patch will fix the warning wrt trailing tokens
after the undef.

	Robert Love

diff -urN linux-2.5.8-pre1/drivers/net/wireless/wavelan_cs.p.h linux/drivers/net/wireless/wavelan_cs.p.h
--- linux-2.5.8-pre1/drivers/net/wireless/wavelan_cs.p.h	Wed Apr  3 20:57:23 2002
+++ linux/drivers/net/wireless/wavelan_cs.p.h	Thu Apr  4 02:06:49 2002
@@ -492,7 +492,7 @@
 #undef DEBUG_RX_INFO		/* Header of the transmitted packet */
 #undef DEBUG_RX_FAIL		/* Normal failure conditions */
 #define DEBUG_RX_ERROR		/* Unexpected conditions */
-#undef DEBUG_PACKET_DUMP	32	/* Dump packet on the screen */
+#undef DEBUG_PACKET_DUMP	/* Dump packet on the screen */
 #undef DEBUG_IOCTL_TRACE	/* Misc call by Linux */
 #undef DEBUG_IOCTL_INFO		/* Various debug info */
 #define DEBUG_IOCTL_ERROR	/* What's going wrong */

