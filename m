Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVFBWds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVFBWds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFBWds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:33:48 -0400
Received: from fmr18.intel.com ([134.134.136.17]:17123 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261447AbVFBWdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:33:14 -0400
Message-Id: <20050602224147.177031000@csdlinux-1>
Date: Thu, 02 Jun 2005 15:41:47 -0700
From: rajesh.shah@intel.com
To: gregkh@suse.de, ink@jurassic.park.msu.ru, ak@suse.de, len.brown@intel.com,
       akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net
Subject: [patch 0/2] Collecting host bridge resources - take 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI hotplug code now uses the PCI core to allocate and manage
resources for hot-plug devices. To work correctly, this requires
all bridges to report resources they are decoding in their
pci_bus structure. We already do this for PCI-PCI bridges, but
not for host bridges. This patchset reads and stores host bridge
resources reported by ACPI BIOS for i386 and x86_64 systems.

This is the 2nd version of this patchset. The major change is
that it increases the number of resource pointers in the pci_bus
structure and eliminates the need to have a boot time parameter
to enable the code.

Andrew, if you add this to the next -mm, please also drop the
previous version this patchset (i386-collect-host-bridge-resources.patch
and x86_64-collect-host-bridge-resources.patch).

Rajesh
--
