Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280833AbRKBVFm>; Fri, 2 Nov 2001 16:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280834AbRKBVFd>; Fri, 2 Nov 2001 16:05:33 -0500
Received: from fungus.teststation.com ([212.32.186.211]:30729 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S280833AbRKBVFM>; Fri, 2 Nov 2001 16:05:12 -0500
Date: Fri, 2 Nov 2001 22:05:09 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Hans-Joachim Baader <hjb@pro-linux.de>
cc: <linux-kernel@vger.kernel.org>, <jgarzik@mandrakesoft.com>
Subject: Re: 2.4.14-3 via-rhine lockup
In-Reply-To: <20011101225957.G679@mandel.hjb.de>
Message-ID: <Pine.LNX.4.30.0111022127250.1842-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Hans-Joachim Baader wrote:

> Hi,
> 
> I sent the following message a few days ago but I didn't see it on LKML.
> Did it reach you? Anyway here it is again.

Yes, I got it haven't done anything about it yet (I blame the snow ...)


> I couldn't get the output into a file but if necessary I'll try again.

My idea was to compare before and after ...

> Oct 28 18:51:22 mandel kernel: eth0: exiting interrupt, status=0x0000.
> Oct 28 18:51:24 mandel kernel: eth0: Interrupt, status 0001.
> Oct 28 18:51:24 mandel kernel:  In via_rhine_rx(), entry 11 status 00409700.
> Oct 28 18:51:24 mandel kernel:   via_rhine_rx() status is 00409700.
> Oct 28 18:51:24 mandel kernel: eth0: exiting interrupt, status=0x0000.
> Oct 28 18:51:24 mandel kernel: eth0: Transmit frame #2859186 queued in slot 1.
> Oct 28 18:51:24 mandel kernel: eth0: Interrupt, status 0002.
> Oct 28 18:51:24 mandel kernel: eth0: exiting interrupt, status=0x0000.
> 
> 
> > After it stops working, do you still get log messages from it?
> > Including via_rhine_rx()?
> 
> Yes, the above output is from the non-working state.

But everything looks fine. As I read that the card is still receiving data
and generating interrupts. After "Transmit frame" you get an interrupt
with status=2 (IntrTxDone) and you get rx interrupts as well.

One thing that is odd is that the rx status is always the same and a
broadcast, when sending something do you get anything other than
"via_rhine_rx() status is 00409700" ?

/Urban

