Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262725AbTCTW0B>; Thu, 20 Mar 2003 17:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbTCTWZk>; Thu, 20 Mar 2003 17:25:40 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:50561 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262684AbTCTWWb>; Thu, 20 Mar 2003 17:22:31 -0500
Date: Thu, 20 Mar 2003 23:33:29 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, acme@conectiva.com.br
Subject: [PATCH] clean up net/802/Makefile (small version)
Message-ID: <20030320223329.GB13641@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simply removes a couple of lines with duplicated
functionality. Patch is against 2.4.20.

Arnaldo, are you the correct maintainer for this?

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu

--- linux-2.4.20/net/802/Makefile	Sat Aug  3 02:39:46 2002
+++ linux-2.4.20/net/802/Makefile.1	Thu Mar 20 23:20:05 2003
@@ -15,13 +15,9 @@
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_802.o
 obj-$(CONFIG_LLC) += llc_sendpdu.o llc_utility.o cl2llc.o llc_macinit.o
-ifeq ($(CONFIG_SYSCTL),y)
-obj-y += sysctl_net_802.o
-endif
 
 ifeq ($(CONFIG_LLC),y)
 subdir-y += transit
-obj-y += llc_sendpdu.o llc_utility.o cl2llc.o llc_macinit.o
 SNAP = y
 endif
 
