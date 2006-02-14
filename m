Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422873AbWBNXrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422873AbWBNXrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422874AbWBNXrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:47:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59403 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422873AbWBNXrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:47:31 -0500
Date: Wed, 15 Feb 2006 00:47:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060214234729.GB3595@stusta.de>
References: <20060214152218.GI10701@stusta.de> <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr> <20060214182238.GB3513@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214182238.GB3513@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 07:22:38PM +0100, Adrian Bunk wrote:
> On Tue, Feb 14, 2006 at 07:14:21PM +0100, Jan Engelhardt wrote:
> > >
> > >Make INPUT a bool.
> > >
> > >INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't 
> > >make that much sense to make it modular.
> > >
> > modular would make sense to me - http://lkml.org/lkml/2006/1/25/106
> >...
> 
> I don't get your point:
> 
> You don't need INPUT modular for hotplugging devices.
> 
> In the normal EMBEDDED=n cases, users already do not have the choice of 
> making INPUT modular.
> 
> If someone is working in an environment that is that space limited that 
> he sets EMBEDDED=y, why on earth should he enable module support that 
> uses relatively much space in his kernel?
>...

To back this with numbers:

I'm usually using a non-modular kernel on my computer.

This is the size difference between the same kernel with 
CONFIG_MODULES=y and CONFIG_MODULES=n:
  3799589 vmlinux-with-modules
  3447297 vmlinux-without-modules

Yes, the kernel is becoming bigger by 10% only for supporting modules.

Since the size increase is the space for the module support part of the 
kernel plus some additional space in many object files for stuff like 
EXPORT_SYMBOL's, the relative size increase is most likely even bigger 
for small kernels.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

