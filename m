Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265166AbTLFNgS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 08:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265167AbTLFNgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 08:36:18 -0500
Received: from legolas.restena.lu ([158.64.1.34]:7075 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S265166AbTLFNgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 08:36:16 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Craig Bradney <cbradney@zip.com.au>
To: Ian Kumlien <pomac@vapor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1070676480.1989.15.camel@big.pomac.com>
References: <1070676480.1989.15.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1070717770.13004.11.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 14:36:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-06 at 03:08, Ian Kumlien wrote: 
> Craig Bradney wrote:
> > All the interrupts are the same...except:
> > 0, timer is now IO-APIC-edge.
> 
> Same here... 
> 
> > Im not getting any NMI counts.. should I use nmi-watchdog=1?
> 
> I got nmi counts with nmi_watchdog=2...  I never tested with =1... if
> you get nmi's 1 lemme know.
> 
> > Ian, from looking back, you have an A7N8X-X bios 1007.
> > Interesting that my USB hcis are still sharing IRQs there.
> 
> Your? i only see one... But you share it with sound and eth0... 
> 
> > Any idea how I can get them apart, or if I should try.
> 
> You could always move eth0 to a different slot. Other than that, you can
> do manual config for the irq's in the bios, but it shouldn't be
> needed...

eth0 is the 3com onboard on the a7n8x deluxe... 

> > My system was pretty stable as I've stated.. but the patch has changed
> > things slightly re the timer.
> 
> As i stated in my prev email, i had to do 2 full greps at a sizable
> amount of data to recreate the crash... =P
> 
> And, please CC since i'm not on this ml =P

Having finally woken up (me not the pc), uptime here is now 12 hours..
(without the CPU Disconnect athcool run, just the kernel patch). I did
run the athcool program to check the result though:

nVIDIA nForce2 (10de 01e0) found
'Halt Disconnect and Stop Grant Disconnect' bit is enabled.

Do others have the same value 10de 01e0 when they run athcool stat? Even
with the same motherboard (a7n8x deluxe)?

Im running a grep -R kernel /usr/* and another grep on my 4gb DVD and
compiling a Qt 3.2.3 upgrade now.

For me idle time never seemed to be a problem which I guess relates to
the CPU Disconnect on low usage/low power issue

Perhaps my motherboard and cpu doesnt have a problem with disconnect and
just the IRQ issue, perhaps because its only a few weeks old. It would
make sense in some ways given that my system has only one of the
problems given the uptime I have been able to reach.

My hangs have always been when I have used the PC.. and often completed
a task and then a few seconds later it goes.

Will see in time I guess

Craig


