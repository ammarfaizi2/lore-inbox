Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSAXNgA>; Thu, 24 Jan 2002 08:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287827AbSAXNfu>; Thu, 24 Jan 2002 08:35:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37385 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287817AbSAXNfg>;
	Thu, 24 Jan 2002 08:35:36 -0500
Message-ID: <3C500DA6.8DF536C8@mandrakesoft.com>
Date: Thu, 24 Jan 2002 08:35:34 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre4 panics on boot )-:
In-Reply-To: <5.1.0.14.2.20020124130949.02614370@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> Can't attach .config nor decode oops at the moment as the machine is now

Normally that would suck but this is a BUG, so no problem...

[...]
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1336.3655 MHz.
> ..... host bus clock speed is 267.2731 MHz.
> cpu: 0, clocks: 2672731, slice: 1336365
> CPU0<T0:2672720,T1:1336352,D:3,S:1336365,C:2672731>
> kernel BUG at sched.c:588!
[...]
>   spurious 8259A interrupt: IRQ7.
> Kernel panic: Attempted to kill the idle task!
> In idle task - not syncing


Scheduling in an interrupt?  Ouch.

I would assume Ingo's latest, which is J6 AFAICS:
http://people.redhat.com/mingo/O(1)-scheduler/sched-O1-2.5.3-pre4-J6.patch

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
