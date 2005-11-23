Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVKWVEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVKWVEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVKWVEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:04:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43537 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932419AbVKWVEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:04:04 -0500
Date: Wed, 23 Nov 2005 22:04:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Michael Krufky <mkrufky@m1k.net>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Johannes Stezenbach <js@linuxtv.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Linux 2.6.15-rc2
Message-ID: <20051123210403.GX3963@stusta.de>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511202049.30952.gene.heskett@verizon.net> <4383CC4E.40206@m1k.net> <200511222336.48506.gene.heskett@verizon.net> <20051123174237.GO3963@stusta.de> <4384C059.3070003@m1k.net> <20051123203856.GU3963@stusta.de> <4384D5DB.3040209@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384D5DB.3040209@m1k.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 03:49:31PM -0500, Michael Krufky wrote:
> Adrian Bunk wrote:
>...
> >I do not yet know how to fix it, but configurations like 
> >CONFIG_VIDEO_CX88_DVB=y, CONFIG_DVB_CX22702=m are currently compile 
> >errors.
> > 
> >
> AHA!  I have not tested this with cx88-dvb compiled into the kernel (y) 
> -- I have only tested as a module (m) ..... Looks like I have a lot of 
> testing to do before the end of this week.
> 
> Adrian, does it work if you select CONFIG_VIDEO_CX88_DVB_ALL_FRONTENDS 
> ??  Selecting this option is, in effect, exactly equal to the old 
> behavior of forcing support for every single frontend supported by 
> cx88-dvb to be built.

Yes, this should fix these problems.

> Looks like the problem is the following:
> If cx88-dvb is selected (y), then then the frontends should also be 
> selected (y) ... but instead, they are being selected (m)

s/are being/can be/

> Meanwhile, if cx88-dvb is selected (m) then everything is fine, since 
> the frontends are also selected(m) ...

I haven't yet found any problem with it.

> Is my assessment correct?
> 
> -Michael Krufky

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

