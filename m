Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275027AbTHAOgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 10:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275119AbTHAOgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 10:36:36 -0400
Received: from lidskialf.net ([62.3.233.115]:19430 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S275027AbTHAOgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 10:36:35 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Andrew Morton <akpm@osdl.org>, Michael Bakos <bakhos@msi.umn.edu>
Subject: Re: compile error for Opteron CPU with kernel 2.6.0-test2
Date: Fri, 1 Aug 2003 15:36:38 +0100
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <20030731182705.5b4f2b33.akpm@osdl.org> <Pine.SGI.4.33.0307312127190.23643-100000@ir12.msi.umn.edu> <20030731212105.75fb4191.akpm@osdl.org>
In-Reply-To: <20030731212105.75fb4191.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308011536.38015.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK, I'd be doing this:
>
>  arch/x86_64/kernel/mpparse.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
>
> diff -puN arch/x86_64/kernel/mpparse.c~nforce2-acpi-fixes-fix
> arch/x86_64/kernel/mpparse.c ---
> 25/arch/x86_64/kernel/mpparse.c~nforce2-acpi-fixes-fix	2003-07-31
> 21:18:45.000000000 -0700 +++
> 25-akpm/arch/x86_64/kernel/mpparse.c	2003-07-31 21:18:59.000000000 -0700 @@
> -896,7 +896,8 @@ void __init mp_parse_prt (void)
>
>  		/* Need to get irq for dynamic entry */
>  		if (entry->link.handle) {
> -			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
> +			irq = acpi_pci_link_get_irq(entry->link.handle,
> +				entry->link.index, NULL, NULL);
>  			if (!irq)
>  			continue;
>  		}
>
> _

Great, thanks very much.

