Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132732AbRDIMdn>; Mon, 9 Apr 2001 08:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRDIMdb>; Mon, 9 Apr 2001 08:33:31 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:63929 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132732AbRDIMdN>; Mon, 9 Apr 2001 08:33:13 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200104091229.OAA00554@sunrise.pg.gda.pl>
Subject: Re: [PATCH] net drivers: missing __init's
To: pazke@orbita.don.sitek.net (Andrey Panin)
Date: Mon, 9 Apr 2001 14:29:55 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <20010409161152.B3723@debian> from "Andrey Panin" at Apr 09, 2001 04:11:52 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrey Panin wrote:"
> 
> attached patches add missing __init and (__devinit) to some network drivers:
> 	at1700.c, eepro.c, epic100.c, hamachi.c, sis900.c,=20
> 	tokenring/abyss.c, tokenring/tmsisa.c, tokenring/tmspci.c.
> 

> diff -ur -x *.o -x *.flags /linux.vanilla/drivers/net/tokenring/tmsisa.c /l=
> inux/drivers/net/tokenring/tmsisa.c
> --- /linux.vanilla/drivers/net/tokenring/tmsisa.c	Mon Apr  2 15:45:22 2001
> +++ /linux/drivers/net/tokenring/tmsisa.c	Sun Apr  8 18:18:51 2001
> @@ -19,7 +19,7 @@
>   *  TODO:
>   *	1. Add support for Proteon TR ISA adapters (1392, 1392+)
>   */
> -static const char *version = "tmsisa.c: v1.00 14/01/2001 by Jochen Friedrich\n";
> +static const char version[] __initdata = "tmsisa.c: v1.00 14/01/2001 by Jochen Friedrich\n";

You should move this line after 
#include <linux/init.h>

>  #include <linux/module.h>
>  #include <linux/kernel.h>

Andrzej

