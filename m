Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVJ0OFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVJ0OFB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 10:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVJ0OFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 10:05:01 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:2259 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750776AbVJ0OFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 10:05:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BiMpueOfE05P3umGBQVLUyMzRU4VW5DY7SwgRPlz9v7DWnOa91pjCUtNHw+d4wp8wf+gTehlAWbd2Ld4iWrO60rD9Yc9btZg7Q/0VLxgqC6PeZNtAQPbUZlFAUH7BLCP5Vo7yrB8YAZoO01qd4vTVoJ0btxt65b6ai/4p/ypf2o=
Message-ID: <4360DE89.6070802@gmail.com>
Date: Thu, 27 Oct 2005 10:04:57 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: vojtech@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
References: <200510271026.10913.ak@suse.de>
In-Reply-To: <200510271026.10913.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Remove most useless printk in the world

No way! I love that prink! =P

> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux/drivers/input/keyboard/atkbd.c
> ===================================================================
> --- linux/drivers/input/keyboard/atkbd.c
> +++ linux/drivers/input/keyboard/atkbd.c
> @@ -328,7 +328,6 @@ static irqreturn_t atkbd_interrupt(struc
>  			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
>  			goto out;
>  		case ATKBD_RET_ERR:
> -			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.
> \n", serio->phys);
>  			goto out;
>  	}
>  
