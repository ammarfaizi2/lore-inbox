Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbTFDVvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTFDVvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:51:03 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:675 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264174AbTFDVu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:50:56 -0400
Date: Thu, 5 Jun 2003 00:03:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.70: add comment about console LCD backlight issues
Message-ID: <20030604220356.GK333@elf.ucw.cz>
References: <20030529122816.GB21147@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529122816.GB21147@rhlx01.fht-esslingen.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> a lot of people seem to be confused about (non-working) notebook display
> blanking, so...
> 
> - add verbose explanation about the whole notebook screen blanking situation
>   and a possible development direction to prominent place

Please submit it to Rusty trivial patch monkey Russell
<trivial@rustcorp.com.au>.

> I might actually be tempted to unify graphics hardware backlight handling
> myself, since having a console that doesn't shut down the backlight properly
> is mildly annoying...

Yep, solving that somehow would be good.

> Patch against vanilla 2.5.70.
> 
> Andreas Mohr
> 
> diff -urN linux-2.5.70.orig/drivers/video/console/vgacon.c linux-2.5.70/drivers/video/console/vgacon.c
> --- linux-2.5.70.orig/drivers/video/console/vgacon.c	2003-05-28 17:57:07.000000000 +0200
> +++ linux-2.5.70/drivers/video/console/vgacon.c	2003-05-29 03:13:53.000000000 +0200
> @@ -661,6 +661,22 @@
>  	}
>  }
>  
> +/*
> + * vgacon_blank() is able to simply blank the screen, or to even switch
> + * the monitor off in case of "Green", "Energy Star" monitors
> + * (by switching off the sync signals using VESA mechanisms).
> + * However, it is NOT able to switch off the *backlight* of (most?)
> notebooks.

Acurate, AFAICS. Why can't that stupid notebook manufacturers make it
turn backlight off on VESA blank?!

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
