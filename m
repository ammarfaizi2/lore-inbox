Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269572AbRHHV6p>; Wed, 8 Aug 2001 17:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269583AbRHHV6g>; Wed, 8 Aug 2001 17:58:36 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:27923 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269580AbRHHV6Z>; Wed, 8 Aug 2001 17:58:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
Date: 8 Aug 2001 14:58:12 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ksclk$k45$1@cesium.transmeta.com>
In-Reply-To: <no.id> <E15UV8M-0005SE-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E15UV8M-0005SE-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > The following would seem to be required to protect against
> > the case in which PnP BIOS reports an IRQ of 0 for a 
> > parport with disabled IRQ.      // Thomas  jdthood_AT_yahoo.co.uk
> 
> IRQ 0 is a legal valid IRQ. I suspect the problem is that pnpbios shouldnt
> be reporting an IRQ or we should be using some kind of NO_IRQ cookie
>

IRQ 0 is hardwired to the system timer in PC systems, though, so it
could simply be assumed that IRQ 0 will never be used for any other
purposes.

Reminds me back in the days when you had to worry about DRQs as well;
DRQ 0 was hardwired in the original PC but then became available in
the AT; there was a whole bunch of things that assumed DRQ 0 wasn't
usable, even though it was perfectly fine.  Not to mention the
motherboard I had which would lock up solid if anything ever used
DRQ 5.

Good riddance, all this crap...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
