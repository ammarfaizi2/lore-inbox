Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWASWMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWASWMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWASWMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:12:13 -0500
Received: from xenotime.net ([66.160.160.81]:16874 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422658AbWASWML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:12:11 -0500
Date: Thu, 19 Jan 2006 14:12:11 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: EDAC config cleanup
In-Reply-To: <20060119221006.GA31404@redhat.com>
Message-ID: <Pine.LNX.4.58.0601191411560.11660@shark.he.net>
References: <20060119221006.GA31404@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Dave Jones wrote:

> The AMD76x chipsets aren't used in 64-bit, so don't
> offer the driver to the user.
>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
> --- linux-2.6.15.noarch/drivers/edac/Kconfig~	2006-01-19 17:00:16.000000000 -0500
> +++ linux-2.6.15.noarch/drivers/edac/Kconfig	2006-01-19 17:03:33.000000000 -0500
> @@ -46,7 +46,7 @@ config EDAC_MM_EDAC
>
>  config EDAC_AMD76X
>  	tristate "AMD 76x (760, 762, 768)"
> -	depends on EDAC_MM_EDAC  && PCI
> +	depends on EDAC_MM_EDAC && PCI X86_32
                                      ^ && ???

>  	help
>  	  Support for error detection and correction on the AMD 76x
>  	  series of chipsets used with the Athlon processor.
> -

-- 
~Randy
