Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286241AbRLTN1p>; Thu, 20 Dec 2001 08:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286237AbRLTN1f>; Thu, 20 Dec 2001 08:27:35 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:5017 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S286241AbRLTN12>; Thu, 20 Dec 2001 08:27:28 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Helge Hafting <helgehaf@idb.hist.no>
Subject: Re: Poor performance during disk writes
Date: Thu, 20 Dec 2001 14:27:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: jlm <jsado@mediaone.net>, Andre Hedrick <andre@linuxdiskcert.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011220132729Z286241-18285+3296@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20.12.201, 10:49 Helge Hafting wrote:
> jlm wrote:
[-]
> > So I guess I don't really care what mode the hard drive is operating in
> > (udma, mdma, dma or plain ide), I just don't want to have to go get a
> > cup of coffee while the hard drive saves some data. Is there a "don't
>
> Devices generally get the cpu before anything else.  A good disk system
> don't need much cpu.  Running IDE in PIO mode require a lot
> of cpu though.   Using any of the DMA modes avoids that.

Amen..
Sorry, Helge sure you are right in theory but try dbench 32 (maybe 
bonnie/bonnie++) and playing an MP3/Ogg-Vorbis in parallel...
That's my first test on any "new" kernel version.

Even with an 1 GHz Athlon II, 640 MB, U160 DDYS 18 GB, 10k IBM disk (on an 
AHA-2940UW) it stutters like mad. I am running all my kernel _with_ Robert 
Love's preempt + lock-break patches and it doesn't solve the problem.
CPU load is (very) low but it do not work like it should.

> > pre-empt the rest of the system" switch for the eide drives? Is there
> > something fundamental/unique going on here that I'm missing?
> dma, udma, etc. is that switch.  It lets the cpu do other work (such as
> redrawing X) while the disk is busy.  Plain ide is what you don't want.

See above the whole system show some bad hiccup.

> The problem of waiting for other files or swapping while a really big
> write is going on is different.  Get more drives, so the big writes go
> to one drive while you get stuff swapped in (or other file access)
> on other drive(s).  The kernel is capable of getting fast response
> from one drive while another is completely bogged down with
> enormous writes.

Tried this already. Neither I put my test files (MP3/Ogg-Vorbis) in /dev/shm 
or a nother disk it do not change anything.

There must be something in the VFS?

-Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science
University of Hamburg
@home: Dieter.Nuetzel@hamburg.de
