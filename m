Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTFTNYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFTNYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:24:31 -0400
Received: from host213.137.8.62.manx.net ([213.137.8.62]:22802 "EHLO server")
	by vger.kernel.org with ESMTP id S261292AbTFTNYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:24:31 -0400
Date: Fri, 20 Jun 2003 14:38:23 +0100
From: Matthew Bell <m.bell@bvrh.co.uk>
To: Philip.Blundell@pobox.com, tim@cyberelk.net, campbell@torque.net,
       andrea@e-mind.com, linux-parport@torque.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] Obvious: drivers/parport/parport_serial.c depends on
 PCI.
Message-Id: <20030620143823.14ae651f.m.bell@bvrh.co.uk>
Organization: Beach View Residential Home, Ltd.
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need to change the dependencies in drivers/parport/Config.in to add CONFIG_PCI
as a dependency of parport_serial. Here is a patch that works for me; this
hasn't been fixed in 2.4.21:
--- linux.orig/drivers/parport/Config.in	2001-12-21 17:41:55.000000000 +0000
+++ linux/drivers/parport/Config.in	2002-08-06 18:52:21.000000000 +0100
@@ -17,7 +17,7 @@
       else
          define_tristate CONFIG_PARPORT_PC_CML1 $CONFIG_PARPORT_PC
       fi
-      dep_tristate '    Multi-IO cards (parallel and serial)'
CONFIG_PARPORT_SERIAL $CONFIG_PARPORT_PC_CML1
+      dep_tristate '    Multi-IO cards (parallel and serial)'
CONFIG_PARPORT_SERIAL $CONFIG_PARPORT_PC_CML1 $CONFIG_PCI
    fi
    if [ "$CONFIG_PARPORT_PC" != "n" ]; then
       if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then




