Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbUAMBAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUAMBA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:00:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36561 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262795AbUAMBAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:00:21 -0500
Date: Tue, 13 Jan 2004 02:00:19 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] simplify COMX_PROTO_LAPB dependencies
Message-ID: <20040113010019.GZ9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

the patch below simplifies the COMX_PROTO_LAPB dependencies while 
remaining semantically equivalent.

Please apply
Adrian

--- linux-2.6.1-mm2/drivers/net/wan/Kconfig.old	2004-01-13 01:53:19.000000000 +0100
+++ linux-2.6.1-mm2/drivers/net/wan/Kconfig	2004-01-13 01:53:57.000000000 +0100
@@ -143,7 +143,7 @@
 
 config COMX_PROTO_LAPB
 	tristate "Support for LAPB protocol on MultiGate boards"
-	depends on WAN && (COMX!=n && LAPB=m && LAPB || LAPB=y && COMX)
+	depends on COMX && LAPB
 	help
 	  LAPB protocol driver for all MultiGate boards. Say Y if you
 	  want to use this protocol on your MultiGate boards.
