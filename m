Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSE1Nqe>; Tue, 28 May 2002 09:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSE1Nqd>; Tue, 28 May 2002 09:46:33 -0400
Received: from buffy.commerce.uk.net ([213.219.35.201]:7303 "EHLO
	buffy.commerce.uk.net") by vger.kernel.org with ESMTP
	id <S313305AbSE1Nqd>; Tue, 28 May 2002 09:46:33 -0400
Date: Tue, 28 May 2002 14:46:22 +0100 (BST)
From: Corin Hartland-Swann <cdhs@commerce.uk.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bluesmoke, machine check exception, reboot
In-Reply-To: <1022593837.4124.78.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0205281432450.27799-100000@buffy.commerce.uk.net>
Organization: Commerce Internet Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

On 28 May 2002, Alan Cox wrote:
> On Tue, 2002-05-28 at 13:19, Corin Hartland-Swann wrote:
> > I have a Dual PIII-1000 running 2.4.18, and am occasionally getting the
> > following error:
> >
> > > CPU 1: Machine Check Exception: 0000000000000004
> > > Bank 1: f200000000000115
> > > Kernel panic: CPU context corrupt

I just found another set of messages in the logs as well:

CPU 1: Machine Check Exception: 0000000000000004
Bank 1: b200000000000115
Kernel panic: CPU context corrupt

> > This results in a hard lock (unable to use magic SysRQ key to sync or
> > reboot, etc). I located these errors in arch/i386/kernel/bluesmoke.c in
> > the function intel_machine_check(). From what I have read on lkml it is
> > probably a result of the processor overheating and causing errors.
>
> It may even be a faulty processor. If you are running the processor to
> spec and your heatsink/fan/voltage all check out you may want to see
> about getting the CPU replaced. Thats a data cache l1 read error it
> appears

How do you work out what the numbers mean? Is there some kind of reference
to it, or are you just Alan "decodes machine check exceptions in his head"
Cox :) From the code it seems to be some kind of MCG status and MC0 status
- but of course, I have no idea what that means...

> That /proc setting should cause a reboot although after an MCE all
> things are a little undefined

After checking the logs (above) I found that the two times this has
happened it has managed to write it to the logs. Is the fact that it
sync()d a good indication that it will manage to reboot OK?

Thanks,

Corin

/------------------------+-------------------------------------\
| Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
| Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
| 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        |
| Gilbert Street         |                                     |
| Mayfair                |    Web: http://www.commerce.uk.net/ |
| London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
\------------------------+-------------------------------------/

