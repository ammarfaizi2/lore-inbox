Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVAODRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVAODRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 22:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVAODRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 22:17:12 -0500
Received: from bromo.msbb.uc.edu ([129.137.3.146]:14790 "HELO
	bromo.msbb.uc.edu") by vger.kernel.org with SMTP id S262195AbVAODQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 22:16:56 -0500
To: alan@lxorguk.ukuu.org.uk, howarth@bromo.msbb.uc.edu
Subject: Re: usb key oddities with 2.6.10-ac9
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050115031532.DAA6F1DC100@bromo.msbb.uc.edu>
Date: Fri, 14 Jan 2005 22:15:32 -0500 (EST)
From: howarth@bromo.msbb.uc.edu (Jack Howarth)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
    I don't see any changes in how Fedora's 2.6.10 kernels are built 
that should effect USB hotplugging. The previous kernel I was using
shows...

grep HOT config-2.6.7-1.494.2.2smp      
CONFIG_HOTPLUG=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
CONFIG_HOTPLUG_PCI_COMPAQ=m
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_PCIE=m
CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE=y
CONFIG_HOTPLUG_PCI_SHPC=m
CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE=y
CONFIG_DM_SNAPSHOT=m
CONFIG_USB_STORAGE_JUMPSHOT=y

and their new 2.6.10 based kernels show...

grep HOT config-2.6.10-1.9_FC2smp
CONFIG_HOTPLUG=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
CONFIG_HOTPLUG_PCI_COMPAQ=m
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_PCIE=m
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
CONFIG_HOTPLUG_PCI_SHPC=m
# CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set
CONFIG_DM_SNAPSHOT=m
CONFIG_USB_STORAGE_JUMPSHOT=y

Is there anything I can modify (without rebuilding the kernel) that
will fire off dmsegs from the kernel for the calls it makes to 
execute /sbin/hotplug? Perhaps I can see some difference in how or
when hotplug is called by the kernel for usb devices?
                 Jack
ps Fedora did switch with 2.6.10 from using usbdevfs to using usbfs
but they modified their initscripts package to handle that change.
