Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967244AbWLEXAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967244AbWLEXAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967282AbWLEXAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:00:07 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51560 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967244AbWLEXAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:00:05 -0500
Message-ID: <4575F929.9020708@us.ibm.com>
Date: Tue, 05 Dec 2006 14:56:41 -0800
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA and SiS AGP chipsets are x86-only
References: <20061204104314.GB3013@parisc-linux.org>
In-Reply-To: <20061204104314.GB3013@parisc-linux.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matthew Wilcox wrote:
> There's no point in troubling the Alpha, IA-64, PowerPC and PARISC
> people with SiS and VIA options.  Andrew thinks it helps find bugs,
> but there's no evidence of that.
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> 
> diff --git a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
> index c603bf2..a9f9c48 100644
> --- a/drivers/char/agp/Kconfig
> +++ b/drivers/char/agp/Kconfig
> @@ -86,7 +86,7 @@ config AGP_NVIDIA
> 
>  config AGP_SIS
>  	tristate "SiS chipset support"
> -	depends on AGP
> +	depends on AGP && X86
>  	help
>  	  This option gives you AGP support for the GLX component of
>  	  X on Silicon Integrated Systems [SiS] chipsets.
> @@ -103,7 +103,7 @@ config AGP_SWORKS
> 
>  config AGP_VIA
>  	tristate "VIA chipset support"
> -	depends on AGP
> +	depends on AGP && X86
>  	help
>  	  This option gives you AGP support for the GLX component of
>  	  X on VIA MVP3/Apollo Pro chipsets.

I don't know about SiS, but this is certainly *not* true for Via.  There
are some PowerPC and, IIRC, Alpha motherboards that have Via chipsets.
My config-fu isn't quite what it should be, so this may be a dumb
question.  Does the "& X86" requirement exclude x86-64?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFdfkpX1gOwKyEAw8RAmh9AJ42g79Q9isQ0mzy87ILFn8pyW9AjACfWFdu
DvPS3GGDJyFfYfaf/8b5H4Y=
=NlmP
-----END PGP SIGNATURE-----
