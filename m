Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130721AbRCPQ7f>; Fri, 16 Mar 2001 11:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130722AbRCPQ7Z>; Fri, 16 Mar 2001 11:59:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:56501 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130721AbRCPQ7U>;
	Fri, 16 Mar 2001 11:59:20 -0500
Date: Fri, 16 Mar 2001 11:58:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Dike <jdike@karaya.com>
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        engler@csl.Stanford.EDU, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] big stack variables 
In-Reply-To: <200103161757.MAA01897@ccure.karaya.com>
Message-ID: <Pine.GSO.4.21.0103161154060.12618-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Mar 2001, Jeff Dike wrote:

> +#endif
> +#ifdef CONFIG_STDIO_CONSOLE
> +	stdio_console_init();
>  #endif

Erm... That piece is UML-only.

ObUML: something fishy happens in UML with multiple exec() in PID 1. Try to
say "telinit u" (or just boot with init=/bin/sh and say exec /sbin/init)
and you've got a nice panic()...

