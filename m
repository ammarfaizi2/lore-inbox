Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSFSV1G>; Wed, 19 Jun 2002 17:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318017AbSFSV1F>; Wed, 19 Jun 2002 17:27:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:42196 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318016AbSFSV1E>; Wed, 19 Jun 2002 17:27:04 -0400
Date: Wed, 19 Jun 2002 23:26:59 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Greg KH <greg@kroah.com>
cc: Matthew Harrell 
	<mharrell-dated-1024798178.8a2594@bittwiddlers.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22 fix for pci_hotplug
In-Reply-To: <20020619173622.GB26136@kroah.com>
Message-ID: <Pine.NEB.4.44.0206192326000.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Greg KH wrote:

> > He tries to fix the following compile error that is caused by Martin
> > Dalecki's "[PATCH] 2.5.21 kill warnings 4/19" that is included in 2.5.22:
>
> Yeah, it looks like Martin got it wrong :)
>
> Can you try this patch instead and let me know if it fixes it or not?


Yes, this patch fixes it. A similar patch is needed for
pci_hotplug_util.c...


> thanks,
>
> greg k-h
>
> diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
> --- a/drivers/hotplug/pci_hotplug_core.c	Wed Jun 19 10:36:21 2002
> +++ b/drivers/hotplug/pci_hotplug_core.c	Wed Jun 19 10:36:21 2002
> @@ -48,7 +48,7 @@
>  	#define MY_NAME	THIS_MODULE->name
>  #endif
>
> -#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __FUNCTION__, ## arg); } while (0)
> +#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __FUNCTION__ , ## arg); } while (0)
>  #define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
>  #define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
>  #define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

