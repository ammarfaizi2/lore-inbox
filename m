Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVCKSED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVCKSED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVCKSED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:04:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:33248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261237AbVCKSD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:03:56 -0500
Message-ID: <4231DD80.9020406@osdl.org>
Date: Fri, 11 Mar 2005 10:03:44 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [patch] cyrix eliminate bad section references
References: <20050311133036.GA10599@sputnik.stro.at>
In-Reply-To: <20050311133036.GA10599@sputnik.stro.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> Fix cyrix section references:
>  convert __initdata to __devinitdata.
> 
> Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .text refers to 00000379
> R_386_32          .init.data
> Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .text refers to 00000399
> R_386_32          .init.data
> Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .text refers to 000003b3
> R_386_32          .init.data
> Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .text refers to 000003b9
> R_386_32          .init.data
> Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .text refers to 000003bf
> R_386_32          .init.data
> 
> not many left on my .config, thanks Randy!

Yes, almost done.  :)

> 
> signed-of-by: maximilian attems <janitor@sternwelten.at>

Acked-by: Randy Dunlap <rddunlap@osdl.org>

> 
> diff -pruN -X dontdiff linux-2.6.11-bk6/arch/i386/kernel/cpu/mtrr/cyrix.c linux-2.6.11-bk6-max/arch/i386/kernel/cpu/mtrr/cyrix.c
> --- linux-2.6.11-bk6/arch/i386/kernel/cpu/mtrr/cyrix.c	2005-03-11 09:28:05.000000000 +0100
> +++ linux-2.6.11-bk6-max/arch/i386/kernel/cpu/mtrr/cyrix.c	2005-03-11 14:15:33.000000000 +0100
> @@ -218,12 +218,12 @@ typedef struct {
>  	mtrr_type type;
>  } arr_state_t;
>  
> -static arr_state_t arr_state[8] __initdata = {
> +static arr_state_t arr_state[8] __devinitdata = {
>  	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL},
>  	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}
>  };
>  
> -static unsigned char ccr_state[7] __initdata = { 0, 0, 0, 0, 0, 0, 0 };
> +static unsigned char ccr_state[7] __devinitdata = { 0, 0, 0, 0, 0, 0, 0 };
>  
>  static void cyrix_set_all(void)
>  {


-- 
~Randy
