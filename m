Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314929AbSFIT77>; Sun, 9 Jun 2002 15:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315091AbSFIT76>; Sun, 9 Jun 2002 15:59:58 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:13996 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314929AbSFIT76>; Sun, 9 Jun 2002 15:59:58 -0400
Date: Sun, 9 Jun 2002 14:59:57 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Albert Cranford <ac9410@bellsouth.net>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.21 lm_sensor support 1/5
In-Reply-To: <3D03AACF.E85DE83D@bellsouth.net>
Message-ID: <Pine.LNX.4.44.0206091457390.20459-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2002, Albert Cranford wrote:

> Patch adds lm_sensor support for 2.5.21
> --- linux/drivers/Makefile.orig	2002-05-20 09:54:49.000000000 -0400
> +++ linux/drivers/Makefile	2002-05-30 00:36:36.000000000 -0400
> @@ -10,7 +10,7 @@
>  		message scsi md ieee1394 pnp isdn atm \
>  		fc4 i2c acpi bluetooth input/serio \
>  		input/gameport parport hotplug \
> -		base char block misc net media cdrom
> +		base char block misc net media cdrom i2c/busses i2c/chips
>  
>  obj-$(CONFIG_PCI)		+= pci/
>  obj-$(CONFIG_ACPI)		+= acpi/
> @@ -42,6 +42,8 @@
>  obj-$(CONFIG_SERIO)		+= input/serio/
>  obj-$(CONFIG_I2O)		+= message/
>  obj-$(CONFIG_I2C)		+= i2c/
> +obj-$(CONFIG_MAINBOARD)		+= i2c/busses/
> +obj-$(CONFIG_SENSORS)		+= i2c/chips/
>  obj-$(CONFIG_PHONE)		+= telephony/
>  obj-$(CONFIG_MD)		+= md/
>  obj-$(CONFIG_BLUEZ)		+= bluetooth/

Is there any reason why you cannot link busses, chips from within 
i2c/Makefile?

It will work like this, but it surely is cleaner to do it from inside i2c
- CONFIG_MAINBOARD and CONFIG_SENSORS can not be set without CONFIG_I2C
AFAICS.

--Kai


