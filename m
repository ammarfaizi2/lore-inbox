Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266582AbRHJJZS>; Fri, 10 Aug 2001 05:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbRHJJZI>; Fri, 10 Aug 2001 05:25:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56937 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266582AbRHJJY7>; Fri, 10 Aug 2001 05:24:59 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
In-Reply-To: <no.id> <E15UV8M-0005SE-00@the-village.bc.nu>
	<9ksclk$k45$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Aug 2001 03:18:22 -0600
In-Reply-To: <9ksclk$k45$1@cesium.transmeta.com>
Message-ID: <m1bslotgrl.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <E15UV8M-0005SE-00@the-village.bc.nu>
> By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
> In newsgroup: linux.dev.kernel
> >
> > > The following would seem to be required to protect against
> > > the case in which PnP BIOS reports an IRQ of 0 for a 
> > > parport with disabled IRQ.      // Thomas  jdthood_AT_yahoo.co.uk
> > 
> > IRQ 0 is a legal valid IRQ. I suspect the problem is that pnpbios shouldnt
> > be reporting an IRQ or we should be using some kind of NO_IRQ cookie
> >
> 
> IRQ 0 is hardwired to the system timer in PC systems, though, so it
> could simply be assumed that IRQ 0 will never be used for any other
> purposes.
> 
> Reminds me back in the days when you had to worry about DRQs as well;
> DRQ 0 was hardwired in the original PC but then became available in
> the AT; there was a whole bunch of things that assumed DRQ 0 wasn't
> usable, even though it was perfectly fine.  Not to mention the
> motherboard I had which would lock up solid if anything ever used
> DRQ 5.
> 
> Good riddance, all this crap...

If we are going to list all of the silly assumptions, we still have
the assumption that 640KB-1MB on x86 cannot be used as ram.  It is
less painful but still annoying when you put perfectly valid ram
there.  :) 

Eric
