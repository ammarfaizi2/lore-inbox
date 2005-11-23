Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030551AbVKWX5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030551AbVKWX5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbVKWXrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:46018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751344AbVKWXqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:42 -0500
Date: Wed, 23 Nov 2005 15:43:35 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 00/22] PCI, USB and hwmon patches for 2.6.15-rc2-git
Message-ID: <20051123234335.GA527@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few PCI, USB, hwmon, and documentation patches against your
latest git tree, they have all been in the past few -mm releases just
fine.

The big changes in here are some ehci and ohci fixes to handle suspend
better (there is still one more pending patch to get it all working
completely, but that needs more testing before I send it to you.)

thanks,

greg k-h

 MAINTAINERS                        |   26 +
 arch/i386/pci/common.c             |    6 
 arch/i386/pci/direct.c             |    4 
 arch/i386/pci/i386.c               |    9 
 drivers/base/bus.c                 |   21 -
 drivers/base/dd.c                  |   10 
 drivers/hwmon/hdaps.c              |    4 
 drivers/hwmon/it87.c               |    9 
 drivers/hwmon/lm78.c               |    4 
 drivers/hwmon/w83627hf.c           |   10 
 drivers/pci/hotplug/pciehp.h       |    1 
 drivers/pci/hotplug/pciehp_ctrl.c  |   15 -
 drivers/pci/hotplug/pciehp_hpc.c   |   12 
 drivers/pci/pci-acpi.c             |    3 
 drivers/usb/core/hcd-pci.c         |   38 ++
 drivers/usb/core/hub.c             |    3 
 drivers/usb/host/ehci-hcd.c        |  158 +++++------
 drivers/usb/host/ehci-hub.c        |    7 
 drivers/usb/host/ehci-pci.c        |  515 +++++++++++++++++--------------------
 drivers/usb/host/ohci-pci.c        |   53 +--
 drivers/usb/media/sn9c102_core.c   |    4 
 drivers/usb/serial/ftdi_sio.c      |    2 
 drivers/usb/serial/ftdi_sio.h      |    9 
 drivers/usb/serial/ipw.c           |    2 
 drivers/usb/storage/unusual_devs.h |   11 
 include/linux/usb.h                |    3 
 26 files changed, 494 insertions(+), 445 deletions(-)

