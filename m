Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290540AbSAQXt5>; Thu, 17 Jan 2002 18:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290541AbSAQXtm>; Thu, 17 Jan 2002 18:49:42 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:37125 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290542AbSAQXt1>;
	Thu, 17 Jan 2002 18:49:27 -0500
Date: Thu, 17 Jan 2002 15:45:36 -0800
From: Greg KH <greg@kroah.com>
To: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI Hotplug driver for new IBM motherboards
Message-ID: <20020117234535.GA9590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 20 Dec 2001 21:36:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've made up a patch that contains a new PCI Hotplug controller driver
that will work on upcoming IBM i386 based machines.  This is the first
publicly released version, and still needs to undergo a lot of testing
before it is submitted to the kernel tree.

The patch is against 2.4.18-pre4 and can be found at:
  http://www.kernel.org/pub/linux/kernel/people/gregkh/hotplug/ibmphp-2.4.18-pre4.patch

The patch only modifies one existing kernel source file, and that is to
export the IO_APIC_get_PCI_irq_vector symbol, which the driver needs to
determine the proper IRQ when a new PCI card is plugged in.

This driver was written by Irene Zubarev, Jyoti Shah, Tong Yu and Chuck
Cole with just a tiny bit of help from me.

diffstat output:
 arch/i386/kernel/i386_ksyms.c |    4 
 drivers/hotplug/Config.in     |    5 
 drivers/hotplug/Makefile      |   12 
 drivers/hotplug/ibmphp.h      |  721 ++++++++++++++
 drivers/hotplug/ibmphp_core.c | 1341 +++++++++++++++++++++++++++
 drivers/hotplug/ibmphp_ebda.c | 1034 +++++++++++++++++++++
 drivers/hotplug/ibmphp_hpc.c  | 1418 +++++++++++++++++++++++++++++
 drivers/hotplug/ibmphp_pci.c  | 1646 ++++++++++++++++++++++++++++++++++
 drivers/hotplug/ibmphp_res.c  | 2022 ++++++++++++++++++++++++++++++++++++++++++

thanks,

greg k-h
