Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUJJQiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUJJQiE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 12:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUJJQiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 12:38:04 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:36262 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S268339AbUJJQiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 12:38:00 -0400
Message-ID: <41696607.2020602@conectiva.com.br>
Date: Sun, 10 Oct 2004 13:40:39 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] __initdata strings
References: <4169551D.A884778D@tv-sign.ru> <20041010163153.GJ31237@waste.org>
In-Reply-To: <20041010163153.GJ31237@waste.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.046876, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matt Mackall wrote:
> On Sun, Oct 10, 2004 at 07:28:29PM +0400, Oleg Nesterov wrote:
> 
>>Hello.
>>
>>This patch is not intended for inclusion, just for illustration.
>>
>>__init functions leaves strings (mainly printk's arguments) in
>>.data section. It make sense to move them in .init.data.
> 
> 
> Probably better to do this with something like objcopy?
> 

Yes, this is another way of doing that, but the kernel has to be
prepared to get such treatment, think about register functions
that only save a pointer to strings passed from __init functions...

Ah, nothing related to this specific way of doing what is intended,
any scheme that moves strings in __init functions to .data.init has
to deal with this.

- Arnaldo



