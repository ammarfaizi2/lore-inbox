Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSGUXv2>; Sun, 21 Jul 2002 19:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSGUXuK>; Sun, 21 Jul 2002 19:50:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39585 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315417AbSGUXuD>;
	Sun, 21 Jul 2002 19:50:03 -0400
Date: Mon, 22 Jul 2002 01:52:06 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
In-Reply-To: <1027299841.16818.124.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207220151420.4346-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Jul 2002, Alan Cox wrote:

> > > Actually its to cover the case where you have a floppy drive, and you've
> > > booted the kernel from a floppy disk, and the kernel doesn't have the
> > > floppy driver built in.  It turns the floppy drive off, cause there's
> > > nothing else to do that.
> > 
> > this should then be done by the floppy boot code?
> 
> Most definitely. On legacy free boxes there may not even be a floppy
> controller present, and on non x86 your guess is as good as mine at
> where the fdc lives.

non-x86 was covered via an #ifdef, but legacy-free is not covered.

	Ingo

