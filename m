Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270518AbRHHQOa>; Wed, 8 Aug 2001 12:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270519AbRHHQOV>; Wed, 8 Aug 2001 12:14:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60545 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S270518AbRHHQOJ>; Wed, 8 Aug 2001 12:14:09 -0400
Date: Wed, 8 Aug 2001 12:13:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
In-Reply-To: <E15UV8M-0005SE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1010808120812.27711A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2001, Alan Cox wrote:

> > The following would seem to be required to protect against
> > the case in which PnP BIOS reports an IRQ of 0 for a 
> > parport with disabled IRQ.      // Thomas  jdthood_AT_yahoo.co.uk
> 
> IRQ 0 is a legal valid IRQ. I suspect the problem is that pnpbios shouldnt
> be reporting an IRQ or we should be using some kind of NO_IRQ cookie

IRQ0 will never by reported by a PCI bus device because it means that
no IRQ is used (they figured that IRQ0 would always be used for something
else). Maybe PnP BIOS also presumes this? If so, the use of IRQ0 to
mean "no IRQ" is valid, although misleading.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


