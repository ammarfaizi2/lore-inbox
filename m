Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTK0UsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 15:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbTK0UsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 15:48:17 -0500
Received: from hsp51.hspserver.com ([213.131.231.14]:42955 "HELO
	hsp51.hspserver.com") by vger.kernel.org with SMTP id S261226AbTK0UsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 15:48:14 -0500
From: "Timo Kamph" <timo@kamph.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Date: Thu, 27 Nov 2003 21:48:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2.6]: IPv4: strcpy -> strlcpy
CC: linux-kernel@vger.kernel.org
Message-ID: <3FC67128.14704.30155D53@localhost>
In-reply-to: <1069946737.10246.1.camel@glass.felipe-alfaro.com>
References: <20031127142125.GG8276@jdj5.mit.edu>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Nov 2003 at 16:25, Felipe Alfaro Solana wrote:

> --- linux-2.6.0-test11.orig/net/ipv4/netfilter/ipchains_core.c	2003-11-26 21:45:26.000000000 +0100
> +++ linux-2.6.0-test11/net/ipv4/netfilter/ipchains_core.c	2003-11-27 13:28:39.884442527 +0100
> @@ -1173,7 +1173,7 @@
>  		= kmalloc(SIZEOF_STRUCT_IP_CHAIN, GFP_KERNEL);
>  	if (label == NULL)
>  		panic("Can't kmalloc for firewall chains.\n");
> -	strcpy(label->label,name);
> +	strlcpy(label->label, name, sizeof(label->name));
                                                                       ^^^^^^
I guess this shoud be label->label, or am I wrong?

	Timo
