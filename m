Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVB0Brq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVB0Brq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 20:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVB0Brq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 20:47:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:47590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261340AbVB0Bro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 20:47:44 -0500
Message-ID: <42212422.6080201@osdl.org>
Date: Sat, 26 Feb 2005 17:36:34 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more apic.c
References: <20050226150357.GA19651@apps.cwi.nl>
In-Reply-To: <20050226150357.GA19651@apps.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> setup_APIC_timer is only called in __init context and uses __initdata
> 
> Andries
> 
> diff -uprN -X /linux/dontdiff a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
> --- a/arch/i386/kernel/apic.c	2005-02-26 12:13:28.000000000 +0100
> +++ b/arch/i386/kernel/apic.c	2005-02-26 16:13:21.000000000 +0100
> @@ -930,7 +930,7 @@ void __setup_APIC_LVTT(unsigned int cloc
>  	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
>  }
>  
> -static void setup_APIC_timer(unsigned int clocks)
> +static void __init setup_APIC_timer(unsigned int clocks)
>  {
>  	unsigned long flags;

Ack.
http://marc.theaimsgroup.com/?l=linux-kernel&m=108727726207069&w=2

-- 
~Randy
