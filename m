Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265569AbTFZLG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 07:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265575AbTFZLG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 07:06:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44972 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265569AbTFZLGU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 07:06:20 -0400
Date: Thu, 26 Jun 2003 12:20:32 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_name()
Message-ID: <20030626112032.GK451@parcelfarce.linux.theplanet.co.uk>
References: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk> <20030626003620.GB13892@kroah.com> <20030626005315.GD451@parcelfarce.linux.theplanet.co.uk> <20030626010239.GB15189@kroah.com> <20030626025057.GE451@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626025057.GE451@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 03:50:57AM +0100, Matthew Wilcox wrote:
> This patch introduces pci_name() and converts slot_name into a pointer to
> dev.bus_id.

Here's the compatibility patch for 2.4:

--- linux/include/linux/pci.h	2003-05-21 05:21:29.000000000 -0400
+++ linux-acpi/include/linux/pci.h	2003-06-26 06:39:58.000000000 -0400
@@ -773,6 +773,11 @@
 	pdev->driver_data = data;
 }
 
+static inline char *pci_name(struct pci_dev *pdev)
+{
+	return pdev->slot_name;
+}
+
 /*
  *  The world is not perfect and supplies us with broken PCI devices.
  *  For at least a part of these bugs we need a work-around, so both

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
