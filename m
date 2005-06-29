Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVF2FSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVF2FSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 01:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVF2FSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 01:18:02 -0400
Received: from havoc.gtf.org ([69.61.125.42]:38283 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262412AbVF2FRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 01:17:55 -0400
Date: Wed, 29 Jun 2005 01:17:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] ieee80211.h build fix
Message-ID: <20050629051755.GA1061@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This crept in with the resync-to-mainline.  Nothing uses 802.11-crypt in
mainline, so we can safely comment it out for now.

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>


diff --git a/include/net/ieee80211.h b/include/net/ieee80211.h
--- a/include/net/ieee80211.h
+++ b/include/net/ieee80211.h
@@ -426,7 +426,9 @@ struct ieee80211_stats {
 
 struct ieee80211_device;
 
+#if 0 /* for later */
 #include "ieee80211_crypt.h"
+#endif
 
 #define SEC_KEY_1         (1<<0)
 #define SEC_KEY_2         (1<<1)
