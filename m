Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbTJEC7u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 22:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTJEC7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 22:59:50 -0400
Received: from [217.172.69.25] ([217.172.69.25]:19497 "EHLO falafell.ghetto")
	by vger.kernel.org with ESMTP id S262954AbTJEC7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 22:59:48 -0400
Date: Sun, 5 Oct 2003 04:59:46 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] orinoco_pci.c drives prism III
Message-ID: <20031005025946.GA2117@81.38.200.176>
Reply-To: piotr@member.fsf.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Pedro Larroy <piotr@member.fsf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Orinoco pci prism III in my latop works nicely with orinoco_pci

The hw is:

02:06.0 Network controller: Harris Semiconductor: Unknown device 3872 (rev 01)
        Subsystem: AMBIT Microsystem Corp.: Unknown device 0200
        Flags: medium devsel, IRQ 22
        Memory at e0500000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>


just:


--- linux-2.6.0-test6/drivers/net/wireless/orinoco_pci.c        2003-09-28 02:50:36.000000000 +0200
+++ linux-2.6.0-test6-pi/drivers/net/wireless/orinoco_pci.c     2003-10-01 18:51:31.000000000 +0200
@@ -360,6 +360,7 @@
 }

 static struct pci_device_id orinoco_pci_pci_id_table[] = {
+       {0x1260, 0x3872, PCI_ANY_ID, PCI_ANY_ID,},
        {0x1260, 0x3873, PCI_ANY_ID, PCI_ANY_ID,},
        {0,},
 };

-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
