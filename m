Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSFDV6t>; Tue, 4 Jun 2002 17:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316854AbSFDV6s>; Tue, 4 Jun 2002 17:58:48 -0400
Received: from fmr02.intel.com ([192.55.52.25]:42953 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S316853AbSFDV6q>; Tue, 4 Jun 2002 17:58:46 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7ED8@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Dave Jones'" <davej@suse.de>
Cc: "'Pavel Machek'" <pavel@suse.cz>, Brad Hards <bhards@bigpond.net.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@rustcorp.com.au
Subject: RE: [patch] i386 "General Options" - begone [take 2]
Date: Tue, 4 Jun 2002 14:58:35 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Jones [mailto:davej@suse.de] 
>  > This is a tough one because ACPI *is* power management but 
> it is also
>  > configuration. It is equivalent to such things as MPS 
> table parsing, $PIR
>  > parsing, PNPBIOS, as well as APM. The first two don't have 
> CONFIG_ options
>  > at the moment but they should at some point.
>  > The only thing I can think of is a "Platform interface 
> options" menu and
>  > just throw all of the above in that. Any other ideas?
> 
> You seem to be halfway down the road of splitting ACPI in two already,
> with the introduction of CONFIG_ACPI_HT_ONLY recently. Why not bundle
> such options under a CONFIG_ACPI_INITIALISATION or the likes, and
> put the rest under the power management menu as Brad suggested ?

CONFIG_ACPI_HT_ONLY was a concession to the fact that using ACPI for
processor discovery only was possible already, but in general an
all-or-nothing approach to ACPI is IMHO the safest bet.

So, let's assume in the very near future it becomes possible to compile a
kernel without MPS or $PIR support. Where should those config options go?
These, in addition to pnpbios, are also unneeded with ACPI. That is why I
was advocating the more general "Platform interface options" menu, so we
could have *one* place to config these and ACPI in or out, instead of having
the many different platform interface options in different logical areas.

My 2c -- Regards -- Andy
