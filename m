Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130996AbQLUNfV>; Thu, 21 Dec 2000 08:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131092AbQLUNfM>; Thu, 21 Dec 2000 08:35:12 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:33774 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S130996AbQLUNfA>; Thu, 21 Dec 2000 08:35:00 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Re: lockups from heavy IDE/CD-ROM usage
Message-ID: <3A41FFD8.531DF534@fi.muni.cz>
Date: Thu, 21 Dec 2000 13:04:24 GMT
To: xOr <xor@x-o-r.net>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <Pine.LNX.4.31.0012210421450.284-100000@bitch.x-o-r.net>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem: When i am using my harddrive and cdrom, my computer will freeze.
> It freezes in two different ways.. sometimes just the harddrive access
> will freeze (can still do things in X as long as they dont require the
> harddrive), and then everything freezes within a few seconds. or else
> everything just locks instntly. the problem is reproducable, all i need to
> do is be using the harddrive extensively for a couple separate functions
> (like compiling the kernel, and copying a large file) and ripping cd audio
> (cd paranoia) and i can lock the system in as little as seconds, or a few
> minutes sometimes.  This will happen more reliably, and much quicker and

This is really very similar to my problem with BP6 I'm reporting for a
long long time.
But everyone says its faulty board.

For BP6 somehow helps to set UDMA to mode 2.
(I'm not getting these locks when I'm just using ATA33 controler)
(hdparm -X66 /dev/hdX)

Also could you look at what is being written to console ?
(run those intesive programs and stay on console - BP6 lock with 
this message displayed:

hdf: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout: func only 14

In this point it looks like timers are dead... :(
And the situation is the same with SMP & NoSMP kernel with apic &
noapic.

-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
