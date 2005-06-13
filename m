Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVFMS6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVFMS6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVFMS6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:58:18 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:63636 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261209AbVFMS4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:56:50 -0400
Date: Mon, 13 Jun 2005 11:56:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.12-rc6] <linux/if_tr.h> needs <asm/byteorder.h>
Message-ID: <20050613185649.GA29200@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/if_tr.h> uses __be16, but does not directly include
<asm/byteorder.h>.  Add this in, so that dhcp/net-tools token ring code
can compile again.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff --git a/include/linux/if_tr.h b/include/linux/if_tr.h
--- a/include/linux/if_tr.h
+++ b/include/linux/if_tr.h
@@ -19,6 +19,8 @@
 #ifndef _LINUX_IF_TR_H
 #define _LINUX_IF_TR_H
 
+#include <asm/byteorder.h>	/* For __be16 */
+
 /* IEEE 802.5 Token-Ring magic constants.  The frame sizes omit the preamble
    and FCS/CRC (frame check sequence). */
 #define TR_ALEN		6		/* Octets in one token-ring addr */

-- 
Tom Rini
http://gate.crashing.org/~trini/
