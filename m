Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131038AbQKJPqw>; Fri, 10 Nov 2000 10:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131165AbQKJPqm>; Fri, 10 Nov 2000 10:46:42 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24329 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131038AbQKJPqb>;
	Fri, 10 Nov 2000 10:46:31 -0500
Message-ID: <3A0C1850.CF755AD0@mandrakesoft.com>
Date: Fri, 10 Nov 2000 10:46:24 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ballabio_Dario@emc.com
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH:  Pcmcia/Cardbus/xircom_tulip in 2.4.0-test10.
In-Reply-To: <51FA50304EBCD2119EEC00A0C9F2C9D0B1C427@ITMI1MX1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ballabio_Dario@emc.com wrote:
> 
> In order to have the xircom_tulip pcmcia cardbus working again with
> recent kernels, it is necessary to specify:
> 
> ifconfig eth0 -multicast
> 
> Moreover if the card is configured by itself into the kernel
> (i.e. with the default ne2000 pcmcia support removed),
> the enclosed patch is required as well.

Can you try the test11-pre2 patch?  It includes a bugfix to xircom_tulip
from Andrea.

ftp://ftp.??.kernel.org/pub/linux/kernel/testing/

?? == your country code, such as "us", "fr", etc.


> diff -r -u linux-2.4.0-test10/drivers/net/pcmcia/Config.in
> linux/drivers/net/pcmcia/Config.in
> --- linux-2.4.0-test10/drivers/net/pcmcia/Config.in     Sun Aug 13 19:21:20
> 2000
> +++ linux/drivers/net/pcmcia/Config.in  Wed Nov  1 17:55:18 2000
> @@ -36,7 +36,8 @@
>       "$CONFIG_PCMCIA_FMVJ18X" = "y" -o "$CONFIG_PCMCIA_PCNET" = "y" -o \
>       "$CONFIG_PCMCIA_NMCLAN" = "y" -o "$CONFIG_PCMCIA_SMC91C92" = "y" -o \
>       "$CONFIG_PCMCIA_XIRC2PS" = "y" -o "$CONFIG_PCMCIA_RAYCS" = "y" -o \
> -     "$CONFIG_PCMCIA_NETWAVE" = "y" -o "$CONFIG_PCMCIA_WAVELAN" = "y" ];
> then
> +     "$CONFIG_PCMCIA_NETWAVE" = "y" -o "$CONFIG_PCMCIA_WAVELAN" = "y" -o \
> +     "$CONFIG_PCMCIA_XIRTULIP" = "y" ]; then
>     define_bool CONFIG_PCMCIA_NETCARD y
>  fi

thanks for the patch.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
