Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSFOIiG>; Sat, 15 Jun 2002 04:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSFOIiF>; Sat, 15 Jun 2002 04:38:05 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:5272 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315171AbSFOIiE>; Sat, 15 Jun 2002 04:38:04 -0400
Date: Sat, 15 Jun 2002 10:09:24 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][TRIVIAL] Print a KERN_INFO after a module gets loaded 
In-Reply-To: <Pine.LNX.4.44.0206150035290.5254-100000@alumno.inacap.cl>
Message-ID: <Pine.LNX.4.44.0206151007420.30400-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Robinson Maureira Castillo wrote:

> diff -Nrua linux/kernel/module.c linux-info/kernel/module.c
> --- linux/kernel/module.c       Sat Jun 15 01:00:24 2002
> +++ linux-info/kernel/module.c  Sat Jun 15 01:02:37 2002
> @@ -560,6 +560,7 @@
>  
>         /* And set it running.  */
>         mod->flags = (mod->flags | MOD_RUNNING) & ~MOD_INITIALIZING;
> +       printk(KERN_INFO "module: %s loaded\n", mod->name);
>         error = 0;
>         goto err0;

And when this gets to mainline, what stops your hacker from removing the 
printk from displaying? The way i see it, if the person is loading modules 
you're screwed beyond help.

Regards,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

