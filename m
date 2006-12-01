Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936517AbWLAP0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936517AbWLAP0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936518AbWLAP0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:26:53 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:50439 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936520AbWLAP0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:26:52 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] mips64 klconfig parenthesis fix
Date: Fri, 1 Dec 2006 16:26:27 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011626.27490.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes parenthesis stuff in PTR_CH_MALLOC_HDR() macro code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-mips64/sn/klconfig.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/include/asm-mips64/sn/klconfig.h	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.34-pre6-b/include/asm-mips64/sn/klconfig.h	2006-12-01 12:01:25.000000000 +0100
@@ -196,7 +196,7 @@ typedef struct kl_config_hdr {
 			((__psunsigned_t)_k + (_k->ch_malloc_hdr_off)))
 #else
 #define PTR_CH_MALLOC_HDR(_k)   ((klc_malloc_hdr_t *)\
-			(unsigned long)_k + (_k->ch_malloc_hdr_off)))
+			((unsigned long)_k + (_k->ch_malloc_hdr_off)))
 #endif
 
 #define KL_CONFIG_CH_MALLOC_HDR(_n)   PTR_CH_MALLOC_HDR(KL_CONFIG_HDR(_n))


-- 
Regards,

	Mariusz Kozlowski
