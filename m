Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSKVB40>; Thu, 21 Nov 2002 20:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264795AbSKVB40>; Thu, 21 Nov 2002 20:56:26 -0500
Received: from fmr06.intel.com ([134.134.136.7]:38143 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S264790AbSKVB4Z>; Thu, 21 Nov 2002 20:56:25 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A536@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Stelian Pop'" <stelian.pop@fr.alcove.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net,
       Patrick Mochel <mochel@osdl.org>
Subject: RE: [PATCH] Allow others to use ACPI EC interface
Date: Thu, 21 Nov 2002 18:03:27 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stelian Pop [mailto:stelian.pop@fr.alcove.com] 
> Well, not directly related to the EC thing but rather to the 
> ACPI/sonypi
> integration, but maybe you noticed that the sonypi driver also
> re-implements some code which is originally defined in the ACPI bios
> (SRS, DIS methods on "SPIC" ACPI object). 
> 
> One day I should really call some ACPI exported function to do this,
> but last time I looked at this (3 months ago ?), the ACPI API (the one
> exported to external users) was still changing each day. 

Yeah I think the interface is settling down. You should be able to look at
the code in drivers/acpi or drivers/hotplug/acpiphp* for examples.

>From looking at other Sony ACPI BIOSes I've collected, it appears that SPIC
has a hardware ID (HID) in the ACPI namespace. It seems analogous to the
Toshiba Laptop Extras device in drivers/acpi.

Indeed, I think a sonypi driver that assumes ACPI will be much shorter and
look quite different from the current one. But since we have resolved the EC
contention issues, this need not be addressed immediately.

Regards -- Andy

PS IIRC there is the idea of a "platform enumerator" that will suitably
generalize the mobo enumeration function ACPI performs on x86 for other
platforms, but I don't think that has been implemented yet.
