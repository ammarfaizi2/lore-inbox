Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTDHNBj (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 09:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTDHNBi (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 09:01:38 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:25047 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261362AbTDHNBh (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 09:01:37 -0400
Message-Id: <200304081312.h38DCFGi018652@locutus.cmf.nrl.navy.mil>
To: davem@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][ATM] ia64 doesn't know about atm drivers on 2.4 kernels
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Tue, 08 Apr 2003 09:12:15 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the ia64 arch doesnt seem to know about the atm drivers.  please apply this
to the 2.4 series.

Index: linux/arch/ia64/config.in
===================================================================
RCS file: /home/chas/2.4/CVSROOT/linux/arch/ia64/config.in,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 config.in
--- linux/arch/ia64/config.in	19 Mar 2003 19:05:52 -0000	1.1.1.1
+++ linux/arch/ia64/config.in	8 Apr 2003 13:08:10 -0000
@@ -185,6 +185,9 @@
     bool 'Network device support' CONFIG_NETDEVICES
     if [ "$CONFIG_NETDEVICES" = "y" ]; then
       source drivers/net/Config.in
+      if [ "$CONFIG_ATM" = "y" ]; then
+         source drivers/atm/Config.in
+      fi
     fi
     endmenu
   fi
