Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWFALx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWFALx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 07:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWFALx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 07:53:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:61038 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750858AbWFALx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 07:53:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rGDSaXWgdpGZo2CVaChW9kLgvYz6MtJYHy9QJmEljll7Q0qozL/Scu9whyqmGssVy3PYkD5Da1klGGmNN2vfI/ESnaOWdj7XH0oayOQIl3TNGL6R4uU9rQ6KmpV68myNL0ZCJSgrUIsv/AVAvKg/lzP5sY8eOhLAZ4u0BtHOk3w=
Message-ID: <4423333a0606010451q25c1e6d5l8745b11d511c1481@mail.gmail.com>
Date: Thu, 1 Jun 2006 13:51:51 +0200
From: "Marko M" <marcus.magick@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Dave Airlie" <airlied@gmail.com>,
       "Jon Smirl" <jonsmirl@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0606011140110.3533@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605282316.50916.dhazelton@enter.net>
	 <Pine.LNX.4.61.0605312341240.30170@yvahk01.tjqt.qr>
	 <200605312115.44907.dhazelton@enter.net>
	 <Pine.LNX.4.61.0606011140110.3533@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure it is. I mean, it uses only VESA (extended VGA) registers and
doesn't know anything about present bliters, backend scalers or
similar hw features, AFAIK.

I think DirectFB guy have right approach, only they do it from user
space. fbdev should be capable of detecting present chip(s) and load
appropriate (acceleration) module, which describes hardware more
precisely.

If there is no specific (fbdev) driver module for your gfx then
everything should work with generic (VESA) one, though it would be
somewhat slower.

On 6/1/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> As long as I can continue to use 80x25 or any of the "pure text modes"
> >> (vga=scan boot option says more) without loading any FB/DRM, I am satisfied
> >
> >Jan, I don't plan on forcing fbdev/DRM on anyone. My work is going to leave
> >vgacon alone, and if my work at making DRM and FBdev cooperate goes as
> >planned, those two will remain independant, though part of my work aims at
> >having fbdev provide all 2D graphics acceleration for DRM while DRM handles
> >the 3D stuff via the Mesa libraries or similar.
> >
> That sounds acceptable.
>
> But current vesafb is slower, noticable with scrolling as in `ls -Rl /`.
> Does it lack 2D acceleration?
>
>
> Jan Engelhardt
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
