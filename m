Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUCUAz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 19:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUCUAz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 19:55:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20175 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263588AbUCUAzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 19:55:53 -0500
Message-ID: <405CE80B.9060503@pobox.com>
Date: Sat, 20 Mar 2004 19:55:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.26-pre5][x86_64] pci=noapci bogus warning
References: <200403202310.i2KNA3sp006345@harpo.it.uu.se>
In-Reply-To: <200403202310.i2KNA3sp006345@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> diff -ruN linux-2.4.26-pre5/arch/x86_64/kernel/pci-pc.c linux-2.4.26-pre5.x86_64-pci=noacpi-fix/arch/x86_64/kernel/pci-pc.c
> --- linux-2.4.26-pre5/arch/x86_64/kernel/pci-pc.c	2003-11-29 00:28:11.000000000 +0100
> +++ linux-2.4.26-pre5.x86_64-pci=noacpi-fix/arch/x86_64/kernel/pci-pc.c	2004-03-20 23:22:27.000000000 +0100
> @@ -645,6 +645,9 @@
>  	} else if (!strncmp(str, "lastbus=", 8)) {
>  		pcibios_last_bus = simple_strtol(str+8, NULL, 0);
>  		return NULL;
> +	} else if (!strncmp(str, "noacpi", 6)) {
> +		acpi_noirq_set();
> +		return NULL;
>  	}


Seem to me this runs afoul of the frequent "acpi"/"apic" typo...

	Jeff



