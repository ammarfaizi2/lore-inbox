Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266489AbSKUKIc>; Thu, 21 Nov 2002 05:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266491AbSKUKIc>; Thu, 21 Nov 2002 05:08:32 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23536 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266489AbSKUKIb>; Thu, 21 Nov 2002 05:08:31 -0500
Date: Thu, 21 Nov 2002 11:15:34 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: greg@kroah.com, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix compile error in usb-serial.c
Message-ID: <20021121101534.GF11952@fs.tum.de>
References: <200211201804.gAKI4u029388@hera.kernel.org> <Pine.GSO.4.21.0211211053020.18129-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211211053020.18129-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 10:54:20AM +0100, Geert Uytterhoeven wrote:

>...
> > -			length += sprintf (page+length, " module:%s", serial->type->owner->name);
> > +			length += sprintf (page+length, " module:%s", module_name(serial->type->owner));
>...
> How can this be correct?
> 
> serial->type->owner is of type struct module *, not char *!

You missed the module_name().

> Gr{oetje,eeting}s,
> 
> 						Geert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

