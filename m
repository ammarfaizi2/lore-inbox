Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265334AbSJaVBC>; Thu, 31 Oct 2002 16:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265335AbSJaVBC>; Thu, 31 Oct 2002 16:01:02 -0500
Received: from fmr02.intel.com ([192.55.52.25]:37090 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265334AbSJaVAy>; Thu, 31 Oct 2002 16:00:54 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A492@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: "'Greg@kroah.com'" <Greg@kroah.com>
Subject: RE: bare pci configuration access functions ?
Date: Thu, 31 Oct 2002 13:07:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lee, Jung-Ik [mailto:jung-ik.lee@intel.com] 
> 	Some kernel drivers/components such as hotplug 
> pci/io-node drivers,
> ACPI driver, some console drivers, etc **need bare pci 
> configuration space
> access** before either pci driver is initialized or struct pci_dev is
> constructed.
> 
> ACPI needs this for ACPI/PCI population, hotplug pci driver 
> for populating
> hot-added pci hierarchy. As more drivers are cross ported 
> over to wider
> architectures, this would become wider need. Help me if 
> others need this
> too.

When the PCI Config stuff got revamped a few months ago, Greg KH, myself,
and some other people discussed this, and the conclusion seemed to be that
it was less ugly to make the code that needs bare PCI config access use fake
structs, than to have the bare functions exposed. Greg, am I remembering
correctly?

Regards -- Andy
