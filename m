Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWFUP6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWFUP6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFUP6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:58:43 -0400
Received: from witte.sonytel.be ([80.88.33.193]:42677 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750754AbWFUP6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:58:43 -0400
Date: Wed, 21 Jun 2006 17:58:24 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marc Singer <elf@buici.com>
cc: Russell King <rmk+kernel@arm.linux.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [ARM] 3404/1: lpd7a40x: AMBA CLCD support
In-Reply-To: <200606202259.k5KMxpaK003582@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0606211756350.2222@pademelon.sonytel.be>
References: <200606202259.k5KMxpaK003582@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Linux Kernel Mailing List wrote:
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig

Please check grammar/spelling/logic in the help texts.

> @@ -167,6 +167,69 @@ config FB_ARMCLCD
>  	  here and read <file:Documentation/modules.txt>.  The module
>  	  will be called amba-clcd.
>  
> +choice
> +
> +	depends on FB_ARMCLCD && (ARCH_LH7A40X || ARCH_LH7952X)
> +	prompt "LCD Panel"
> +	default FB_ARMCLCD_SHARP_LQ035Q7DB02
> +
> +config FB_ARMCLCD_SHARP_LQ035Q7DB02_HRTFT
> +	bool "LogicPD LCD 3.5\" QVGA w/HRTFT IC"
> +	help
> +	  This is an implementation of the Sharp LQ035Q7DB02, a 3.5"
> +	  color QVGA, HRTFT panel.  The LogicPD device includes an
                                                                ^^
> +	  an integrated HRTFT controller IC.
          ^^
> +	  The native resolution is 240x320.
> +
> +config FB_ARMCLCD_SHARP_LQ057Q3DC02
> +	bool "LogicPD LCD 5.7\" QVGA"
> +	help
> +	  This is an implementation of the Sharp LQ057Q3DC02, a 5.7"
> +	  color QVGA, TFT panel.  The LogicPD device includes an
                                                                 ^^^^
> +	  The native resolution is 320x240.
> +
> +config FB_ARMCLCD_SHARP_LQ64D343
> +	bool "LogicPD LCD 6.4\" VGA"
> +	help
> +	  This is an implementation of the Sharp LQ64D343, a 6.4"
> +	  color VGA, TFT panel.  The LogicPD device includes an
                                                                 ^^^^
> +	  The native resolution is 640x480.
> +
> +config FB_ARMCLCD_SHARP_LQ10D368
> +	bool "LogicPD LCD 10.4\" VGA"
> +	help
> +	  This is an implementation of the Sharp LQ10D368, a 10.4"
> +	  color VGA, TFT panel.  The LogicPD device includes an
                                                                 ^^^^
> +	  The native resolution is 640x480.
> +
> +
> +config FB_ARMCLCD_SHARP_LQ121S1DG41
> +	bool "LogicPD LCD 12.1\" SVGA"
> +	help
> +	  This is an implementation of the Sharp LQ121S1DG41, a 12.1"
> +	  color SVGA, TFT panel.  The LogicPD device includes an
                                                                 ^^^^
> +	  The native resolution is 800x600.
> +
> +	  This panel requires a clock rate may be an integer fraction
                                         ^^^^
					 which?

> +	  of the base LCDCLK frequency.  The driver will select the
> +	  highest frequency available that is lower than the maximum
> +	  allowed.  The panel may flicker if the clock rate is
> +	  slower than the recommended minimum.
          ^^^^^^
	  lower
> +
> +config FB_ARMCLCD_AUO_A070VW01_WIDE
> +	bool "AU Optronics A070VW01 LCD 7.0\" WIDE"
> +	help
> +	  This is an implementation of the AU Optronics, a 7.0"
> +	  WIDE Color.  The native resolution is 234x480.
> +
> +config FB_ARMCLCD_HITACHI
> +	bool "Hitachi Wide Screen 800x480"
> +	help
> +	  This is an implementation of the Hitachi 800x480.
> +
> +endchoice
> +
> +

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
