Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbRGKJEg>; Wed, 11 Jul 2001 05:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267249AbRGKJE1>; Wed, 11 Jul 2001 05:04:27 -0400
Received: from CPE-61-9-148-175.vic.bigpond.net.au ([61.9.148.175]:2034 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S267248AbRGKJEO>;
	Wed, 11 Jul 2001 05:04:14 -0400
Message-ID: <3B4C167B.528E9547@eyal.emu.id.au>
Date: Wed, 11 Jul 2001 19:03:55 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu> <01070912485904.00705@localhost.localdomain> <20010710121724.Z1503@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> 
> On Mon, Jul 09, 2001 at 12:48:59PM -0400, you [Rob Landley] claimed:
> >
> > (P.S. What kind of CPU load is most likely to send a processor into overheat?
> >  (Other than "a tight loop", thanks.  I mean what kind of instructions?)
> > This is going to be CPU specific, isn't it?  Our would a general instruction
> > mix that doesn't call halt be enough?  It would need to keep the FPU busy
> > too, wouldn't it?  And maybe handle interrupts.  Hmmm...)
> 
> See Robert Redelmeier's cpuburn:
> 
> http://users.ev1.net/~redelm/

I took this program for a spin and I noted the reported CPU temp
went up by 12dc (43->55).

However, more interesting, the +5V line dropped from 4.82 to 4.72.
This is on a Gigabyte GA-7ZX with an Athlon/1200 and 2x128MB.

Some mobos may actually have their voltages pushed outside accepted
levels and cause a failure, which is actually not related to the
temperature. And you do not need to run the test for a long time,
the drop is immediate and stable.

I can only imagine what will happen if some game pushes the CPU to
the limit while running a hot video card hard, as I expect some
highly optimized graphics drivers might do. May cause some
interesting crashes.

Anyone up to enhancing the program to stress the video memory at the
same time?


In other words, this is a good stress test for the whole mobo design
and setup, not just the CPU/HSF combo.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
