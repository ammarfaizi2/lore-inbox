Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267981AbSISNNZ>; Thu, 19 Sep 2002 09:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267995AbSISNNZ>; Thu, 19 Sep 2002 09:13:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55937 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267981AbSISNNY>; Thu, 19 Sep 2002 09:13:24 -0400
Date: Thu, 19 Sep 2002 09:20:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Levon <movement@marcelothewonderpenguin.com>
cc: Jonathan Lundell <linux@lundell-bros.com>, linux-kernel@vger.kernel.org
Subject: Re: NMI watchdog stability
In-Reply-To: <20020919120740.GA42108@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.3.95.1020919091437.12027A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, John Levon wrote:

> On Wed, Sep 18, 2002 at 04:55:13PM -0700, Jonathan Lundell wrote:
> 
> > >It was causing SMP boxes to crash mysteriously after
> > >several hours or days. Quite a lot of them. Nobody
> > >was able to explain why, so it was turned off.
> > 
> > This was in the context of 2.4.2-ac21. More of the thread,with no 
> > conclusive result, can be found at 
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0103.2/0906.html
> > 
> > Was there any resolution? Was the problem real, did it get fixed, and 
> 
> Some machines corrupt %ecx on the way back from an NMI. Perhaps that was
> the factor all the people with problems saw.
> 
> regards
> john
> 

How is this? The handler saves/restores register values. The fact that
some interrupt occurred has no effect upon the contents of general
registers, only selectors (segments), EIP, ESP, and the return address
on the stack. If ECX was being destroyed, it was software that did it,
not some "machine". What kernel version destroys ECX upon NMI?


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

