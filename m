Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSHXU0W>; Sat, 24 Aug 2002 16:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSHXU0W>; Sat, 24 Aug 2002 16:26:22 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:28426
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316683AbSHXU0V>; Sat, 24 Aug 2002 16:26:21 -0400
Date: Sat, 24 Aug 2002 13:28:57 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
In-Reply-To: <20020824094125.A30109@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10208241325220.20141-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please respect the wish of those other two guys who asked to be removed
from the thread.

Russell look at what T13 did.  It gave CFA/PCMCIA there own set of opcodes
and rules.  Meaning they can do it different.  What is so hard to see that
they do it different and they have the resouces to do so.

It means, gee we need to go resolve the pcmcia issues in native calls.

On Sat, 24 Aug 2002, Russell King wrote:

> I notice everyone decided to miss replying to my mail about PCMCIA
> IDE devices, which will trip you up here.  Could it be because I've
> identified a real problem here?
> 
> - You plug the IDE device in.
> - Power gets applied.
> - cardmgr loads ide_cs.
> - cardmgr binds ide_cs, which registers with the IDE layer.
> 
> The above happens in 10s of milliseconds, well before the hard drive
> platters have been spun up.  Meanwhile, as defined by the T13 specs,
> the BSY bit can be set for up to 31 seconds.
> 
> You're saying "completely unknown state".  I say "T13 defines this
> state extremely well, and defines what happens from the drives point
> of view at the end of the power on reset sequence extremely well."
> 
> I also say that your implementation above is, in andrespeak, a "bad
> host" because it doesn't follow the T13 power on reset sequence
> properly.
> 
> And yes, people _do_ use PCMCIA IDE drives with Linux.
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 

Andre Hedrick
LAD Storage Consulting Group

