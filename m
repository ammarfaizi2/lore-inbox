Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVCNWYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVCNWYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVCNWVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:21:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:27839 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262027AbVCNWT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:19:27 -0500
Message-ID: <42360DE5.3000600@osdl.org>
Date: Mon, 14 Mar 2005 14:19:17 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [patch] w6692 eliminate bad section references
References: <20050313230639.GA24301@sputnik.stro.at>
In-Reply-To: <20050313230639.GA24301@sputnik.stro.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> Fix w6692 section references:
>   convert __initdata to __devinitdata.
> 
> Error: ./drivers/isdn/hisax/w6692.o .text refers to 0000002f R_386_32
> .init.data
> 
> Signed-off-by: maximilian attems <janitor@sternwelten.at>
> 
> 
> diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/w6692.c 
> linux-2.6.11-bk8-max/drivers/isdn/hisax/w6692.c
> --- linux-2.6.11-bk8/drivers/isdn/hisax/w6692.c	2005-03-02 08:38:25.000000000 +0100
> +++ linux-2.6.11-bk8-max/drivers/isdn/hisax/w6692.c	2005-03-13 23:36:34.000000000 +0100
> @@ -45,7 +45,7 @@ const char *w6692_revision = "$Revision:
>  
>  #define DBUSY_TIMER_VALUE 80
>  
> -static char *W6692Ver[] __initdata =
> +static char *W6692Ver[] __devinitdata =
>  {"W6692 V00", "W6692 V01", "W6692 V10",
>   "W6692 V11"};
>  

I think the correct fix is to make W6692Version() be __init ...
What do you think of that?

-- 
~Randy
