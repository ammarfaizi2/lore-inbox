Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318191AbSIEVwX>; Thu, 5 Sep 2002 17:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSIEVwD>; Thu, 5 Sep 2002 17:52:03 -0400
Received: from hermes.domdv.de ([193.102.202.1]:38153 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318191AbSIEVvM>;
	Thu, 5 Sep 2002 17:51:12 -0400
Message-ID: <3D77C116.9010808@domdv.de>
Date: Thu, 05 Sep 2002 22:39:50 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20pre5 trivial compiler warning fix for fmvj18x_cs.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070003030904080009030905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070003030904080009030905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

the attached patch fixes a multi line string literal warning for 
fmvj18x_cs.c.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------070003030904080009030905
Content-Type: text/plain;
 name="fmvj18x_cs.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fmvj18x_cs.c.diff"

--- drivers/net/pcmcia/fmvj18x_cs.c.orig	2002-09-05 22:36:18.000000000 +0200
+++ drivers/net/pcmcia/fmvj18x_cs.c	2002-09-05 22:36:30.000000000 +0200
@@ -571,8 +571,8 @@
     case XXX10304:
 	/* Read MACID from Buggy CIS */
 	if (fmvj18x_get_hwinfo(link, tuple.TupleData) == -1) {
-	    printk(KERN_NOTICE "fmvj18x_cs: unable to read hardware net 
-		address.");
+	    printk(KERN_NOTICE "fmvj18x_cs: unable to read hardware net "
+		"address.");
 	    unregister_netdev(dev);
 	    goto failed;
 	}

--------------070003030904080009030905--


