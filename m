Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbULYRCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbULYRCU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 12:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbULYRCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 12:02:19 -0500
Received: from omega.datac.cz ([81.31.15.4]:64232 "EHLO omega.datac.cz")
	by vger.kernel.org with ESMTP id S261277AbULYRCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 12:02:13 -0500
Message-ID: <41CD9D00.4090505@feix.cz>
Date: Sat, 25 Dec 2004 18:01:52 +0100
From: Michal Feix <michal@feix.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] FW_LOADER required in Kconfig for certain DVB frontend modules
Content-Type: multipart/mixed;
 boundary="------------030905000409020704070000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030905000409020704070000
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

I would have sent this to DVB maintener, if linuxtv.org wasn't down for the 
whole day and their SMTP wouldn't reject all emails for linuxtv.org domain. :((

Due to a change between 2.6.9 and 2.6.10 in certain DVB frontend modules, 
it is now required to have "Hotplug firmware loading support" selected in 
Kernel configuration (FW_LOADER in .config file).

-- 
Michal Feix
michal@feix.cz


--------------030905000409020704070000
Content-Type: text/plain;
 name="dvb-fwloader.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb-fwloader.patch"

diff -ur a/drivers/media/dvb/frontends/Kconfig b/drivers/media/dvb/frontends/Kconfig
--- a/drivers/media/dvb/frontends/Kconfig	Sat Dec 25 12:16:31 2004
+++ b/drivers/media/dvb/frontends/Kconfig	Sat Dec 25 14:12:36 2004
@@ -46,6 +46,7 @@
 config DVB_SP8870
  	tristate "Spase sp8870 based"
 	depends on DVB_CORE
+	select FW_LOADER
 	help
  	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
@@ -56,6 +57,7 @@
 config DVB_SP887X
  	tristate "Spase sp887x based"
 	depends on DVB_CORE
+	select FW_LOADER
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
@@ -84,6 +86,7 @@
 config DVB_TDA1004X
 	tristate "Philips TDA10045H/TDA10046H based"
 	depends on DVB_CORE
+	select FW_LOADER
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 


--------------030905000409020704070000--
