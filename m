Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVDFKc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVDFKc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 06:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVDFKc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 06:32:58 -0400
Received: from farside.demon.co.uk ([62.49.25.247]:22776 "EHLO
	mail.farside.org.uk") by vger.kernel.org with ESMTP id S262159AbVDFKc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 06:32:57 -0400
References: <20050405225747.15125.8087.59570@clementine.local>
In-Reply-To: <20050405225747.15125.8087.59570@clementine.local>
From: Malcolm Rowe <malcolm-linux@farside.org.uk>
To: Magnus Damm <damm@opensource.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] disable built-in modules V2
Date: Wed, 06 Apr 2005 11:32:55 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <courier.4253BAD7.000018D2@mail.farside.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm writes:
> Here comes version 2 of the disable built-in patch.

> +void __init disable_initcall(void *fn)
> +{
> +	initcall_t *call;
> +
> +	for (call = __initcall_start; call < __initcall_end; call++) {
> +
> +		if (*call == fn)
> +			*call = NULL;
> +	}
> +}
 

Regardless of anything else, won't this break booting with initcall_debug on 
PPC64/IA64 machines? (see the definition of print_fn_descriptor_symbol() in 
kallsyms.h) 


Regards,
Malcolm
