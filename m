Return-Path: <linux-kernel-owner+w=401wt.eu-S1751019AbXAPLqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXAPLqx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 06:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbXAPLqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 06:46:53 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:52827 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXAPLqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 06:46:53 -0500
X-Originating-Ip: 74.109.98.130
Date: Tue, 16 Jan 2007 06:37:31 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: acme@conectiva.com.br
Subject: [PATCH] Remove apparently unused IPDDP_DECAP kernel config variable.
Message-ID: <Pine.LNX.4.64.0701160633150.18375@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove an apparently unused, Appletalk-related kernel config
variable IPDDP_DECAP.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  the kernel config variable IPDDP_DECAP seems superfluous given where
else one finds the string "IPDDP_DECAP" in the kernel source tree
(other than defconfig files), none of which seem to make use of the
config variable:

./drivers/net/appletalk/ipddp.h:#define IPDDP_DECAP     2
./drivers/net/appletalk/ipddp.c:static int ipddp_mode = IPDDP_DECAP;
./drivers/net/appletalk/ipddp.c:        if(ipddp_mode == IPDDP_DECAP)
./drivers/net/appletalk/ipddp.c:        if(ipddp_mode == IPDDP_DECAP)



diff --git a/drivers/net/appletalk/Kconfig b/drivers/net/appletalk/Kconfig
index 0a0e0cd..e09174f 100644
--- a/drivers/net/appletalk/Kconfig
+++ b/drivers/net/appletalk/Kconfig
@@ -110,16 +110,3 @@ config IPDDP_ENCAP
 	  you said Y to "AppleTalk-IP driver support" above and you say Y
 	  here, then you cannot say Y to "AppleTalk-IP to IP Decapsulation
 	  support", below.
-
-config IPDDP_DECAP
-	bool "Appletalk-IP to IP Decapsulation support"
-	depends on IPDDP
-	help
-	  If you say Y here, the AppleTalk-IP code will be able to decapsulate
-	  AppleTalk-IP frames to IP packets; this is useful if you want your
-	  Linux box to act as an Internet gateway for an AppleTalk network.
-	  Please see <file:Documentation/networking/ipddp.txt> for more
-	  information.  If you said Y to "AppleTalk-IP driver support" above
-	  and you say Y here, then you cannot say Y to "IP to AppleTalk-IP
-	  Encapsulation support", above.
-
