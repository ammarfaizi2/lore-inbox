Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUE3Rvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUE3Rvu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbUE3Rvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:51:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14752 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264278AbUE3Rvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:51:48 -0400
Message-ID: <40BA1F25.4080402@pobox.com>
Date: Sun, 30 May 2004 13:51:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bunk@fs.tum.de, linux-kernel@vger.kernel.org
CC: "Randy.Dunlap" <rddunlap@osdl.org>, Danny ter Haar <dth@dth.net>,
       wa1ter@myrealbox.com, dth@ncc1701.cistron.net,
       Netdev <netdev@oss.sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Re: Gigabit Kconfig problems with yesterday's update
References: <40B8A37D.1090802@myrealbox.com>	<20040530134544.GE13111@fs.tum.de>	<20040530143734.GA24627@dth.net> <20040530094120.61b22d2e.rddunlap@osdl.org>
In-Reply-To: <20040530094120.61b22d2e.rddunlap@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000106000903050204030600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000106000903050204030600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

NET_GIGE is rightly dependent on NET_ETHERNET, as it is a subset.

I wonder if the attached patch "fixes" peoples config problems :)

--------------000106000903050204030600
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/net/Kconfig 1.74 vs edited =====
--- 1.74/drivers/net/Kconfig	2004-05-27 16:42:40 -04:00
+++ edited/drivers/net/Kconfig	2004-05-30 13:49:48 -04:00
@@ -163,7 +163,7 @@
 	depends on NETDEVICES
 
 config NET_ETHERNET
-	bool "Ethernet (10 or 100Mbit)"
+	bool "Ethernet (10/100/1000/10000 Mbit)"
 	---help---
 	  Ethernet (also called IEEE 802.3 or ISO 8802-2) is the most common
 	  type of Local Area Network (LAN) in universities and companies.

--------------000106000903050204030600--
