Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbVJ0Tan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbVJ0Tan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 15:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbVJ0Tan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 15:30:43 -0400
Received: from fmr20.intel.com ([134.134.136.19]:53962 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751565AbVJ0Taa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 15:30:30 -0400
Subject: [patch 0/3] pci: store PCI_INTERRUPT_PIN in pci_dev
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Oct 2005 12:30:05 -0700
Message-Id: <1130441405.5996.23.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 27 Oct 2005 19:30:06.0784 (UTC) FILETIME=[D626D400:01C5DB2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Store the value of PCI_INTERRUPT_PIN in the pci_dev structure for use
later.  This is useful for pci hotplug.  When a device is "surprise"
removed, the pci config space is no longer available.  However,
the pin value is needed to correctly disable the irq for the device.

--
