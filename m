Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSGEVBx>; Fri, 5 Jul 2002 17:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317572AbSGEVBw>; Fri, 5 Jul 2002 17:01:52 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:60683 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317571AbSGEVBv>; Fri, 5 Jul 2002 17:01:51 -0400
Message-Id: <5.1.0.14.2.20020705215116.00b0a1e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 05 Jul 2002 22:05:20 +0100
To: Tomas Konir <moje@molly.vabo.cz>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: IBM Desktar disk problem?
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0207052216410.3293-100000@moje.ich.vabo.cz
 >
References: <20020705201155.GF28569@merlin.emma.line.org>
 <Pine.LNX.4.43.0207051524480.9092-100000@cibs9.sns.it>
 <Pine.LNX.4.44L0.0207051606050.32493-100000@moje.ich.vabo.cz>
 <20020705201155.GF28569@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:21 05/07/02, Tomas Konir wrote:
>On Fri, 5 Jul 2002, Matthias Andree wrote:
>
> > On Fri, 05 Jul 2002, Tomas Konir wrote:
> >
> > > hi i have similar problem.
> > > No dead disks, but after two days testing tcq patches (on 2.4). I
> > > got the two ATA errors (smartctl said).
> >
> > *shrug* FreeBSD should have eaten some of those drives as well, it has
> > been offering hw.ata.tags="1" to enable DMA QUEUED for a while now.
> >
> > And yes, my deathstar DTLA307045 still works without a single broken
> > block, but never used TCQ beyond booting 2.5.17 once (no LVM -> not
> > useful for me).
> >
> > Another DTLA307045 died some days ago, it has never seen TCQ.
> >
>
>I have no broken blocks. Only two errors logged in S.M.A.R.T.
>I have no S.M.A.R.T. errors for one year ago. And after use TCQ there are
>two errors after two days. Is is normal ?
>Curently i not believe new IBM disks and TCQ. I'll wait for better disks
>and stable TCQ.

You should update your firmware regardless of using TCQ because the errors 
you experienced have nothing to do with TCQ but a lot to do with buggy 
firmware. See what I found written about the firmware update on this 
webpage (Phil Randal posted this URL earlier on in this thread):
         http://www.geocities.com/dtla_update/

---snip---
While S.M.A.R.T. offline scan running in background, a read error could
cause a potential failure. This is corrected with current microcode.

(A5AA/A6AA) will detect and prevent application specific usage patterns
that cause excessive dwell times in particular areas.
---snip---

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

