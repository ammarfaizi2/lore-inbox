Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266414AbUBQS1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 13:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266420AbUBQS1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 13:27:46 -0500
Received: from pD9FFB3B4.dip.t-dialin.net ([217.255.179.180]:8592 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S266414AbUBQS1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 13:27:44 -0500
Date: Tue, 17 Feb 2004 19:27:27 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (2.4 BK) Fix syntax errors in net/sctp/Config.in 
Message-ID: <20040217182726.GA24795@oscar.prima.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there are three small syntax errors in net/sctp/Config.in in
the current linux 2.4 BK tree. The patch to fix them is below.

Please apply from within ./net/sctp ...

Thanks,
Patrick

--- Config.in.orig	2004-02-16 20:42:50.000000000 +0100
+++ Config.in	2004-02-16 20:43:23.000000000 +0100
@@ -15,15 +15,15 @@
    bool '    SCTP: Debug messages' CONFIG_SCTP_DBG_MSG
    bool '    SCTP: Debug object counts' CONFIG_SCTP_DBG_OBJCNT
 fi
-if [ "$CONFIG_CRYPTO_HMAC" = "n"]; then
+if [ "$CONFIG_CRYPTO_HMAC" = "n" ]; then
   choice 'SCTP: Cookie HMAC Algorithm' \
         "HMAC-NONE		CONFIG_SCTP_HMAC_NONE" HMAC-NONE
 else
-  if [ "$CONFIG_CRYPTO_MD5" = "n" -a "$CONFIG_CRYPTO_SHA1" = "n"]; then
+  if [ "$CONFIG_CRYPTO_MD5" = "n" -a "$CONFIG_CRYPTO_SHA1" = "n" ]; then
     choice 'SCTP: Cookie HMAC Algorithm' \
         "HMAC-NONE		CONFIG_SCTP_HMAC_NONE" HMAC-NONE
   else
-    if [ "$CONFIG_CRYPTO_MD5" != "n" -a "$CONFIG_CRYPTO_SHA1" != "n"]; then
+    if [ "$CONFIG_CRYPTO_MD5" != "n" -a "$CONFIG_CRYPTO_SHA1" != "n" ]; then
       choice 'SCTP: Cookie HMAC Algorithm' \
         "HMAC-NONE		CONFIG_SCTP_HMAC_NONE \
          HMAC-SHA1              CONFIG_SCTP_HMAC_SHA1 \
