Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbTBNRf5>; Fri, 14 Feb 2003 12:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbTBNRf4>; Fri, 14 Feb 2003 12:35:56 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:35241 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S263326AbTBNRfz>;
	Fri, 14 Feb 2003 12:35:55 -0500
Date: Fri, 14 Feb 2003 17:41:25 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Toplica Tanaskovic <toptan@EUnet.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 KT400 support
Message-ID: <20030214174125.GA2694@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Toplica Tanaskovic <toptan@EUnet.yu>, linux-kernel@vger.kernel.org
References: <200302141821.14768.toptan@EUnet.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302141821.14768.toptan@EUnet.yu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 06:25:52PM +0100, Toplica Tanaskovic wrote:

 > 	Here is the patch that adds complete support for Via KT400 chipsets for 
 > 2.4.18 kernel

Not complete. This will only work if you have an AGP2.0 card.
There is no code here to setup the bridge in AGP3.0 mode, or handling
what happens when it sees a x8 card.  Fully working code is present in
2.5.60-bk if you have time to backport it (hint: I don't right now)
 
 > 	Don't forget to update yours pci.ids, before applying this patch don't forget 
 > to update your pci.ids to the latest version.

Has no relevance to the patch. pci.ids is only used by pciutils, and
should not affect behaviour of this agp/ide patch.

Also..

> +	{ PCI_DEVICE_ID_VIA_8377_0,
> +		PCI_VENDOR_ID_VIA,
> +		VIA_APOLLO_KT400,
> +		"Via",

Should be capitalised 'VIA'.

> --- orig/linux/drivers/ide/via82cxxx.c	Wed Mar 27 13:57:19 2002
> +++ linux/drivers/ide/via82cxxx.c	Tue Feb 11 22:39:28 2003
> @@ -105,8 +105,8 @@
>  } via_isa_bridges[] = {
>  #ifdef FUTURE_BRIDGES
>  	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
> -	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
>  #endif
> +	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },

Already in 2.4-bk

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
