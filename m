Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTJTX2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbTJTX2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:28:51 -0400
Received: from panda.sul.com.br ([200.219.150.4]:63755 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262906AbTJTX2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:28:49 -0400
Date: Mon, 20 Oct 2003 21:27:32 -0200
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <mikenc@us.ibm.com>
Subject: [patch] qlogic: force can_queue
Message-ID: <20031020232732.GE473@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
	should this be done or should i kill can_queue from all drivers and
call BUG() if anyone tries to be loaded without being able to queue?

-- 
aris


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qlogic-force_can_queue.patch"

--- linux/drivers/scsi/qlogicfas.c.orig	2003-10-20 21:12:09.000000000 -0200
+++ linux/drivers/scsi/qlogicfas.c	2003-10-20 21:12:17.000000000 -0200
@@ -793,7 +793,7 @@
 	.eh_device_reset_handler= qlogicfas_device_reset,
 	.eh_host_reset_handler	= qlogicfas_host_reset,
 	.bios_param		= qlogicfas_biosparam,
-	.can_queue		= 0,
+	.can_queue		= 1,
 	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= 1,

--ILuaRSyQpoVaJ1HG--
