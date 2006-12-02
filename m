Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163018AbWLBOdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163018AbWLBOdr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 09:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163021AbWLBOdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 09:33:47 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:1195 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S1163018AbWLBOdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 09:33:46 -0500
Message-ID: <45718EC8.9020407@f2s.com>
Date: Sat, 02 Dec 2006 14:33:44 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Thunderbird 2.0a1 (X11/20061107)
MIME-Version: 1.0
To: Yan Burman <burman.yan@gmail.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 2.6.19] arm26: replace kmalloc+memset with kzalloc
References: <1165058589.4523.23.camel@localhost>
In-Reply-To: <1165058589.4523.23.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yan Burman wrote:
> Replace kmalloc+memset with kzalloc 
> 
 > Acked-by: Ian Molton <spyro@f2s.com>
> Signed-off-by: Yan Burman <burman.yan@gmail.com>
> 
> diff -rubp linux-2.6.19-rc5_orig/arch/arm26/kernel/ecard.c linux-2.6.19-rc5_kzalloc/arch/arm26/kernel/ecard.c
> --- linux-2.6.19-rc5_orig/arch/arm26/kernel/ecard.c	2006-11-09 12:16:22.000000000 +0200
> +++ linux-2.6.19-rc5_kzalloc/arch/arm26/kernel/ecard.c	2006-11-11 22:44:04.000000000 +0200
> @@ -620,12 +620,10 @@ ecard_probe(int slot, card_type_t type)
>  	struct ex_ecid cid;
>  	int i, rc = -ENOMEM;
>  
> -	ec = kmalloc(sizeof(ecard_t), GFP_KERNEL);
> +	ec = kzalloc(sizeof(ecard_t), GFP_KERNEL);
>  	if (!ec)
>  		goto nomem;
>  
> -	memset(ec, 0, sizeof(ecard_t));
> -
>  	ec->slot_no	= slot;
>  	ec->type        = type;
>  	ec->irq		= NO_IRQ;
> 
> 
> 
> 
> 
> 

