Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbUKQAsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbUKQAsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUKQApy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:45:54 -0500
Received: from mail.dif.dk ([193.138.115.101]:10936 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262146AbUKQAm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:42:56 -0500
Date: Wed, 17 Nov 2004 01:52:08 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, davem@davemloft.net
Subject: Re: [PATCH 1/2] - net/socket.c::sys_bind() cleanup.
In-Reply-To: <20041116185517.3314ac35.lcapitulino@conectiva.com.br>
Message-ID: <Pine.LNX.4.61.0411170109020.3444@dragon.hygekrogen.localhost>
References: <20041116185517.3314ac35.lcapitulino@conectiva.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Luiz Fernando N. Capitulino wrote:

> 
>  Hi,
> 
>  net/socket.c::sys_bind() is a bit complex function, the patch
> bellow makes it more clear.
> 
>  Note that the code does the same thing, it only makes difference
> for the programmer.
> 
Not exactely : 


> -		if((err=move_addr_to_kernel(umyaddr,addrlen,address))>=0) {

> +	err = move_addr_to_kernel(umyaddr, addrlen, address);
> +	if (err)
> +		goto out_put;


The original tests for err >= 0, your replacement tests if err is != 0


--
Jesper Juhl

