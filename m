Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312050AbSCVTyO>; Fri, 22 Mar 2002 14:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312816AbSCVTyF>; Fri, 22 Mar 2002 14:54:05 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:39687 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312638AbSCVTxq>;
	Fri, 22 Mar 2002 14:53:46 -0500
Date: Fri, 22 Mar 2002 11:53:38 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM PCI Hotplug driver doesn't compile in 2.4.19-pre4
Message-ID: <20020322195338.GI9629@kroah.com>
In-Reply-To: <Pine.NEB.4.44.0203212148280.2125-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 22 Feb 2002 14:44:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 09:51:30PM +0100, Adrian Bunk wrote:
> 
> Building a kernel with the IBM PCI Hotplug driver statically included
> fails at the final linking stage with a:

Nevermind about the .config.

Let me know if the patch below does not solve this for you.

thanks,

greg k-h


diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Fri Mar 22 11:47:34 2002
+++ b/drivers/hotplug/ibmphp_core.c	Fri Mar 22 11:47:34 2002
@@ -56,7 +56,7 @@
 MODULE_DESCRIPTION (DRIVER_DESC);
 
 static int *ops[MAX_OPS + 1];
-static struct pci_ops *ibmphp_pci_root_ops;
+struct pci_ops *ibmphp_pci_root_ops;
 static int max_slots;
 
 static int irqs[16];    /* PIC mode IRQ's we're using so far (in case MPS tables don't provide default info for empty slots */
