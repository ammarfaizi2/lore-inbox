Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbUKEMBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbUKEMBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbUKEMBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:01:33 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:11396
	"EHLO ladymac.shadowen.org") by vger.kernel.org with ESMTP
	id S262658AbUKEMB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:01:28 -0500
To: akpm@osdl.org
Subject: [PATCH] fix pnpbios fault message
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1CQ2mU-0004xT-QX@ladymac.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Fri, 05 Nov 2004 12:01:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When your plug-n-play BIOS is truly broken and generates a fault
during use, we report this and suggest disabling it.  The message
produced suggests using "nobiospnp" to achive this, the correct
option is "pnpbios=off".  This patch upates the message.

Revision: $Rev: 741 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat 500-fix-pnpbios-fault-message
---

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/drivers/pnp/pnpbios/bioscalls.c current/drivers/pnp/pnpbios/bioscalls.c
--- reference/drivers/pnp/pnpbios/bioscalls.c
+++ current/drivers/pnp/pnpbios/bioscalls.c
@@ -165,7 +165,7 @@ static inline u16 call_pnp_bios(u16 func
 	if(pnp_bios_is_utter_crap)
 	{
 		printk(KERN_ERR "PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue\n");
-		printk(KERN_ERR "PnPBIOS: You may need to reboot with the \"nobiospnp\" option to operate stably\n");
+		printk(KERN_ERR "PnPBIOS: You may need to reboot with the \"pnpbios=off\" option to operate stably\n");
 		printk(KERN_ERR "PnPBIOS: Check with your vendor for an updated BIOS\n");
 	}
 
