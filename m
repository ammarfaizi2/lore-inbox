Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVCNWdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVCNWdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVCNW30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:29:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:58816 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262032AbVCNWZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:25:52 -0500
Message-ID: <42360F69.1060806@osdl.org>
Date: Mon, 14 Mar 2005 14:25:45 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [patch] teles3 eliminate bad section references
References: <20050314000527.GA13729@sputnik.stro.at>
In-Reply-To: <20050314000527.GA13729@sputnik.stro.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> Fix teles3 section references:
>   convert __initdata to __devinitdata.
> 
> Error: ./drivers/isdn/hisax/teles3.o .text refers to 000011ab R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/teles3.o .text refers to 000011ba R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/teles3.o .text refers to 000011e0 R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/teles3.o .text refers to 000011fd R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/teles3.o .text refers to 0000128c R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/teles3.o .text refers to 00001294 R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/teles3.o .text refers to 000012a6 R_386_32
> .init.data
> 
> 
> Signed-off-by: maximilian attems <janitor@sternwelten.at>

Acked-by: Randy Dunlap <rddunlap@osdl.org>


> diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/teles3.c
> linux-2.6.11-bk8-max/drivers/isdn/hisax/teles3.c
> --- linux-2.6.11-bk8/drivers/isdn/hisax/teles3.c	2005-03-02 08:38:33.000000000 +0100
> +++ linux-2.6.11-bk8-max/drivers/isdn/hisax/teles3.c	2005-03-14 00:47:32.000000000 +0100
> @@ -254,7 +254,7 @@ Teles_card_msg(struct IsdnCardState *cs,
>  
>  #ifdef __ISAPNP__
>  
> -static struct isapnp_device_id teles_ids[] __initdata = {
> +static struct isapnp_device_id teles_ids[] __devinitdata = {
>  	{ ISAPNP_VENDOR('T', 'A', 'G'), ISAPNP_FUNCTION(0x2110),
>  	  ISAPNP_VENDOR('T', 'A', 'G'), ISAPNP_FUNCTION(0x2110), 
>  	  (unsigned long) "Teles 16.3 PnP" },
> @@ -267,7 +267,7 @@ static struct isapnp_device_id teles_ids
>  	{ 0, }
>  };
>  
> -static struct isapnp_device_id *ipid __initdata = &teles_ids[0];
> +static struct isapnp_device_id *ipid __devinitdata = &teles_ids[0];
>  static struct pnp_card *pnp_c __devinitdata = NULL;
>  #endif
>  


-- 
~Randy
