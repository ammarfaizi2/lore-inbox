Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265428AbSJXSOo>; Thu, 24 Oct 2002 14:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265586AbSJXSOo>; Thu, 24 Oct 2002 14:14:44 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:56826 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S265428AbSJXSOn>; Thu, 24 Oct 2002 14:14:43 -0400
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF47@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Matthew Wilcox'" <willy@debian.org>
Cc: "'Greg KH'" <greg@kroah.com>,
       "'KOCHI, Takayoshi'" <t-kouchi@mvf.biglobe.ne.jp>,
       "Luck, Tony" <tony.luck@intel.com>,
       pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [Linux-ia64] RE: PCI Hotplug Drivers for 2.5
Date: Thu, 24 Oct 2002 11:19:08 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > **resource management**
> > Non-ACPI platforms uses $HRT/EBDA, pcibios_*(), SMBIOS, 
> etc. for slot
> > enumeration/configuration.
> > DIG64/ACPI, and SHPC requires ACPI for this. IPF platforms 
> only have ACPI
> > _CRS, _PRT, _HPP, _BBN, _STA, _ADR, _SUN, etc on the 
> namespace for PHP, and
> > we have to use them. (as a side note, this functionality is 
> common for other
> > hotplug-* as mentioned in first mail. No API will be common for
> > hotplug-everything, but functionality is common and has not to be
> > duplicated)
> 
> > **event management in terms of controller/slot operations **
> > ACPI provides only _EJ0, _PS?, _STA, etc for slot 
> operations but these are
> > not mandatory. That means, we can use either ACPI method or 
> controller
> > driver.
> > intcphp driver has not enabled ACPI method based solution but uses
> > controller driver.
> > intcphp driver is also capable of performing ACPI method 
> based solution
> > since it works on ACPI namespace. This is why acpiphp and 
> intcphp could be
> > sharing resource management and event management.
> 
> Sounds like we want a library of ACPI code that can be used 
> by individual
> drivers rather than an ACPI driver with pluggable event management
> functions then.

Right, that's where we're getting at.
