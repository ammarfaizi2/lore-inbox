Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSDEM6m>; Fri, 5 Apr 2002 07:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312559AbSDEM6c>; Fri, 5 Apr 2002 07:58:32 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47620 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312558AbSDEM62>; Fri, 5 Apr 2002 07:58:28 -0500
Date: Fri, 5 Apr 2002 07:56:08 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: joeja@mindspring.com
cc: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net>
Message-ID: <Pine.LNX.3.96.1020405074539.7802A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002 joeja@mindspring.com wrote:

>     Is there some way of making the linux kernel boot faster?  
> 
>     While I know that many people here probably don't reboot there
> machines often, I live in CA where my electrictiy is still high and see
> no reason to keep a machine on that is not in use (i.e. while I sleep or
> am at work). 

  You're dreaming... people here boot their machines a LOT, sometimes even
intentionally. Anyone who runs cetting edge kernels is familiar with boots
;-)
   
>     I tested freebsd on an old P133Mhz/32Meg ram and it booted faster
> with the GENERIC kernel than linux did on a AMD 1200Mhz/512Meg ram,
> which seemed odd.  Linux on that same P133 box also took longer than
> FreeBSD to boot. 

  Bear in mind that the install for BSD often does some setup. However,
booting Linux on a laptop with a configured kernel and initrd file, the
INIT script start in about ten seconds.

>     If I have a machine that does not change from day to day hardware
> wise why when I boot the thing do I need to probe the hardware again and
> again each time?  Would passing more options on the command line help
> like all the addresses and IRQ's of known hardware? 
>     Wouldn't it make sense to store this data on the files system?
> Certainly if something like grub or lilo can figure out how to access a
> file on the drive the kernel could check for a 'defaults' file or
> something to get the default irq's, hardware, interrupts, etc from. 
> Then the kernel could probe these first and if the probe fails proble
> elsewhere for the device. 

  That really should take little time... slow boots are caused by two
things, a generic kernel which has everything possible included, and a
slow init script which not only does many things, but does them serially
and accompanied by many messages. Watching Redhat tap dancing and farting
through line after line of stuff is painful, and with a serial console on
a server, hooked to a 9600bps modem, you can not only get a cup of coffe,
but brew it and drink it as well.

  You should time your boot stages, time to get the kernel running vs.
time to do init, and where does the init script spend its time. If the
kernel boot itself is slow, build a configured kernel, use only what you
need, make most of it modules demand loaded from modules.conf (later), and
you should get boot time down to ten sec or less.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

