Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTJTX0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTJTX0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:26:38 -0400
Received: from panda.sul.com.br ([200.219.150.4]:47627 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S263060AbTJTX0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:26:33 -0400
Date: Mon, 20 Oct 2003 21:25:23 -0200
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <mikenc@us.ibm.com>
Subject: [patch] qlogic_cs: init legacy_hosts
Message-ID: <20031020232523.GD473@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-- 
aris


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qlogic-init_legacy_hosts.patch"

--- linux/drivers/scsi/pcmcia/qlogic_stub.c.orig	2003-10-20 21:04:02.000000000 -0200
+++ linux/drivers/scsi/pcmcia/qlogic_stub.c	2003-10-20 21:05:02.000000000 -0200
@@ -249,6 +249,8 @@
 	else
 		qlogicfas_preset(link->io.BasePort1, link->irq.AssignedIRQ);
 
+	INIT_LIST_HEAD(&qlogicfas_driver_template.legacy_hosts);
+
 	host = __qlogicfas_detect(&qlogicfas_driver_template);
 	if (!host) {
 		printk(KERN_INFO "qlogic_cs: no SCSI devices found\n");

--5gxpn/Q6ypwruk0T--
