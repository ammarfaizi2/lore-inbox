Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265583AbSJXRxE>; Thu, 24 Oct 2002 13:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265584AbSJXRxE>; Thu, 24 Oct 2002 13:53:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22022 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265583AbSJXRxC>;
	Thu, 24 Oct 2002 13:53:02 -0400
Date: Thu, 24 Oct 2002 18:59:14 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: "'Greg KH'" <greg@kroah.com>,
       "'KOCHI, Takayoshi'" <t-kouchi@mvf.biglobe.ne.jp>,
       "Luck, Tony" <tony.luck@intel.com>,
       pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] RE: PCI Hotplug Drivers for 2.5
Message-ID: <20021024185914.Z27461@parcelfarce.linux.theplanet.co.uk>
References: <72B3FD82E303D611BD0100508BB29735046DFF45@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF45@orsmsx102.jf.intel.com>; from jung-ik.lee@intel.com on Thu, Oct 24, 2002 at 10:40:05AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 10:40:05AM -0700, Lee, Jung-Ik wrote:
> **resource management**
> Non-ACPI platforms uses $HRT/EBDA, pcibios_*(), SMBIOS, etc. for slot
> enumeration/configuration.
> DIG64/ACPI, and SHPC requires ACPI for this. IPF platforms only have ACPI
> _CRS, _PRT, _HPP, _BBN, _STA, _ADR, _SUN, etc on the namespace for PHP, and
> we have to use them. (as a side note, this functionality is common for other
> hotplug-* as mentioned in first mail. No API will be common for
> hotplug-everything, but functionality is common and has not to be
> duplicated)

> **event management in terms of controller/slot operations **
> ACPI provides only _EJ0, _PS?, _STA, etc for slot operations but these are
> not mandatory. That means, we can use either ACPI method or controller
> driver.
> intcphp driver has not enabled ACPI method based solution but uses
> controller driver.
> intcphp driver is also capable of performing ACPI method based solution
> since it works on ACPI namespace. This is why acpiphp and intcphp could be
> sharing resource management and event management.

Sounds like we want a library of ACPI code that can be used by individual
drivers rather than an ACPI driver with pluggable event management
functions then.

-- 
Revolutions do not require corporate support.
