Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWBQFGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWBQFGI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 00:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWBQFGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 00:06:07 -0500
Received: from [203.2.177.25] ([203.2.177.25]:40222 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S932276AbWBQFGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 00:06:05 -0500
Subject: [PATCH 6/6]x25:dte facilities 32 64 ioctl conversion
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: "David S. Miller" <davem@davemloft.net>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Andre Hendry <ahendry@tusc.com.au>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 16:02:55 +1100
Message-Id: <1140152575.1475.27.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: spereira@tusc.com.au

Allows dte facility patch to use 32 64 bit ioctl
conversion mechanism

Signed-off-by:Shaun Pereira <spereira@tusc.com.au>
---
diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/x25/af_x25.c linux-2.6.16-rc3/net/x25/af_x25.c
--- linux-2.6.16-rc3-vanilla/net/x25/af_x25.c	2006-02-16 15:33:48.000000000 +1100
+++ linux-2.6.16-rc3/net/x25/af_x25.c	2006-02-16 15:34:05.000000000 +1100
@@ -1529,6 +1529,8 @@ static int compat_x25_ioctl(struct socke
 			break;
 		case SIOCX25GFACILITIES:
 		case SIOCX25SFACILITIES:
+		case SIOCX25GDTEFACILITIES:
+		case SIOCX25SDTEFACILITIES:
 		case SIOCX25GCALLUSERDATA:
 		case SIOCX25SCALLUSERDATA:
 		case SIOCX25GCAUSEDIAG:

