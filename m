Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWCDRUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWCDRUh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWCDRUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:20:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8467 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932218AbWCDRUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:20:36 -0500
Date: Sat, 4 Mar 2006 18:20:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] RTC Subsystem, library functions
Message-ID: <20060304172035.GG9295@stusta.de>
References: <20060304164247.963655000@towertech.it> <20060304164248.171528000@towertech.it> <20060304165843.GD9295@stusta.de> <20060304181241.50894c49@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304181241.50894c49@inspiron>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 06:12:41PM +0100, Alessandro Zummo wrote:
> On Sat, 4 Mar 2006 17:58:43 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > > +# RTC class/drivers configuration
> > > +#
> > > +
> > > +config RTC_LIB
> > > +	bool
> > >...
> > 
> > What about
> > 
> > config RTC_LIB
> >         tristate
> > 
> > and
> > 
> > obj-$(CONFIG_RTC_LIB)   += rtc-lib.o
> > 
> > ?
> 
>  The rtc library code is selected also by code that goes in
>  arch specific code (arm, for example). I'm not sure it will appropriate
>  to use it as a module.
>...

That's not an issue:

If any option that is itself set to y (e.g. ARM) select's RTC_LIB, 
RTC_LIB is built statically into the kernel.

>  Best regards,
>  Alessandro Zummo,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

