Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317490AbSFDMvm>; Tue, 4 Jun 2002 08:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSFDMvl>; Tue, 4 Jun 2002 08:51:41 -0400
Received: from daimi.au.dk ([130.225.16.1]:54395 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317490AbSFDMvd>;
	Tue, 4 Jun 2002 08:51:33 -0400
Message-ID: <3CFCB7D1.5A09615E@daimi.au.dk>
Date: Tue, 04 Jun 2002 14:51:29 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Allan Sandfeld <linux@sneulv.dk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.LNX.4.33.0206031025400.30424-100000@mail.pronto.tv> <3CFB2F92.34D174C3@daimi.au.dk> <200206041311.03631.linux@sneulv.dk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan Sandfeld wrote:
> 
> On Monday 03 June 2002 10:57, Kasper Dupont wrote:
> > Roy Sigurd Karlsbakk wrote:
> > > > > RAID-6 layout: http://www.acnc.com/04_01_06.html
> > > >
> > > > If it is supposed to survive two arbitrary disk failures something is
> > > > wrong with that figure. They store 12 logical sectors in 20 physical
> > > > sectors across 4 drives. With two lost disks there are 10 physical
> > > > sectors left from which we want to reconstruct 12 logical sectors.
> > > > That is impossible.
> > >
> > > Might be the diagram is wrong.
> >
> > Could be the case, so until I find another description I will
> > still not know how RAID-6 works.
> >
> It's not just the diagram, the theory is wrong. You need to use at least log2
> n+1 disks for partition if you want to handle any two lost/borked disks. (16
> disks would give 11x diskspace).

But there are other encodings with 2 extra disks that can
handle 2 lost disks. And in general if you need x disks of
space and the ability to recover from y lost disks you can
do the encoding on x+y disks.

Knowing that why do we even consider RAID-6? I guess RAID-6
is a lot faster, is that true?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
