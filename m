Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTGNNzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270675AbTGNNx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:53:26 -0400
Received: from mail.telpin.com.ar ([200.43.18.243]:30151 "EHLO
	mail.telpin.com.ar") by vger.kernel.org with ESMTP id S270620AbTGNNsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:48:25 -0400
Date: Mon, 14 Jul 2003 11:03:50 -0300
From: Alberto Bertogli <albertogli@telpin.com.ar>
To: netdev@oss.sgi.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IPVS' Kconfig LBLC and LBLCR configuration typo
Message-ID: <20030714140350.GB1389@telpin.com.ar>
Mail-Followup-To: Alberto Bertogli <albertogli@telpin.com.ar>,
	netdev@oss.sgi.com, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there!

The following patch fixes what looks like a typo in ipvs' Kconfig
(net/ipv4/ipvs/Kconfig).

Both the IP_VS_LBLC and IP_VS_LBLCR schedulings have the same tristate
line (well, not the same, IP_VS_LBLCR's has a 'g' missing at the end):

tristate "locality-based least-connection with replication scheduling"

But it looks like LBLC should be "locality-based least-connection
scheduling" and LBLCR "locality-based least-connection with replication
scheduling".


Thanks,
		Alberto


--- Kconfig.orig	2003-07-14 10:32:06.000000000 -0300
+++ Kconfig	2003-07-14 10:32:57.000000000 -0300
@@ -147,7 +147,7 @@
 	  unsure, say N.
 
 config	IP_VS_LBLC
-	tristate "locality-based least-connection with replication scheduling"
+	tristate "locality-based least-connection scheduling"
         depends on IP_VS
 	---help---
 	  The locality-based least-connection scheduling algorithm is for
@@ -163,7 +163,7 @@
 	  unsure, say N.
 
 config  IP_VS_LBLCR
-	tristate "locality-based least-connection with replication schedulin"
+	tristate "locality-based least-connection with replication scheduling"
         depends on IP_VS
 	---help---
 	  The locality-based least-connection with replication scheduling



