Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWAFAqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWAFAqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWAFAqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:46:31 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:28803 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932359AbWAFAqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:46:30 -0500
Date: Thu, 5 Jan 2006 16:45:26 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Adrian Bunk <bunk@stusta.de>, Jeff Garzik <jgarzik@pobox.com>,
       Olaf Hering <olh@suse.de>
Subject: [PATCH 2/6] ieee80211_crypt_tkip depends on NET_RADIO
Message-ID: <20060106004526.GB25207@sorel.sous-sol.org>
References: <20060105235845.967478000@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ieee80211_crypt_tkip-depends-on-net_radio.patch"
In-Reply-To: <20060105235947.100933000@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

*** Warning: ".wireless_send_event" [net/ieee80211/ieee80211_crypt_tkip.ko]

This bug was also reported as kerenl Bugzilla #5551.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ieee80211/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.5.orig/net/ieee80211/Kconfig
+++ linux-2.6.14.5/net/ieee80211/Kconfig
@@ -55,7 +55,7 @@ config IEEE80211_CRYPT_CCMP
 
 config IEEE80211_CRYPT_TKIP
 	tristate "IEEE 802.11i TKIP encryption"
-	depends on IEEE80211
+	depends on IEEE80211 && NET_RADIO
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
 	---help---

--
