Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313058AbSC0RdZ>; Wed, 27 Mar 2002 12:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313059AbSC0RdP>; Wed, 27 Mar 2002 12:33:15 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:65506 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S313058AbSC0RdI>; Wed, 27 Mar 2002 12:33:08 -0500
Date: Wed, 27 Mar 2002 17:33:06 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: Bernd Schubert <bernd-schubert@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: time jumps
In-Reply-To: <200203271528.g2RFSZM10812@fubini.pci.uni-heidelberg.de>
Message-ID: <Pine.LNX.4.44.0203271729290.15451-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a hardware bug on some via 686a systems where the RTC appears 
automagically change it's programmed value.

A patch was originally made against 2.4.2, and some version of this 
appears to be applied to current kernels (I don't have a vanilla 
2.4.17 to check against).  Look in arch/i386/kernel/time.c for mention 
of 686a.

It appears to only be used if the kernel's not compiled with 
CONFIG_X86_TSC though, so if you have that defined you may not see the 
problem at all...

Mark


On Wed, 27 Mar 2002, Bernd Schubert wrote:

> Date: Wed, 27 Mar 2002 16:28:35 +0100
> From: Bernd Schubert <bernd-schubert@web.de>
> To: linux-kernel@vger.kernel.org
> Subject: time jumps
> 
> Hi,
> 
> we have a computer here, that behaves very strange, from one second to 
> another the clock changes to about 1h in the future. In the next "real" 
> second the time is normal again. 
> Well, I first thought that is might be a X problem, but after running a loop 
> over "date", it really seems that the system clock is affected.  Then I 
> thought it might be a conflict with the hardware clock, but after resetting 
> it to the system time, the problem was still there.
> 
> The only clock that doesn't seem to be affected is the realtime clock (at 
> least not when doing a loop of cat over the proc-file).
> 
> The problem is, that this time jumps cause the Xserver to enable its 
> screensaver (and several other small problems).
> 
> System  is: Athlon 650 on VIA board with linux-2.4.17 (unpatched)
> 
> 
> So has anyone an idea what to do, I'm thinking about a BIOS update (but don't 
> really believe that it will help). Or is it possible to patch the kernel that 
> it uses the realtime clock (could anyone of you send me this patch, if it is 
> possible, please??).
> 
> 
> Of course, I can give further information, if needed.
> 
> Thanks in advance, Bernd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

