Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265592AbSJXSdg>; Thu, 24 Oct 2002 14:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265596AbSJXSdg>; Thu, 24 Oct 2002 14:33:36 -0400
Received: from fmr01.intel.com ([192.55.52.18]:2296 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265592AbSJXSdf>;
	Thu, 24 Oct 2002 14:33:35 -0400
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF48@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'KOCHI, Takayoshi'" <t-kouchi@mvf.biglobe.ne.jp>, greg@kroah.com
Cc: "Luck, Tony" <tony.luck@intel.com>, pcihpd-discuss@lists.sourceforge.net,
       linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: RE: PCI Hotplug Drivers for 2.5
Date: Thu, 24 Oct 2002 11:39:35 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > We need this driver as it's the only solution for DIG64 
> compliant IPF
> > platforms.
> 
> No, not for all DIG64 compliant IPF platforms.  NEC TX7 is also
> a DIG64 compliant IPF platform but doesn't need your driver.

Well, I forgot acpiphp driver was removed in this driver patch :)
acpiphp is also for DIG64/ACPI and will do for some DIG64/ACPI machines
while intcphp is feature full driver for IPF platform PHP.

> 
> DIG64(2.1) only states that:
> 
>  Firmware Support for PCI Hot-Plug
>                                : Recommended if PCI Hot-Plug is
>                                  implemented
>  ACPI Support for PCI Hot-Plug : Recommended for platforms that
>                                  implement PCI Hot-Plug without SHPC
>  Using PCI Hot-Plug Specifications
>                                : Recommended if PCI Hot-Plug is
>                                  implemented

ACPI IS mandatory for DIG64 PHP resource management by SHPC, while ACPI
based slot operation is not required.
The above sentence only could be misleading.

> 
> The spec also states that any PCI Hot-Plug controller must
> follow one of PCI Hot-Plug spec 1.1, SHPC 1.0 or CompactPCI Hot Swap
> spec.  It also strongly recommends SHPC 1.0, which is not covered
> by J.I.'s driver yet.

intcphp is desined with SHPC on plan in terms of ACPI resource management,
as SHPC spec says
"DIG64 compliant platforms must use ACPI to describe resource allocation."
But it is not completely ready for SHPC yet. It's a matter of deployment
schedules of dependencies such as HPRT, ACPI methods OSHP, HBRB, etc which
will need to be enabled in Linux kernel ACPI driver/platform firmware.

> 
> But anyway Itanium2 platform using intel's hot-plug controller
> will be shipping soon and J.I.'s driver has much better functionality
> than acpiphp.  This would be a decent reason for having the
> driver in the mainline.
> 
> And this also motivates us to clean up the duplicated code if
> it were in mainline:)

\o/ second to this :)

> 
> Thanks,
> -- 
> KOCHI, Takayoshi <t-kouchi@cq.jp.nec.com/t-kouchi@mvf.biglobe.ne.jp>
> 
