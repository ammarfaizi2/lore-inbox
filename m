Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWDJHXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWDJHXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWDJHXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:23:17 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:50659 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1751045AbWDJHXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:23:17 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200604100727.k3A7RX6c017659@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.16-rt11: Hires timer makes sleep wait far too long
To: tglx@linutronix.de
Date: Mon, 10 Apr 2006 16:57:33 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <1144319324.5344.688.camel@localhost.localdomain> from "Thomas Gleixner" at Apr 06, 2006 12:28:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas

> On Wed, 2006-04-05 at 09:51 +0930, Jonathan Woithe wrote:
> >   ENABLING IO-APIC IRQs
> >   ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> >   Event source pit new caps set: 05
> >   Event source lapic installed with caps set: 02
> >   :
> >   Time: tsc clocksource has been installed.
> >   hrtimers: Switched to high resolution mode CPU 0
> >   :
> >   Time: acpi_pm clocksource has been installed.
> >   hrtimers: Switched to high resolution mode CPU 0
> 
> Nothing wrong so far. I have to find a test box with pm timer to get
> some more info.

FYI, the same problem occurs in 2.6.16-rt12.  I note that rt14 is out now
so I'll give that a go overnight and let you know the results.

One final observation I did make under 2.6.16-rt12: in the first 30 seconds
or there abouts after the boot, "sleep 1" did result in short sleeps - they
weren't always 1 second, but they were in the ballpark.  After the machine
had been up for 30-60 seconds however, "sleep 1" would produce waits along
the lines of what I reported in the initial report - anywhere between 20
seconds to 45 seconds and more.  There didn't seem to be any gradual
increase either - the "sleep 1" wait times seemed to jump from 1-2 seconds
up to 20-30 seconds very suddenly.

Regards
  jonathan
