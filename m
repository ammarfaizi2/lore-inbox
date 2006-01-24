Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWAXAMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWAXAMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWAXAMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:12:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2574 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932454AbWAXAMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:12:50 -0500
Date: Tue, 24 Jan 2006 01:12:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mike Krufky <mkrufky@linuxtv.org>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       mchehab@infradead.org, linux-dvb-maintainer@linuxtv.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Michael Krufky <mkrufky@m1k.net>
Subject: Re: [PATCH 10/16] make VP-3054 Secondary I2C Bus Support a Kconfig option.
Message-ID: <20060124001248.GF3590@stusta.de>
References: <20060123202404.PS66974000000@infradead.org> <20060123202444.PS83596100010@infradead.org> <20060123221604.GA3590@stusta.de> <43D56174.7000700@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D56174.7000700@linuxtv.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 06:06:28PM -0500, Mike Krufky wrote:
> Adrian Bunk wrote:
> 
> >On Mon, Jan 23, 2006 at 06:24:44PM -0200, mchehab@infradead.org wrote:
> >...
> >>@@ -70,6 +71,16 @@ config VIDEO_CX88_DVB_MT352
> >>	  This adds DVB-T support for cards based on the
> >>	  Connexant 2388x chip and the MT352 demodulator.
> >>
> >>+config VIDEO_CX88_VP3054
> >>+	tristate "VP-3054 Secondary I2C Bus Support"
> >>+	default m
> >>...
> >>   
> >>
> >This option should be a bool since "m" doesn't make much sense (it's 
> >anyways interpreted the same as "y").
> > 
> >
> Adrian,
> 
> You have a point - it is a boolean choice yes/no, about whether or not 
> to compile support for this module, ... but it is in fact a module, and 
> when M is chosen, cx88-vp3054-i2c.ko will build as a module.  When Y is 

I don't see this in your patches.

All your patches do is to define -DHAVE_VP3054_I2C=1 depending on 
CONFIG_VIDEO_CX88_VP3054.

> chosen, it will be built in-kernel, just as all other tri-states..... 
> The difference is that this module depends on DVB_MT352 ... if DVB_MT352 
> is M, then this should be M/N ... if  VIDEO_CX88_DVB is Y, then this 
> should be Y/N...
>...


If VIDEO_CX88_DVB (and modules support enabled in the kernel) this 
will be Y/M/N...


A more general question:
Why are you using the indirection through the defines in the Makefile?
You could diectly use the (boolean) CONFIG_* options in the drivers.


> :-)
> 
> Regards,
> Michael Krufky

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

