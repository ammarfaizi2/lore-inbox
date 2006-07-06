Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWGFKL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWGFKL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 06:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWGFKL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 06:11:59 -0400
Received: from server6.greatnet.de ([83.133.96.26]:1250 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S965152AbWGFKL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 06:11:58 -0400
Message-ID: <44ACE27D.1010108@nachtwindheim.de>
Date: Thu, 06 Jul 2006 12:14:21 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] __devinitdata on pci_device_tables
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since some section mismatches happend it doesn't seem to be a good idea to
mark the pci_device_id tables as __devinitdata, so it should be mentioned in pci.txt .

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Correct the pci.txt about the __devintidata on pci_device_id tables.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

--- linux-2.6.18-rc1/Documentation/pci.txt      2006-07-06 10:41:43.000000000 +0200
+++ linux/Documentation/pci.txt 2006-07-06 12:02:10.000000000 +0200
@@ -122,7 +122,7 @@
        The module_init()/module_exit() functions (and all initialization
         functions called only from these) should be marked __init/exit.
        The struct pci_driver shouldn't be marked with any of these tags.
-       The ID table array should be marked __devinitdata.
+       The ID table array shouldn't be marked __devinitdata.
        The probe() and remove() functions (and all initialization
        functions called only from these) should be marked __devinit/exit.
        If you are sure the driver is not a hotplug driver then use only
