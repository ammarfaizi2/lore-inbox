Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVAJHOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVAJHOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 02:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVAJHOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 02:14:35 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:18368 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262129AbVAJHOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 02:14:21 -0500
Message-ID: <41E22B4F.4090402@drzeus.cx>
Date: Mon, 10 Jan 2005 08:14:23 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
References: <200501072250.j07MonUe012310@anakin.of.borg>
In-Reply-To: <200501072250.j07MonUe012310@anakin.of.borg>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> MMC_WBSD depends on ISA (needs isa_virt_to_bus())
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> --- linux-2.6.10/drivers/mmc/Kconfig	2004-12-26 10:47:03.000000000 +0100
> +++ linux-m68k-2.6.10/drivers/mmc/Kconfig	2005-01-01 10:35:09.000000000 +0100
> @@ -51,7 +51,7 @@ config MMC_PXA
>  
>  config MMC_WBSD
>  	tristate "Winbond W83L51xD SD/MMC Card Interface support"
> -	depends on MMC
> +	depends on MMC && ISA
>  	help
>  	  This selects the Winbond(R) W83L51xD Secure digital and
>            Multimedia card Interface.
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 

Thanks. Shouldn't have missed something so obvious :)

Russell, can you fix this in your next merge?

Rgds
Pierre
