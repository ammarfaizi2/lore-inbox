Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWBPFuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWBPFuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 00:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWBPFuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 00:50:15 -0500
Received: from [203.2.177.25] ([203.2.177.25]:54807 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S932492AbWBPFuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 00:50:13 -0500
Subject: [PATCH 6/6] x25: Allow 32 bit socket ioctl in 64 bit kernel
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: linux-kenel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 16:48:01 +1100
Message-Id: <1140068881.4941.28.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

32 - 64 converstion for patch 5

Signed-off-by:Shaun Pereira <spereira@tusc.com.au>

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

