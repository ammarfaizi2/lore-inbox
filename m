Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUICJDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUICJDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269432AbUICJCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:02:21 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:55523 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S267386AbUICIwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:52:07 -0400
Message-ID: <1094201523.413830b39d44d@imp3-q.free.fr>
Date: Fri,  3 Sep 2004 10:52:03 +0200
From: castet.matthieu@free.fr
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: pnp and acpi_pnp
References: <29AC424F54821A4FB5D7CBE081922E40018E14F4@hdsmsx403.hd.intel.com>
In-Reply-To: <29AC424F54821A4FB5D7CBE081922E40018E14F4@hdsmsx403.hd.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 213.228.50.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon "Brown, Len" <len.brown@intel.com>:

> there are PNP id's which should tell exactly what
> the device is.  For the ACPI case, you can dump
> your BIOS with acpidmp and disassemble it with iasl
> to see the PNP-ids.
>
> But Linux doesn't use ACPI's PNP-ids for device
> enumeration -- yet.
>
Ok, thanks.

> >> PNPBIOS should be disabled when ACPI is enabled, and it is a bug that
> >> this is not automatic.
Yes it sould.
Also with 2.6.9 acpi pnp and pnp will conflic :
the new acpi driver drivers/acpi/motherboard.c reserve the motherboard
resources, but if you look at driver/pnp/system.c, there is also a pnp driver
that does the same jobs. So if PNP0c0[12] appear in pnp layer (with pnpbios),
both driver try to allocate the ressource.
Hopefully it cause only warnings.
But it show the problem and the need of unification instead of reimplant things.

> cheers,
> -Len
>
regards
Matthieu

> >-----Original Message-----
> >From: castet.matthieu@free.fr [mailto:castet.matthieu@free.fr]
> >Sent: Thursday, September 02, 2004 7:38 AM
> >To: Brown, Len
> >Cc: linux-kernel@vger.kernel.org
> >Subject: Re: pnp and acpi_pnp
> >
> >Selon Len Brown <len.brown@intel.com>:
> >
> >> Matthieu,
> >> PNPBIOS should be disabled when ACPI is enabled, and it is a bug that
> >> this is not automatic.
> >>
> >> yes, the "Linux PNP" layer is incomplete, and ACPI isn't yet plugged
> >> into that.
> >>
> >> cheers,
> >> -Len
> >>
> >>
> >>
> >
> >
> >Hi,
> >thanks for your reply.
> >
> >What about the fact that acpi pnp don't make the difference
> >between a normal
> >serial port and a ir port ?
> >
> >I hope acpi will be plugged soon in Linux PNP layer.
> >
> >regards,
> >Matthieu
> >
>


