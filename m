Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318205AbSIEVwY>; Thu, 5 Sep 2002 17:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSIEVv5>; Thu, 5 Sep 2002 17:51:57 -0400
Received: from hermes.domdv.de ([193.102.202.1]:37897 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318169AbSIEVvG>;
	Thu, 5 Sep 2002 17:51:06 -0400
Message-ID: <3D77C2D2.5090607@domdv.de>
Date: Thu, 05 Sep 2002 22:47:14 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20pre5 trivial compiler warning fix for nmclan_cs.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080408070907090002090501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080408070907090002090501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

the attached patch disables dead code in nmclan_cs.c and thus fixes a 
compiler warning.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------080408070907090002090501
Content-Type: text/plain;
 name="nmclan_cs.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmclan_cs.c.diff"

--- drivers/net/pcmcia/nmclan_cs.c.orig	2002-09-05 22:43:00.000000000 +0200
+++ drivers/net/pcmcia/nmclan_cs.c	2002-09-05 22:44:21.000000000 +0200
@@ -1009,6 +1009,7 @@
   return 0;
 } /* mace_close */
 
+#if 0
 static int netdev_ethtool_ioctl (struct net_device *dev, void *useraddr)
 {
 	u32 ethcmd;
@@ -1068,6 +1069,7 @@
 	}
 	return 0;
 }
+#endif
 
 /* ----------------------------------------------------------------------------
 mace_start_xmit

--------------080408070907090002090501--


