Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265668AbSJXWBk>; Thu, 24 Oct 2002 18:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265676AbSJXWBk>; Thu, 24 Oct 2002 18:01:40 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:60689 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265668AbSJXWBj>;
	Thu, 24 Oct 2002 18:01:39 -0400
Date: Thu, 24 Oct 2002 15:06:08 -0700
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: "'KOCHI, Takayoshi'" <t-kouchi@mvf.biglobe.ne.jp>,
       "Luck, Tony" <tony.luck@intel.com>,
       pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI Hotplug Drivers for 2.5
Message-ID: <20021024220608.GM25159@kroah.com>
References: <20021024164629.GF22654@kroah.com> <72B3FD82E303D611BD0100508BB29735046DFF45@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF45@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 10:40:05AM -0700, Lee, Jung-Ik wrote:
> 
> **resource management**
> Non-ACPI platforms uses $HRT/EBDA, pcibios_*(), SMBIOS, etc. for slot
> enumeration/configuration.
> DIG64/ACPI, and SHPC requires ACPI for this. IPF platforms only have ACPI
> _CRS, _PRT, _HPP, _BBN, _STA, _ADR, _SUN, etc on the namespace for PHP, and
> we have to use them. (as a side note, this functionality is common for other
> hotplug-* as mentioned in first mail. No API will be common for
> hotplug-everything, but functionality is common and has not to be
> duplicated)
> 
> **event management in terms of controller/slot operations **
> ACPI provides only _EJ0, _PS?, _STA, etc for slot operations but these are
> not mandatory. That means, we can use either ACPI method or controller
> driver.
> intcphp driver has not enabled ACPI method based solution but uses
> controller driver.
> intcphp driver is also capable of performing ACPI method based solution
> since it works on ACPI namespace. This is why acpiphp and intcphp could be
> sharing resource management and event management.

Ok, that makes more sense to me now.  Thank you for taking the time to
explain this.

> > As this means there is a lot of "dead code" in the driver, you should
> > take all of it out.
> 
> Well, I removed many dead codes from the base driver. This is not dead code
> but needed to support other types.
> However, if it's not acceptable, I'll remove them.

If the code can never be called, it looks pretty dead to me :)

But as you're going to be sending me a patch for the existing driver, we
don't have to worry about this anymore.

> OK, then, I'll send you a patch against your cpqphp driver asap.

Looking forward to it.

thanks,

greg k-h
