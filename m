Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265036AbSKFNOo>; Wed, 6 Nov 2002 08:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265038AbSKFNOn>; Wed, 6 Nov 2002 08:14:43 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18328 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265036AbSKFNOk>; Wed, 6 Nov 2002 08:14:40 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1036549864.6098.76.camel@cog>
References: <200211052045.gA5KjCW04537@localhost.localdomain> 
	<1036549864.6098.76.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 13:43:42 +0000
Message-Id: <1036590222.9803.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 02:31, john stultz wrote:
> I'm fine w/ the X86_TSC change, but I'd drop the X86_PIT for now. 
> 
> Then make the arch/i386/timers/Makefile change to be something like:
> 
> obj-y := timer.o timer_tsc.o timer_pit.o
> obj-$(CONFIG_X86_TSC)		-= timer_pit.o #does this(-=) work?
> obj-$(CONFIG_X86_CYCYLONE)	+= timer_cyclone.o

Not everything is going to have a PIT. Also I need to know if there is a
PIT for a few other things so I'd prefer to keep it, but I'm not
excessively bothered

