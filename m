Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVCNWhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVCNWhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVCNWew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:34:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:46529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262051AbVCNW3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:29:08 -0500
Message-ID: <4236102A.8050700@osdl.org>
Date: Mon, 14 Mar 2005 14:28:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [patch] elsa eliminate bad section references
References: <20050314002838.GB13729@sputnik.stro.at>
In-Reply-To: <20050314002838.GB13729@sputnik.stro.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> Fix elsa section references:
>   convert __initdata to __devinitdata.
> 
> Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003d28 R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003d37 R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003d56 R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003d77 R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003ddb R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003e0e R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/elsa.o .text refers to 00003e20 R_386_32
> .init.data
> 
> Signed-off-by: maximilian attems <janitor@sternwelten.at>

Acked-by: Randy Dunlap <rddunlap@osdl.org>

> diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/elsa.c
> linux-2.6.11-bk8-max/drivers/isdn/hisax/elsa.c
> --- linux-2.6.11-bk8/drivers/isdn/hisax/elsa.c	2005-03-02 08:37:49.000000000 +0100
> +++ linux-2.6.11-bk8-max/drivers/isdn/hisax/elsa.c	2005-03-14 01:04:02.000000000 +0100
> @@ -838,7 +838,7 @@ static 	struct pci_dev *dev_qs1000 __dev
>  static 	struct pci_dev *dev_qs3000 __devinitdata = NULL;
>  
>  #ifdef __ISAPNP__
> -static struct isapnp_device_id elsa_ids[] __initdata = {
> +static struct isapnp_device_id elsa_ids[] __devinitdata = {
>  	{ ISAPNP_VENDOR('E', 'L', 'S'), ISAPNP_FUNCTION(0x0133),
>  	  ISAPNP_VENDOR('E', 'L', 'S'), ISAPNP_FUNCTION(0x0133), 
>  	  (unsigned long) "Elsa QS1000" },
> @@ -848,7 +848,7 @@ static struct isapnp_device_id elsa_ids[
>  	{ 0, }
>  };
>  
> -static struct isapnp_device_id *ipid __initdata = &elsa_ids[0];
> +static struct isapnp_device_id *ipid __devinitdata = &elsa_ids[0];
>  static struct pnp_card *pnp_c __devinitdata = NULL;
>  #endif
>  


-- 
~Randy
