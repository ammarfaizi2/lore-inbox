Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWHJTWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWHJTWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWHJTWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:22:45 -0400
Received: from mail.linicks.net ([217.204.244.146]:4533 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750896AbWHJTWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:22:44 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Real Time Clock help
Date: Thu, 10 Aug 2006 20:22:41 +0100
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Be42Eq2rem4A5JB"
Message-Id: <200608102022.41122.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Be42Eq2rem4A5JB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

A 'nanny patch' to stop probable confusion over the two RTC options.  I needed 
access to /dev/rtc and not knowing where the option was in menuconfig, I 
selected the wrong one first.  I was confused on the help of the this RTC, 
but it didn't cross my mind once there was another RTC 'option' available, 
and so wasted a build and reboot only to see it was wrong.

Hopefully this will aid to stop that confusion.

Nick
-- 
Every program has two purposes:
one for which it was written and another for which it wasn't.

--Boundary-00=_Be42Eq2rem4A5JB
Content-Type: text/x-diff;
  charset="utf-8";
  name="rtchelp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rtchelp.patch"

--- drivers/rtc/Kconfig.orig	2006-08-10 20:08:23.000000000 +0100
+++ drivers/rtc/Kconfig	2006-08-10 20:13:01.000000000 +0100
@@ -13,6 +13,11 @@
 	default n
 	select RTC_LIB
 	help
+	  Note! If you wish to only enable access to Real Time Clock
+	  (or hardware clock) /dev/rtc, this is to be found under
+	  the option in Device Drivers->Character Devices called
+	  'Enhanced Real Time Clock Support'.
+
 	  Generic RTC class support. If you say yes here, you will
  	  be allowed to plug one or more RTCs to your system. You will
 	  probably want to enable one of more of the interfaces below.

--Boundary-00=_Be42Eq2rem4A5JB--
