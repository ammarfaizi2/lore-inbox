Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131374AbRAaBHz>; Tue, 30 Jan 2001 20:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRAaBHp>; Tue, 30 Jan 2001 20:07:45 -0500
Received: from cheetah.STUDENT.CWRU.Edu ([129.22.164.229]:12419 "EHLO
	cheetah.STUDENT.cwru.edu") by vger.kernel.org with ESMTP
	id <S131374AbRAaBHf>; Tue, 30 Jan 2001 20:07:35 -0500
Date: Tue, 30 Jan 2001 20:06:58 -0500 (EST)
From: Matthew Gabeler-Lee <msg2@po.cwru.edu>
X-X-Sender: <cheetah@cheetah.STUDENT.cwru.edu>
To: John Jasen <jjasen1@umbc.edu>
cc: <linux-kernel@vger.kernel.org>, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: bttv problems in 2.4.0/2.4.1
In-Reply-To: <Pine.SGI.4.31L.02.0101301951040.887333-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.LNX.4.32.0101302004420.1138-100000@cheetah.STUDENT.cwru.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, John Jasen wrote:

> On Tue, 30 Jan 2001, Matthew Gabeler-Lee wrote:
>
> > These errors all occur in the same way (as near as I can tell) in
> > kernels 2.4.0 and 2.4.1, using bttv drivers 0.7.50 (incl. w/ kernel),
> > 0.7.53, and 0.7.55.
> >
> > I am currently using 2.4.0-test10 with bttv 0.7.47, which works fine.
> >
> > I have sent all this info to Gerd Knorr but, as far as I know, he hasn't
> > been able to track down the bug yet.  I thought that by posting here,
> > more eyes might at least make more reports of similar situations that
> > might help track down the problem.
>
> Try flipping the card into a different slot. A lot of the cards
> exceptionally do not like IRQ/DMA sharing, and a lot of the motherboards
> share them between different slots.

I will try this, but my card has (and does) worked with irq sharing for
a long time.  Its entry in /proc/interrupts:
  9:     164935     165896   IO-APIC-level  acpi, bttv
I find it strange that a driver that had worked with shared interrupts
for a long time would suddenly cease to function with shared interrupts,
and would consider this a bug.  I will try changing the slot, but
getting it to not share interrupts will be difficult considering the
number of pci devices I have.

-- 
	-Matt

Today's weirdness is tomorrow's reason why.
		-- Hunter S. Thompson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
