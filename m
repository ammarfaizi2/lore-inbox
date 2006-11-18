Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754308AbWKRKZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbWKRKZI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 05:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbWKRKZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 05:25:07 -0500
Received: from holoclan.de ([62.75.158.126]:5606 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1754308AbWKRKZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 05:25:04 -0500
Date: Sat, 18 Nov 2006 11:20:56 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
To: jketreno@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: IEEE80211 and IPW3945
Message-ID: <20061118102056.GA4492@gimli>
Mail-Followup-To: jketreno@linux.intel.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Dear James, I just had some issues when trying to
	compile ieee80211 1.2.15 together with ipw3945 1.1.2 on the latest
	kernel tree attached are two patches I had to create to work around it I
	guess they are self-explanatory :-) [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear James,

I just had some issues when trying to compile ieee80211 1.2.15 together with
ipw3945 1.1.2 on the latest kernel tree

attached are two patches I had to create to work around it
I guess they are self-explanatory :-)

greets
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ieee_api_define.patch"

diff --git a/include/net/ieee80211.h b/include/net/ieee80211.h
index ee66681..b0d1ca3 100644
--- a/include/net/ieee80211.h
+++ b/include/net/ieee80211.h
@@ -30,8 +30,11 @@
 #include <linux/wireless.h>
 
 #define IEEE80211_VERSION_MAJOR 1
+#define IEEE80211_MAJOR_VERSION IEEE80211_VERSION_MAJOR
 #define IEEE80211_VERSION_API 2
+#define IEEE80211_API_VERSION IEEE80211_VERSION_API
 #define IEEE80211_VERSION_MINOR 15
+#define IEEE80211_MINOR_VERSION IEEE80211_VERSION_MINOR
 #define IEEE80211_VERSION_CODE IEEE80211_VERSION_MAJOR * 65536 + \
 			       IEEE80211_VERSION_API * 256 + \
 			       IEEE80211_VERSION_MINOR

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config_h.patch"

diff --git a/include/linux/config.h b/include/linux/config.h
new file mode 100644
index 0000000..a91f5e5
--- /dev/null
+++ b/include/linux/config.h
@@ -0,0 +1,8 @@
+#ifndef _LINUX_CONFIG_H
+#define _LINUX_CONFIG_H
+/* This file is no longer in use and kept only for backward compatibility.
+ * autoconf.h is now included via -imacros on the commandline
+ */
+#include <linux/autoconf.h>
+
+#endif

--IS0zKkzwUGydFO0o--
