Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261827AbRFAWm0>; Fri, 1 Jun 2001 18:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbRFAWmR>; Fri, 1 Jun 2001 18:42:17 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:62992 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261827AbRFAWmC>; Fri, 1 Jun 2001 18:42:02 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200106012054.WAA01139@kufel.dom>
Subject: Re: PATCH: cs4232 isapnp support
To: kufel!caldera.de!Marcus.Meissner@green.mif.pg.gda.pl (Marcus Meissner)
Date: Fri, 1 Jun 2001 22:54:57 +0200 (CEST)
Cc: kufel!lxorguk.ukuu.org.uk!alan@green.mif.pg.gda.pl (Alan Cox),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <20010601193533.A14769@caldera.de> from "Marcus Meissner" at cze 01, 2001 07:35:33 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> This adds ISAPnP support to cs4232.c.
[...]
> diff -u -r1.10 cs4232.c
> --- drivers/sound/cs4232.c	2001/05/27 18:06:09	1.10
> +++ drivers/sound/cs4232.c	2001/06/01 17:26:52
[...]
> @@ -318,22 +325,92 @@
>  static int __initdata mpuirq	= -1;
>  static int __initdata synthio	= -1;
>  static int __initdata synthirq	= -1;
> -
> +static int __initdata isapnp	= 1;

According to the comment in include/linux/init.h these are incorrect:

 * For initialized data:
 * You should insert __initdata between the variable name and equal
 * sign followed by value, e.g.:
 *
 * static int init_variable __initdata = 0;
 * static char linux_logo[] __initdata = { 0x32, 0x36, ... };
 *

AFAIR, moving the __initdata cause problems with some gcc versions.

Andrzej


