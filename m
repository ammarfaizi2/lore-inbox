Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312124AbSCVWTp>; Fri, 22 Mar 2002 17:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312868AbSCVWTf>; Fri, 22 Mar 2002 17:19:35 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:47885 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312124AbSCVWTS>; Fri, 22 Mar 2002 17:19:18 -0500
Date: Fri, 22 Mar 2002 18:13:48 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Don't offer CONFIG_INDYDOG on non-ip22 machines
In-Reply-To: <Pine.NEB.4.44.0203211258110.2125-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.21.0203221813370.10951-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Mar 2002, Adrian Bunk wrote:

> After reading Documentation/kbuild/config-language.txt it seems that this
> should work in theory...
> 
> The following patch fixes it so that it works for me:
> 
> --- drivers/char/Config.in.old	Thu Mar 21 12:48:57 2002
> +++ drivers/char/Config.in	Thu Mar 21 13:01:21 2002
> @@ -201,7 +201,9 @@
>     tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
>     tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
>     tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
> -   dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG $CONFIG_SGI_IP22
> +   if [ "$CONFIG_SGI_IP22" = "y" ]; then
> +      tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG
> +   fi
>  fi
>  endmenu
> 

Applied...

