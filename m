Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTANVkM>; Tue, 14 Jan 2003 16:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTANVkM>; Tue, 14 Jan 2003 16:40:12 -0500
Received: from pc-80-192-208-23-mo.blueyonder.co.uk ([80.192.208.23]:2700 "EHLO
	efix.biz") by vger.kernel.org with ESMTP id <S264925AbTANVkL>;
	Tue, 14 Jan 2003 16:40:11 -0500
Subject: Re: Linux 2.4.21-pre3-ac3 and KT400 -high memory now works!
From: Edward Tandi <ed@efix.biz>
To: Samuel Flory <sflory@rackable.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E236B2C.1050403@rackable.com>
References: <1042489183.2617.28.camel@wires.home.biz>
	 <3E236B2C.1050403@rackable.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042580942.2696.9.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 14 Jan 2003 21:49:03 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 01:43, Samuel Flory wrote:
> Edward Tandi wrote:
> 
> >I'm new to this list and most of the e-mail here seems to be very
> >low-level, so I'm not so sure if this is the right forum for these kinds
> >of questions -please do point me in the right direction...
> >
> >I am running Linux on an ASUS A7V8X, VIA KT400 chipset motherboard. The
> >processor is a 1.5GHz Athlon XP. I started experimenting with new-ish
> >kernels again because of the general lack of kernel support for this
> >chipset in stock kernels. 3 questions below:
> >
> >
> >1) I have 1GB ram, but I cannot get high memory support to work. It
> >falls over during boot. I've seen discussions about AMD cache issues,
> >but has it been fixed yet? Is it supposed to work?
> >
>   Have you tried to forcing the amount of memory?  Try something short 
> of you expected total.  Maybe "mem=1000M".

OK, I tried this. If I set it to 800M it was OK. At 900M I got the same
problem.

Due to the nature of the replies I have been getting, I suspected that
the problem was with the IDE driver's initialisation. So I disabled the
"Use PCI DMA by default" option in the kernel.

It booted with the full amount of high memory. Not only that, but
"hdparm -X66 /dev/hda" after booting also works!

I can only conclude that there must be a bug in the IDE initialisation
code for this board. Thanks for the replies,

Ed-T.

