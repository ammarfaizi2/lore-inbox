Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266491AbSKUKLc>; Thu, 21 Nov 2002 05:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266497AbSKUKLc>; Thu, 21 Nov 2002 05:11:32 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:2754 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266491AbSKUKLb>;
	Thu, 21 Nov 2002 05:11:31 -0500
Date: Thu, 21 Nov 2002 11:17:36 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: greg@kroah.com, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix compile error in usb-serial.c
In-Reply-To: <20021121101534.GF11952@fs.tum.de>
Message-ID: <Pine.GSO.4.21.0211211116260.18129-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2002, Adrian Bunk wrote:
> On Thu, Nov 21, 2002 at 10:54:20AM +0100, Geert Uytterhoeven wrote:
> 
> >...
> > > -			length += sprintf (page+length, " module:%s", serial->type->owner->name);
> > > +			length += sprintf (page+length, " module:%s", module_name(serial->type->owner));
> >...
> > How can this be correct?
> > 
> > serial->type->owner is of type struct module *, not char *!
> 
> You missed the module_name().

Oops, you're right. Sorry...
Given enough eyeballs, all misreads are shallow :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

