Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbSJaVyu>; Thu, 31 Oct 2002 16:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265326AbSJaVyt>; Thu, 31 Oct 2002 16:54:49 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:10443 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S263207AbSJaVyt>; Thu, 31 Oct 2002 16:54:49 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A493@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "Lee, Jung-Ik" <jung-ik.lee@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: bare pci configuration access functions ?
Date: Thu, 31 Oct 2002 14:00:27 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH [mailto:greg@kroah.com] 
> In 2.5 we now have a 
> pci_bus_read_*
> and pci_bus_write_* functions, which the pci hotplug drivers use, as
> they at least know the bus on which the devices they are 
> looking for are
> on.  I also had to convert over some ACPI code that was using the
> pci_read_config functions to get everything to work properly, but I
> don't seem to be able to find that code in the latest 2.5 tree, so I
> guess you don't need to do that anymore?

It's still there in drivers/acpi/osl.c. We use the pci_root_ops directly,
instead of bus->ops (which is usually set to pci_root_ops anyways) but I
just mention this as a sidenote.

Regards -- Andy
