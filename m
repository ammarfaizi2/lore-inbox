Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVA3VNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVA3VNQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 16:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVA3VNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 16:13:16 -0500
Received: from av4-2-sn3.vrr.skanova.net ([81.228.9.112]:4567 "EHLO
	av4-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261784AbVA3VNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 16:13:13 -0500
Date: Sun, 30 Jan 2005 22:13:09 +0100
From: Peter Lundkvist <p.lundkvist@telia.com>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPMI smbus and Intel 6300ESB Watchdog drivers
Message-ID: <20050130211309.GA9858@localhost>
References: <20050130184401.GC3373@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050130184401.GC3373@hardeman.nu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 07:44:01PM +0100, David Härdeman wrote:
> 
> 1) On the mainboard is a 6300ESB Watchdog Timer (pci id 8086:25ab), but 
> there seems to be no driver available for it. Does anyone know if there 
> is any such driver in progress or if I've misunderstood the situation?

You can use the other watchdog in this chip, the TCO timer. The
driver needs a patch to work with 6300ESB.

Peter


--- linux-2.6.10/drivers/char/watchdog/i8xx_tco.c.org	2005-01-30 21:45:39.000000000 +0100
+++ linux-2.6.10/drivers/char/watchdog/i8xx_tco.c	2005-01-30 21:53:21.000000000 +0100
@@ -362,6 +362,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_1,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE (pci, i8xx_tco_pci_tbl);
