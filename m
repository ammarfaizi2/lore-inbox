Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUGNLlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUGNLlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 07:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267214AbUGNLlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 07:41:51 -0400
Received: from gprs214-9.eurotel.cz ([160.218.214.9]:28032 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265974AbUGNLlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 07:41:49 -0400
Date: Wed, 14 Jul 2004 13:41:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: netdev@oss.sgi.com, kernel list <linux-kernel@vger.kernel.org>
Subject: ipw2100 wireless driver
Message-ID: <20040714114135.GA25175@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What is the status of ipw2100? Is there chance that it would be pushed
into mainline?

I have few problems with that:

* it will not compile with gcc-2.95. Attached patch fixes one problem
but more remain.

--- ipw2100-ofic/ieee80211.h	2004-07-09 06:32:17.000000000 +0200
+++ ipw2100-0.49/ieee80211.h	2004-07-14 13:18:50.000000000 +0200
@@ -440,7 +440,7 @@
 	u16 reserved;
 	u16 frag_size;
 	u16 payload_size;
-	struct sk_buff *fragments[];
+	struct sk_buff *fragments[1];
 };
 
 extern struct ieee80211_txb *ieee80211_skb_to_txb(struct ieee80211_device *ieee, 

* it requires CONFIG_CRYPTO, but fails to force it in Kconfig.

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
