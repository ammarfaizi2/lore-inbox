Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUH3WDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUH3WDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUH3WDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:03:10 -0400
Received: from illuminari.org ([65.192.43.17]:50387 "EHLO illuminari.org")
	by vger.kernel.org with ESMTP id S263784AbUH3WDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:03:05 -0400
Date: Mon, 30 Aug 2004 18:02:30 -0400 (EDT)
From: Chris Lalancette <clalancette@illuminari.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] identifier string for P4 Prescott
Message-ID: <Pine.LNX.4.60.0408301749270.452@illuminari.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch to change the identifier in the kernel from "Unknown CPU 
[15:3]" to "Pentium 4(tm) Prescott".  Although Prescott is not the 
official name of the chip (I think Intel just decided to go with the 
P4 name), I do think it is useful to be able to identify this chip 
separately (given that it has a different core).  This is a patch against 
2.4.27

(NOTE: please CC me on any correspondence; I am not subscribed to the 
list)

--- linux-2.4.27/arch/i386/kernel/mpparse.c     2004-08-07 
19:26:04.000000000 -0400
+++ linux-2.4.27-crl/arch/i386/kernel/mpparse.c 2004-08-30 
17:01:20.000000000 -0400
@@ -137,6 +137,8 @@
                                 return("Pentium 4(tm)");
                         if (model == 0x02)
                                 return("Pentium 4(tm) XEON(tm)");
+                       if (model == 0x03)
+                               return("Pentium 4(tm) Prescott");
                         if (model == 0x0F)
                                 return("Special controller");
         }

