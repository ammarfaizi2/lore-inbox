Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWHMQ3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWHMQ3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWHMQ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 12:29:49 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:56038 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751300AbWHMQ3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 12:29:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WwN5N5OAeI+cRwe7nEg6hc+oAFm7kRxDry6Wl54p9EWTvaC3tbOo34tvAuTN7VKUFaiKL9CIdBJluMkR+FzonN43cLMeqV9OPXQYuartJmClobF1HSsIGXF4OX8OZeTE5qq6O2faWx7fk1hwes6pnGqzjBgsD6GVpmSCSpzQT/s=
Message-ID: <6bffcb0e0608130929k28ea4974sbced3374067d6794@mail.gmail.com>
Date: Sun, 13 Aug 2006 18:29:46 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: 2.6.18-rc4-mm1: drivers/video/sis/ compile error
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>,
       "Thomas Winischhofer" <thomas@winischhofer.net>
In-Reply-To: <20060813153034.GD3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <20060813153034.GD3543@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc3-mm2:
> >...
> > +drivers-video-sis-sis_mainh-removal-of-old.patch
> >...
> >  fbdev updates
> >...
>
> This patch removes too much:
>
> <--  snip  -->
>
> ...
>   CC      drivers/video/sis/sis_main.o
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:
> In function 'sisfb_setdefaultparms':
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:91:
> error: 'sisfb_mode_idx' undeclared (first use in this function)
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:91:
> error: (Each undeclared identifier is reported only once
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:91:
> error: for each function it appears in.)
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:
> In function 'sisfb_search_vesamode':
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:129:
> error: 'sisfb_mode_idx' undeclared (first use in this function)
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:
> In function 'sisfb_search_mode':
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:172:
> error: 'sisfb_mode_idx' undeclared (first use in this function)
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:
> In function 'sisfb_probe':
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:5813:
> error: 'sisfb_mode_idx' undeclared (first use in this function)
> make[4]: *** [drivers/video/sis/sis_main.o] Error 1

I'll take a closer look at this. I have tested this with allyesconfig
on 2006-08-08-00-59 mm snapshot, but now it doesn't build when
CONFIG_FB_SIS=y (CONFIG_FB_SIS=m builds fine for me).

Thanks for pointing that out.

>
> <--  snip  -->
>
> cu
> Adrian
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
