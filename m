Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVCNWhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVCNWhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVCNWdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:33:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:30402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262041AbVCNWcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:32:16 -0500
Message-ID: <423610EC.3030508@osdl.org>
Date: Mon, 14 Mar 2005 14:32:12 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [patch] sedlbauer eliminate bad section references
References: <20050314003018.GD13729@sputnik.stro.at>
In-Reply-To: <20050314003018.GD13729@sputnik.stro.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> Fix sedlbauer section references:
>   convert __initdata to __devinitdata.
> 
> 
> Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 0000235f R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 0000236e R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 0000238d R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 000023b2 R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 00002417 R_386_32
> .init.data
> Error: ./drivers/isdn/hisax/sedlbauer.o .text refers to 0000244c R_386_32
> .init.data
> 
> Signed-off-by: maximilian attems <janitor@sternwelten.at>

Acked-by: Randy Dunlap <rddunlap@osdl.org>

> diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/sedlbauer.c
> linux-2.6.11-bk8-max/drivers/isdn/hisax/sedlbauer.c
> --- linux-2.6.11-bk8/drivers/isdn/hisax/sedlbauer.c	2005-03-02 08:38:32.000000000 +0100
> +++ linux-2.6.11-bk8-max/drivers/isdn/hisax/sedlbauer.c	2005-03-14 01:03:14.000000000 +0100
> @@ -516,7 +516,7 @@ Sedl_card_msg(struct IsdnCardState *cs, 
>  static struct pci_dev *dev_sedl __devinitdata = NULL;
>  
>  #ifdef __ISAPNP__
> -static struct isapnp_device_id sedl_ids[] __initdata = {
> +static struct isapnp_device_id sedl_ids[] __devinitdata = {
>  	{ ISAPNP_VENDOR('S', 'A', 'G'), ISAPNP_FUNCTION(0x01),
>  	  ISAPNP_VENDOR('S', 'A', 'G'), ISAPNP_FUNCTION(0x01), 
>  	  (unsigned long) "Speed win" },
> @@ -526,7 +526,7 @@ static struct isapnp_device_id sedl_ids[
>  	{ 0, }
>  };
>  
> -static struct isapnp_device_id *ipid __initdata = &sedl_ids[0];
> +static struct isapnp_device_id *ipid __devinitdata = &sedl_ids[0];
>  static struct pnp_card *pnp_c __devinitdata = NULL;
>  #endif
>  


-- 
~Randy
