Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264406AbTH1WHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264408AbTH1WHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:07:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:40600 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264406AbTH1WHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:07:05 -0400
Date: Thu, 28 Aug 2003 15:07:11 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug patches for 2.4.23-pre1
Message-ID: <20030828220711.GA13344@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 4 PCI Hotplug patches for 2.4.23-pre1.  One of them fixes the
__FUNCTION__ compiler warnings, another fixes the Copyright notification
of the drivers, and the last two sync up with some PCI device macros
that are in 2.6 to make porting drivers easier.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/pci-2.4

The raw patches will follow.

thanks,

greg k-h


 drivers/hotplug/acpiphp.h          |   12 +++---
 drivers/hotplug/acpiphp_core.c     |   12 +++---
 drivers/hotplug/acpiphp_glue.c     |    6 +--
 drivers/hotplug/acpiphp_pci.c      |   12 +++---
 drivers/hotplug/acpiphp_res.c      |   12 +++---
 drivers/hotplug/cpqphp.h           |   12 +++---
 drivers/hotplug/cpqphp_core.c      |   36 +++++++++---------
 drivers/hotplug/cpqphp_ctrl.c      |   74 ++++++++++++++++++-------------------
 drivers/hotplug/cpqphp_nvram.c     |    8 ++--
 drivers/hotplug/cpqphp_nvram.h     |    4 +-
 drivers/hotplug/cpqphp_pci.c       |   18 ++++-----
 drivers/hotplug/cpqphp_proc.c      |    6 +--
 drivers/hotplug/ibmphp.h           |    4 +-
 drivers/hotplug/ibmphp_core.c      |    4 +-
 drivers/hotplug/ibmphp_ebda.c      |    4 +-
 drivers/hotplug/ibmphp_hpc.c       |    2 -
 drivers/hotplug/ibmphp_pci.c       |    4 +-
 drivers/hotplug/ibmphp_res.c       |    4 +-
 drivers/hotplug/pci_hotplug.h      |    6 +--
 drivers/hotplug/pci_hotplug_core.c |    6 +--
 drivers/hotplug/pci_hotplug_util.c |    8 ++--
 include/linux/pci.h                |   26 +++++++++++++
 22 files changed, 153 insertions(+), 127 deletions(-)
-----

<vmlinuz386:yahoo.com.ar>:
  o PCI Hotplug: fix __FUNCTION__ warnings

Greg Kroah-Hartman:
  o PCI: add PCI_DEVICE_CLASS() macro to match PCI_DEVICE() macro
  o PCI: add PCI_DEVICE() macro to make pci_device_id tables easier to read
  o PCI hotplug: fix up a bunch of copyrights that were incorrectly declared

