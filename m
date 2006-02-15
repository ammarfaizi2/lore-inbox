Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWBOW0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWBOW0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWBOW0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:26:37 -0500
Received: from [203.2.177.25] ([203.2.177.25]:21056 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1751342AbWBOW0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:26:35 -0500
Subject: [PATCH 6/6] x25: Allow 32 bit socket ioctl in 64 bit kernel
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: "David S. Miller" <davem@davemloft.net>,
       x25 maintainer <eis@baty.hanse.de>, netdev <netdev@vger.kernel.org>,
       linux-kenel <linux-kernel@vger.kernel.org>
Cc: Andre Hendry <ahendry@tusc.com.au>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 09:22:59 +1100
Message-Id: <1140042179.8745.31.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow patch 5 to use 32-64 bit conversion mechanism

Signed-off-by:Shaun Pereira <spereira@tusc.com.au>
 diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/x25/af_x25.c
linux-2.6.16-rc3/net/x25/af_x25.c
--- linux-2.6.16-rc3-vanilla/net/x25/af_x25.c	2006-02-15
11:17:03.000000000 +1100
+++ linux-2.6.16-rc3/net/x25/af_x25.c	2006-02-15 11:17:20.000000000
+1100
@@ -1529,6 +1529,8 @@ static int compat_x25_ioctl(struct socke
 			break;
 		case SIOCX25GFACILITIES:
 		case SIOCX25SFACILITIES:
+		case SIOCX25GDTEFACILITIES:
+		case SIOCX25SDTEFACILITIES:
 		case SIOCX25GCALLUSERDATA:
 		case SIOCX25SCALLUSERDATA:
 		case SIOCX25GCAUSEDIAG:

