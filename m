Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSGYQhe>; Thu, 25 Jul 2002 12:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSGYQhe>; Thu, 25 Jul 2002 12:37:34 -0400
Received: from www.transvirtual.com ([206.14.214.140]:12042 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315214AbSGYQhe>; Thu, 25 Jul 2002 12:37:34 -0400
Date: Thu, 25 Jul 2002 09:40:39 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@irongate.swansea.linux.org.uk>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.5.28 (resend #1) Q40 keyboard
In-Reply-To: <200207251445.g6PEjs17010417@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207250940010.10162-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Strange. I placed that patch in the input BK. I guess it didn't sync up
yet.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

On Thu, 25 Jul 2002, Alan Cox wrote:

> The Q40 keyboard is only found on a Q40..
>
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/input/serio/Config.in linux-2.5.28-ac1/drivers/input/serio/Config.in
> --- linux-2.5.28/drivers/input/serio/Config.in	Thu Jul 25 10:49:21 2002
> +++ linux-2.5.28-ac1/drivers/input/serio/Config.in	Sun Jul 21 15:38:48 2002
> @@ -12,7 +12,9 @@
>  fi
>  dep_tristate '  Serial port line discipline' CONFIG_SERIO_SERPORT $CONFIG_SERIO
>  dep_tristate '  ct82c710 Aux port controller' CONFIG_SERIO_CT82C710 $CONFIG_SERIO
> -dep_tristate '  Q40 keyboard controller' CONFIG_SERIO_Q40KBD $CONFIG_SERIO
> +if [ "$CONFIG_Q40" = "y" ]; then
> +   dep_tristate '  Q40 keyboard controller' CONFIG_SERIO_Q40KBD $CONFIG_SERIO
> +fi
>  dep_tristate '  Parallel port keyboard adapter' CONFIG_SERIO_PARKBD $CONFIG_SERIO $CONFIG_PARPORT
>
>  if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

