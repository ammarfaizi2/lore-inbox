Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275687AbRJFUSe>; Sat, 6 Oct 2001 16:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275690AbRJFUSZ>; Sat, 6 Oct 2001 16:18:25 -0400
Received: from [194.213.32.141] ([194.213.32.141]:15744 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S275687AbRJFUSP>;
	Sat, 6 Oct 2001 16:18:15 -0400
Date: Sat, 6 Oct 2001 00:05:27 +0200
From: Pavel Machek <pavel@Elf.ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
Message-ID: <20011006000527.A1306@elf.ucw.cz>
In-Reply-To: <E15pWQA-0006bs-00@the-village.bc.nu> <m1669uyuqy.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1669uyuqy.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.22i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > We (as in Linux) should make sure that we explicitly tell the disk when
> > > > we need it to flush its disk buffers. We don't do that right, and
> > > > because of _our_ problems some people claim that writeback caching is
> > > > evil and bad.
> > > 
> > > Does this even work right for IDE ?
> > 
> > Current IDE drives it may be a NOP. Worse than that it would totally ruin
> > high end raid performance. We need to pass write barriers. A good i2o card
> > might have 256Mb of writeback cache that we want to avoid flushing - because
> > it is battery backed and can be ordered.
> 
> If the cache is small and is primarily a track cache (IDE) one trick that
> we can do is to flood the cache with data so everything is forced out.
> 
> We can do this at mkfs time, (so even destructive tests are allowed)
> and we can probe how to make this work for a particular drive.  And
> then the kernel can just use the results of that probe. 

How do you probe this without actually powering system down?
