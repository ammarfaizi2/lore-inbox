Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262123AbSIYV7V>; Wed, 25 Sep 2002 17:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262124AbSIYV7V>; Wed, 25 Sep 2002 17:59:21 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:21387 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262123AbSIYV7U>; Wed, 25 Sep 2002 17:59:20 -0400
Date: Wed, 25 Sep 2002 17:04:25 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg KH <greg@kroah.com>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] consolidate /sbin/hotplug call for pci and usb
In-Reply-To: <20020925212955.GA32487@kroah.com>
Message-ID: <Pine.LNX.4.44.0209251703060.28659-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Greg KH wrote:

> diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
> --- a/drivers/base/Makefile	Wed Sep 25 14:22:28 2002
> +++ b/drivers/base/Makefile	Wed Sep 25 14:22:28 2002
> @@ -5,6 +5,10 @@
>  
>  obj-y		+= fs/
>  
> +ifeq ($(CONFIG_HOTPLUG),y)
> +	obj-y	+= hotplug.o
> +endif
> +
>  export-objs	:= core.o power.o sys.o bus.o driver.o \
>  			class.o intf.o
>  

Why not the simpler

obj-$(CONFIG_HOTPLUG)	+= hotplug.o

?

--Kai

