Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVCNWhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVCNWhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVCNWeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:34:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:64193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262026AbVCNWat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:30:49 -0500
Message-ID: <42361094.6070805@osdl.org>
Date: Mon, 14 Mar 2005 14:30:44 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [patch] hfc_sx eliminate bad section references
References: <20050314002954.GC13729@sputnik.stro.at>
In-Reply-To: <20050314002954.GC13729@sputnik.stro.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> Fix hfc_sx section references:
>   convert __initdata to __devinitdata.
> 
> Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 0000204d R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 0000205c R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 00002082 R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 0000209f R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 00002114 R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 0000211c R_386_32          
> .init.data
> Error: ./drivers/isdn/hisax/hfc_sx.o .text refers to 0000212e R_386_32
> .init.data
> 
> Signed-off-by: maximilian attems <janitor@sternwelten.at>

Acked-by: Randy Dunlap <rddunlap@osdl.org>

> diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/hfc_sx.c
> linux-2.6.11-bk8-max/drivers/isdn/hisax/hfc_sx.c
> --- linux-2.6.11-bk8/drivers/isdn/hisax/hfc_sx.c	2005-03-02 08:37:48.000000000 +0100
> +++ linux-2.6.11-bk8-max/drivers/isdn/hisax/hfc_sx.c	2005-03-14 01:03:42.000000000 +0100
> @@ -1382,14 +1382,14 @@ hfcsx_card_msg(struct IsdnCardState *cs,
>  }
>  
>  #ifdef __ISAPNP__
> -static struct isapnp_device_id hfc_ids[] __initdata = {
> +static struct isapnp_device_id hfc_ids[] __devinitdata = {
>  	{ ISAPNP_VENDOR('T', 'A', 'G'), ISAPNP_FUNCTION(0x2620),
>  	  ISAPNP_VENDOR('T', 'A', 'G'), ISAPNP_FUNCTION(0x2620), 
>  	  (unsigned long) "Teles 16.3c2" },
>  	{ 0, }
>  };
>  
> -static struct isapnp_device_id *ipid __initdata = &hfc_ids[0];
> +static struct isapnp_device_id *ipid __devinitdata = &hfc_ids[0];
>  static struct pnp_card *pnp_c __devinitdata = NULL;
>  #endif
>  


-- 
~Randy
