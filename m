Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161271AbWF0UPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161271AbWF0UPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161276AbWF0UPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:15:07 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:20096 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161271AbWF0UPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:15:04 -0400
Message-Id: <20060627201216.289826000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:10 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 10/25] ETHTOOL: Fix UFO typo
Content-Disposition: inline; filename=ethtool-fix-ufo-typo.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

The function ethtool_get_ufo was referring to ETHTOOL_GTSO instead of
ETHTOOL_GUFO.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/core/ethtool.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.1.orig/net/core/ethtool.c
+++ linux-2.6.17.1/net/core/ethtool.c
@@ -591,7 +591,7 @@ static int ethtool_set_tso(struct net_de
 
 static int ethtool_get_ufo(struct net_device *dev, char __user *useraddr)
 {
-	struct ethtool_value edata = { ETHTOOL_GTSO };
+	struct ethtool_value edata = { ETHTOOL_GUFO };
 
 	if (!dev->ethtool_ops->get_ufo)
 		return -EOPNOTSUPP;
@@ -600,6 +600,7 @@ static int ethtool_get_ufo(struct net_de
 		 return -EFAULT;
 	return 0;
 }
+
 static int ethtool_set_ufo(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_value edata;

--
