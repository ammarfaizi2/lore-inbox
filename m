Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbTIFBWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbTIFBWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:22:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56987 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265681AbTIFBWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:22:39 -0400
Message-ID: <3F5936D2.3060502@pobox.com>
Date: Fri, 05 Sep 2003 21:22:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew de Quincey <adq_dvb@lidskialf.net>
CC: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, linux-acpi@intel.com,
       Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com> <200309060157.47121.adq_dvb@lidskialf.net>
In-Reply-To: <200309060157.47121.adq_dvb@lidskialf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey wrote:
> This patch removes some erroneous code from mpparse which breaks IO-APIC programming
> 
> 
> --- linux-2.6.0-test4.null_crs/arch/i386/kernel/mpparse.c	2003-09-06 00:23:10.000000000 +0100
> +++ linux-2.6.0-test4.duffmpparse/arch/i386/kernel/mpparse.c	2003-09-06 00:28:23.788124872 +0100
> @@ -1129,9 +1129,6 @@
>  			continue;
>  		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
>  
> -		if (!ioapic && (irq < 16))
> -			irq += 16;
> -


Even though I've been digging through stuff off and on, I consider 
myself pretty darn IOAPIC-clueless.  Mikael, does this look sane to you?

