Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWELPIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWELPIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWELPIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:08:24 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:39569
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932113AbWELPIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:08:23 -0400
Subject: [PATCH] remove dead entry in net wan Kconfig
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 12 May 2006 10:08:14 -0500
Message-Id: <1147446494.10079.5.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead entry from net wan Kconfig.
This entry is left over from 2.4 where synclink
used syncppp driver directly. synclink drivers
now use generic HDLC

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.16/drivers/net/wan/Kconfig	2006-03-19 23:53:29.000000000 -0600
+++ b/drivers/net/wan/Kconfig	2006-05-12 09:17:03.000000000 -0500
@@ -134,18 +134,6 @@
 	  The driver will be compiled as a module: the
 	  module will be called sealevel.
 
-config SYNCLINK_SYNCPPP
-	tristate "SyncLink HDLC/SYNCPPP support"
-	depends on WAN
-	help
-	  Enables HDLC/SYNCPPP support for the SyncLink WAN driver.
-
-	  Normally the SyncLink WAN driver works with the main PPP driver
-	  <file:drivers/net/ppp_generic.c> and pppd program.
-	  HDLC/SYNCPPP support allows use of the Cisco HDLC/PPP driver
-	  <file:drivers/net/wan/syncppp.c>. The SyncLink WAN driver (in
-	  character devices) must also be enabled.
-
 # Generic HDLC
 config HDLC
 	tristate "Generic HDLC layer"


