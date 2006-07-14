Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWGNFdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWGNFdp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 01:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWGNFdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 01:33:44 -0400
Received: from mga06.intel.com ([134.134.136.21]:28963 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S964793AbWGNFdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 01:33:44 -0400
X-IronPort-AV: i="4.06,239,1149490800"; 
   d="scan'208"; a="65064015:sNHT600442668"
Subject: Re: [PATCH 3/5] PCI-Express AER implemetation: export
	pcie_port_bus_type
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <1152854873.28493.289.camel@ymzhang-perf.sh.intel.com>
References: <1152688203.28493.214.camel@ymzhang-perf.sh.intel.com>
	 <1152854749.28493.286.camel@ymzhang-perf.sh.intel.com>
	 <1152854873.28493.289.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1152854937.28493.291.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 14 Jul 2006 13:28:57 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

Patch 3 exports pcie_port_bus_type. AER driver could be compiled
as a module and it needs to access pcie_port_bus_type.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.17/drivers/pci/pcie/portdrv_bus.c	2006-06-22 16:26:43.000000000 +0800
+++ linux-2.6.17_aer/drivers/pci/pcie/portdrv_bus.c	2006-07-13 09:21:38.000000000 +0800
@@ -76,3 +76,6 @@ static int pcie_port_bus_resume(struct d
 		driver->resume(pciedev);
 	return 0;
 }
+
+EXPORT_SYMBOL(pcie_port_bus_type);
+
