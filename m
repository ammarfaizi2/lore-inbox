Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVDDT6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVDDT6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVDDT6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:58:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:41672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261360AbVDDT5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:57:36 -0400
Message-ID: <42519BF0.8090404@osdl.org>
Date: Mon, 04 Apr 2005 12:56:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       ambx1@neo.rr.com
Subject: Re: [patch 1/3] pnpbios eliminate bad section references
References: <20050404181048.GA12394@sputnik.stro.at>
In-Reply-To: <20050404181048.GA12394@sputnik.stro.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> one of the last buildcheck errors on i386,
> thanks Randy again for double checking.
> 
> Fix pnpbios section references:
> make dmi_system_id pnpbios_dmi_table __initdata
> 
> Error: ./drivers/pnp/pnpbios/core.o .data refers to 00000100 R_386_32
> .init.text
> Error: ./drivers/pnp/pnpbios/core.o .data refers to 0000012c R_386_32
> .init.text
> 
> Signed-off-by: maximilian attems <janitor@sternwelten.at>
> 
> 
> --- linux-2.6.12-rc1-bk5/drivers/pnp/pnpbios/core.c.orig	2005-04-04 19:11:37.814477672 +0200
> +++ linux-2.6.12-rc1-bk5/drivers/pnp/pnpbios/core.c	2005-04-04 19:25:50.074402365 +0200
> @@ -512,7 +512,7 @@
>  	return 0;
>  }
>  
> -static struct dmi_system_id pnpbios_dmi_table[] = {
> +static struct dmi_system_id pnpbios_dmi_table[] __initdata = {
>  	{	/* PnPBIOS GPF on boot */
>  		.callback = exploding_pnp_bios,
>  		.ident = "Higraded P14H",

Looks OK to me, but I'd prefer to leave it up to Adam.....

-- 
~Randy


