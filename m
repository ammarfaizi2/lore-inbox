Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVBNQEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVBNQEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 11:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVBNQEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 11:04:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:27039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261458AbVBNQEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 11:04:52 -0500
Date: Mon, 14 Feb 2005 08:04:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>, Len Brown <len.brown@intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make ACPI_BLACKLIST_YEAR depend on ACPI
In-Reply-To: <200502141130.51901@bilbo.math.uni-mannheim.de>
Message-ID: <Pine.LNX.4.58.0502140801570.15516@ppc970.osdl.org>
References: <200502141130.51901@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Feb 2005, Rolf Eike Beer wrote:
> 
> this oneliner fixes the situation that I can enter a year to blacklist
> ACPI devices if ACPI is completely disabled.
> 
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

Hmm.. Wouldn't it be even better to make it depend on ACPI_INTERPRETER? 
Afaik, the blacklist year is only ever used by the interperter, and the 
blacklist.c file isn't even built unless ACPI_INTERPRETER is on.

Len Brown added to check..

		Linus


> --- linux-2.6.11-rc3/drivers/acpi/Kconfig	2005-02-07 21:12:45.000000000 +0100
> +++ linux-2.6.11-rc3/drivers/acpi/Kconfig.fixed	2005-02-12 19:58:24.000000000 +0100
> @@ -259,6 +259,7 @@
>  
>  config ACPI_BLACKLIST_YEAR
>  	int "Disable ACPI for systems before Jan 1st this year"
> +	depends on ACPI
>  	default 0
>  	help
>  	  enter a 4-digit year, eg. 2001 to disable ACPI by default
> 
