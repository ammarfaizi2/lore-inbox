Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272159AbTG3P64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272958AbTG3P64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:58:56 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5504 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272159AbTG3P6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:58:54 -0400
Date: Wed, 30 Jul 2003 17:08:34 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307301608.h6UG8YQJ000339@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, pavel@ucw.cz
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Cc: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does anybody have any suggestions for recommended standard uses for
> > parallel port connected LEDs?

> At one point I had 12 LEDs on parport. LEDs were fast enough to be
> drive at interrupt entry/exit.
> They were: 
> Yellow not idle task
> Green interrupt
> " bh
> " pagefault
> Red lowest 4 bits of PID
> Red, low intensity serial i/o
> " network i/o
>
> It actually looked very good. Glow of interrupt led told you
> interrupt load, pid LEDs told you about what kind of load it is
> experiencing (you could tell shell script from make and from
> computation, and if machine hard-died, you at least knew if it was
> interrupt or process context). 

Sounds like exactly what we need.  If we standardise on something like
the above, we could just have a CONFIG_FRONT_PANEL_MONITOR and ask
people to send in the LED status with bug reports.

> But this kind of blinkenlights needed pretty fast LEDs. (At 486 time
> I decided that parport on ISA is fast enough..)

I'll buy some LEDs and build a parallel port connected LED panel
tomorrow...  Do you think the overhead of driving the LEDs would have
too much of a negative effect on system performance?  If so, or if we
want more flexibility, maybe we could work out a design for a PCI
card, which could include more than 12 LEDs - 7-segment numeric
displays of pid, etc.

John.
