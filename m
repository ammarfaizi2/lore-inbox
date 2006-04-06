Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWDFXyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWDFXyH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 19:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWDFXyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 19:54:07 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:12747 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S932230AbWDFXyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 19:54:05 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200604062358.k36Nw92v004229@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.16-rt11: Hires timer makes sleep wait far too long
To: tglx@linutronix.de
Date: Fri, 7 Apr 2006 09:28:09 +0930 (CST)
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

Note that the fault condition persisted no matter which clocksource was
in use: I tried all four (tsc, pm_timer, jiffies, pit) and they all resulted
in "sleep 1" lasting far longer than 1 second.

Feel free to email if I can be of further assistance.  In the meantime I'll
try 2.6.16-rt12 over the weekend to see if the situation is any different.

Regards
  jonathan
