Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275535AbTHNV3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 17:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275539AbTHNV3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 17:29:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46590 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275535AbTHNV3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 17:29:43 -0400
Date: Thu, 14 Aug 2003 23:29:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, pc300@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.22-rc2-ac1: syntax error in Cyclades-PC300 Config.in entry
Message-ID: <20030814212935.GS569@fs.tum.de>
References: <200308091616.h79GG3C31402@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308091616.h79GG3C31402@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch corrects a syntax error in a Config.in:

--- linux-2.4.22-rc2-ac1-full/drivers/net/wan/Config.in.old	2003-08-14 21:50:56.000000000 +0200
+++ linux-2.4.22-rc2-ac1-full/drivers/net/wan/Config.in	2003-08-14 21:51:26.000000000 +0200
@@ -80,7 +80,7 @@
       if [ "$CONFIG_PCI" != "n" ]; then
 	dep_tristate '    Cyclades-PC300 support (RS-232/V.35, X.21, T1/E1 boards)' CONFIG_PC300 $CONFIG_HDLC
 	if [ "$CONFIG_PC300" != "n" ]; then
-		if ["$CONFIG_PPP" != "n" -a "$CONFIG_PPP_MULTLINK" != "n" -a "$CONFIG_PPP_SYNCTTY" != "n" -a "$CONFIG_HDLC_PPP" = "y"]; 
+		if [ "$CONFIG_PPP" != "n" -a "$CONFIG_PPP_MULTLINK" != "n" -a "$CONFIG_PPP_SYNCTTY" != "n" -a "$CONFIG_HDLC_PPP" = "y"]; 
 		then
 			bool '      Cyclades-PC300 MLPPP support' CONFIG_PC300_MLPPP
 		else


The error message was:
  scripts/Configure: line 83: [y: command not found


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

