Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTGBMxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 08:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbTGBMxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 08:53:21 -0400
Received: from [212.209.10.216] ([212.209.10.216]:59796 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S264981AbTGBMxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 08:53:20 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <kaos@ocs.com.au>, <mec@shout.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow signed integers in kernelconfig
Date: Wed, 2 Jul 2003 15:07:19 +0200
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB03277A14@mailse01.axis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch makes it possible to have signed integers
for kernel configuration parameters (this was allowed before
2.4.21).

/Mikael

diff -u -ru linux/scripts/Configure linux_patch/scripts/Configure
--- linux/scripts/Configure	Fri Jun 13 16:51:39 2003
+++ linux_patch/scripts/Configure	Wed Jul  2 14:43:19 2003
@@ -350,7 +350,7 @@
 	def=${old:-$3}
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
-	  if expr "$ans" : '[0-9]*$' > /dev/null; then
+	  if expr "$ans" : '[+-]\?[0-9]*$' > /dev/null; then
             define_int "$2" "$ans"
 	    break
           else


