Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318231AbSIOT5E>; Sun, 15 Sep 2002 15:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSIOT5E>; Sun, 15 Sep 2002 15:57:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:11021 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S318231AbSIOT5E>; Sun, 15 Sep 2002 15:57:04 -0400
Date: Sun, 15 Sep 2002 22:02:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Blackwell <jblack@linuxguru.net>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, jonathan@buzzard.org.uk
Subject: Re: [PATCH] IRQ patch for Toshiba Char Driver in 2.5.34
Message-ID: <20020915200202.GA15744@atrey.karlin.mff.cuni.cz>
References: <20020909115956.GA23290@comet> <20020911112938.A25726@infradead.org> <20020915154248.GA3647@elf.ucw.cz> <20020915213009.A53847@ucw.cz> <20020915195328.GA60517@comet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020915195328.GA60517@comet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > You've just made the driver horribly racy on SMP or preempt
> > > > systems..
> > > 
> > > Well, as long as toshiba does not make SMP notebooks, we are safe ;-).
> > 
> > ... or preempt. Which doesn't really depend on Toshiba.
> > 
> 
> Does that mean my very first kernel patch, insignificant as it is, is
> probably acceptable?
> 
> Should I resubmit it? I haven't tried 2.5.34 yet, and 2.5.33 had keyboard
> problems that prevented me from using it.

Perhaps adding #ifdef CONFIG_SMP #error Not SMP safe, #ifdef
CONFIG_PREEMPT #error Not preempt safe and resubmitting is not such a
bad idea.

It would be nice to make it preempt/smp safe, through. [SMP notebooks
are not so unreasonable; think p4 hyperthreading].
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
