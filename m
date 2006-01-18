Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWARNE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWARNE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWARNE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:04:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6627 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932523AbWARNE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:04:56 -0500
Date: Wed, 18 Jan 2006 14:04:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: [patch 0/4]  Hot Dock/Undock support
Message-ID: <20060118130444.GA1518@elf.ucw.cz>
References: <1137545813.19858.45.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137545813.19858.45.camel@whizzy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This series of patches is against the -mm kernel, and will enable
> docking station support.  It is an early patch, but still pretty 
> functional, so I think it's worthwhile to include at this point.
> For some laptops, it's necessary to use the pci=assign-busses kernel 
> parameter, because some _DCK methods will attempt to assign bus numbers
> to the dock bridge (incorrectly).

On thinkpad X32: I selected

CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set
CONFIG_ACPI_IBM=y

Recompiled, rebooted with machine out of dock. /sys/bus/pci/slots/ is
empty. I then inserted machine into dock, and locked it:

root@amd:/sys/bus/pci/slots# echo dock > /proc/acpi/ibm/dock
root@amd:/sys/bus/pci/slots# ls
root@amd:/sys/bus/pci/slots#

...still empty. What am I doing wrong?
								Pavel
-- 
Thanks, Sharp!
