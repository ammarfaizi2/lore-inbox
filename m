Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264138AbUFWDwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUFWDwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 23:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUFWDwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 23:52:04 -0400
Received: from bay16-f33.bay16.hotmail.com ([65.54.186.83]:7947 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264138AbUFWDv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 23:51:58 -0400
X-Originating-IP: [64.81.213.196]
X-Originating-Email: [dinoklein@hotmail.com]
From: "Dino Klein" <dinoklein@hotmail.com>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7] Parallel port detection via ACPI
Date: Wed, 23 Jun 2004 00:51:57 -0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F33X3gjv5Or5500010eb0@hotmail.com>
X-OriginalArrivalTime: 23 Jun 2004 03:51:57.0683 (UTC) FILETIME=[6E686430:01C458D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
I'll CC the list since someone might have some comments about your 
situation.
I took a quick look at parport_pc.c from 2.4.26, and it looked pretty much 
the same; my guess is tha the changes should be just about identical. I'll 
give it a try and if it compiles, I'll post something; unfortunately I won't 
be able to try it out, since I don't have an available machine one which to 
boot 2.4.

>From: DervishD <raul@pleyades.net>
>To: Dino Klein <dinoklein@hotmail.com>
>Subject: Re: [PATCH 2.6.7] Parallel port detection via ACPI
>Date: Tue, 22 Jun 2004 17:53:23 +0200
>
>     Hi Dino :)
>
>  * Dino Klein <dinoklein@hotmail.com> dixit:
> > I posted the following message on linux-parport at infradead.org; 
>however
> > the list seems to be inactive. Here it is again, for anyone interested.
>
>     I'm interested, and as soon as one of my linux machines is boot
>again I can test your patch (if the sysadmin allows me...).
>
>     I'm interested because I have a long standing problem with the
>parallel port, and it happens in all machines I have at hand. The
>problem is that, no matter how is configured the parallel port in the
>BIOS, Linux always says it is in SPP mode. No matter the motherboard,
>no matter the BIOS vendor, no matter anything. This is the dmesg
>output from one machine, the others are more or less the same:
>
>kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
>kernel: parport0: Printer, Lexmark International Lexmark Optra E312
>kernel: lp0: using parport0 (interrupt-driven).
>kernel: Trying to free free DMA3
>
>     Other times I have this other message:
>
>kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
>kernel: parport_pc: Via 686A parallel port: io=0x378
>kernel: lp0: using parport0 (polling).
>
>     Most of the machines have Lexmark printers attached, but I've
>tested with different printer brands and that doesn't make a
>difference.
>
>     All parallel ports are ECP & EPP capable. I contacted a time ago
>with the maintainers of the parport code, but I had only an answer,
>saying that I should put the ports in the BIOS as ECP or EPP, not as
>'ECP+EPP'. No problem, I did it and it didn't make a difference.
>
> > It utilizes the ACPI subsystem
> > to get the resources assigned to the port, and then passes them on
> > to the detection routine. I've verified that it is working on my
> > machine by cycling between the modes in the BIOS (spp, epp,
> > ecp+epp), and observing proper detection in the logs.
>
>     That's exactly what I want! My problem now is that I cannot use
>the parports in any mode different from SPP, and that is very slow,
>and if the printer hangs, breaks, turns off or whatever, the software
>doesn't notice and waits forever!
>
>     Abusing of you: is any way of, using the current code in 2.4.x,
>to make my parallel port work in ECP or EPP mode?
>
>     Thanks a lot in advance, and thanks for the patch :)
>
>     Raúl Núñez de Arenas Coronado
>
>--
>Linux Registered User 88736
>http://www.pleyades.net & http://raul.pleyades.net/

_________________________________________________________________
MSN Messenger: instale grátis e converse com seus amigos. 
http://messenger.msn.com.br

