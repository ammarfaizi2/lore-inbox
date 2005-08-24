Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVHXP6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVHXP6J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVHXP6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:58:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32261 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751083AbVHXP6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:58:08 -0400
Date: Wed, 24 Aug 2005 17:58:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: wensong@linux-vs.org, ja@ssi.bg
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/net/ip_vs.h: "extern inline" -> "static inline"
Message-ID: <20050824155806.GF4851@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm2-full/include/net/ip_vs.h.old	2005-08-24 16:51:58.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/net/ip_vs.h	2005-08-24 16:51:38.000000000 +0200
@@ -958,7 +958,7 @@
  */
 #define IP_VS_FWD_METHOD(cp)  (cp->flags & IP_VS_CONN_F_FWD_MASK)
 
-extern __inline__ char ip_vs_fwd_tag(struct ip_vs_conn *cp)
+static inline char ip_vs_fwd_tag(struct ip_vs_conn *cp)
 {
 	char fwd;
 

