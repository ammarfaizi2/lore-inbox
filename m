Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314471AbSDRVpw>; Thu, 18 Apr 2002 17:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314472AbSDRVpv>; Thu, 18 Apr 2002 17:45:51 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:48900 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314471AbSDRVps>;
	Thu, 18 Apr 2002 17:45:48 -0400
Date: Thu, 18 Apr 2002 13:44:40 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2 of 2] IBM PCI Hotplug fix
Message-ID: <20020418204439.GB7762@kroah.com>
In-Reply-To: <20020418204350.GA7762@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a patch against 2.4.19-pre7 that allows the IBM PCI Hotplug
driver to be built into the kernel properly.

thanks,

greg k-h


diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Thu Apr 18 09:15:05 2002
+++ b/drivers/hotplug/ibmphp_core.c	Thu Apr 18 09:15:05 2002
@@ -56,7 +56,7 @@
 MODULE_DESCRIPTION (DRIVER_DESC);
 
 static int *ops[MAX_OPS + 1];
-static struct pci_ops *ibmphp_pci_root_ops;
+struct pci_ops *ibmphp_pci_root_ops;
 static int max_slots;
 
 static int irqs[16];    /* PIC mode IRQ's we're using so far (in case MPS tables don't provide default info for empty slots */


