Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVLLF74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVLLF74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 00:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVLLF74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 00:59:56 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:63160 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750852AbVLLF7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 00:59:55 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] ACX should select, not depend on FW_LOADER
Date: Mon, 12 Dec 2005 07:59:26 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20051211182901.GP23349@stusta.de>
In-Reply-To: <20051211182901.GP23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512120759.26814.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 20:29, Adrian Bunk wrote:
> If a driver needs FW_LOADER, it should select this option, not depend on 
> it.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.15-rc5-mm2-full/drivers/net/wireless/tiacx/Kconfig.old	2005-12-11 19:04:49.000000000 +0100
> +++ linux-2.6.15-rc5-mm2-full/drivers/net/wireless/tiacx/Kconfig	2005-12-11 19:05:08.000000000 +0100
> @@ -1,6 +1,7 @@
>  config ACX
>  	tristate "TI acx100/acx111 802.11b/g wireless chipsets"
> -	depends on NET_RADIO && EXPERIMENTAL && FW_LOADER && (USB || PCI)
> +	depends on NET_RADIO && EXPERIMENTAL && (USB || PCI)
> +	select FW_LOADER
>  	---help---
>  	A driver for 802.11b/g wireless cards based on
>  	Texas Instruments acx100 and acx111 chipsets.

Applied to acx, thanks!
--
vda
