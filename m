Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135950AbRDVJXa>; Sun, 22 Apr 2001 05:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135965AbRDVJXV>; Sun, 22 Apr 2001 05:23:21 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:1607 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S135950AbRDVJXH>;
	Sun, 22 Apr 2001 05:23:07 -0400
Message-ID: <3AE2A2D0.80388594@violin.dyndns.org>
Date: Sun, 22 Apr 2001 11:22:24 +0200
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
Reply-To: dusty@strike.wu-wien.ac.at
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Karsten Keil <kkeil@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: APIC-Errors+Crashes on GA 586DX, 2.2.17/2.4.3
In-Reply-To: <3AE1860A.390E301@violin.dyndns.org> <20010421180435.A22420@pingi.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Keil wrote:
> 
> I have here the same board with 2*233 MMX and don't see this kind of ISDN
> error on recent 2.2 kernels, but got also lot of APIC errors with the
> 2.3/2.4, because the APIC errors are only reported in 2.3/4.

Right - same behavior here, no APIC errors with 2.2 (as they are not
reported). The ISDN error happens very seldom (4 times last year) and is
not reproducable - which is not so with the eth0 errors (as eth0 locks
at around 500-1000MB while copying data).

> > kernel with the "noapic" parameter. The strange thing is that the APIC
> > errors are still there, at least there are a lot less than before,
> > moreover the system seems slower but at least more stable. BTW, why are
> > there still APIC errors although there are no interrupts assigned to
> > CPU1 (as seen in /proc/interrupts).
> >
> 
> Yes, no APIC means all IRQ are handled by one CPU only, so communication
> errors about IRQ events on the APIC bus don't care.

Hmmm, so does that mean that those checksum errors have no effect on the
stability of my system?
 
> > What I wonder is why linux outputs a line like this (with noapic):
> > <4>Intel MultiProcessor Specification v1.1
> > <4>    Virtual Wire compatibility mode.
> >
> > although the board seems to be capable of MPS 1.4 (as there is a Bios
> > option "MPS 1.4 for single Processor).
> >
> 
> One or 2 years ago I was playing with these options, it seemed that setting
> it to 1.1 reduce the error count a little bit, but this maybe a
> misinterpretation.

How did you do that? The BIOS Option only enables the use of MPS 1.4 for
single CPU but I could not find an option for switching between 1.1/1.4.
Is there a way to force the Linux kernel to use 1.4?

Many thanks for your quick answer!

		Best Regards,
		Hermann

-- 
 ,_,
(O,O)     "There is more to life than increasing its speed."
(   )     -- Gandhi
-"-"--------------------------------------------------------------
