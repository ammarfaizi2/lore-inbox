Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262368AbTCICc5>; Sat, 8 Mar 2003 21:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262369AbTCICc4>; Sat, 8 Mar 2003 21:32:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262368AbTCICcz>; Sat, 8 Mar 2003 21:32:55 -0500
Date: Sat, 8 Mar 2003 21:38:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Harald.Schaefer@gls-germany.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thomas.Mieslinger@gls-germany.com, linux-kernel@vger.kernel.org,
       aeb@cwi.nl
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
In-Reply-To: <20030308232351.GA3462@win.tue.nl>
Message-ID: <Pine.LNX.3.96.1030308213021.5356B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003, Andries Brouwer wrote:

> On Sat, Mar 08, 2003 at 05:28:10PM -0500, Bill Davidsen wrote:
> > On Thu, 6 Mar 2003 Harald.Schaefer@gls-germany.com wrote:
> > 
> > >  *    1. CHS value set by user       (whatever user sets will be trusted)
> > >  *    2. LBA value from target drive (require new ATA feature)
> > >  *    3. LBA value from system BIOS  (new one is OK, old one may break)
> > >  *    4. CHS value from system BIOS  (traditional style)
> > > 
> > > I think that the priority of LBA from BIOS has to be raised to 2 and the
> > > priority of LBA from drive should be lowered to 3.
> > > The mapping-problem only appreared with very new drives in some
> > > brand-computers using a 240-head mapping from the bios.
> > 
> > I think the chances of a drive knowing its own correct LBA info is far
> > better than the BIOS getting it right. Many BIOS versions don't understand
> > large drives.
> 
> Maybe time for some preaching again.
> 
> The above sounds like nonsense,
> "its own correct LBA info" does not refer to anything.

Change the wording any way you like, my point that the drive is more
likely to have correct information about its LBA capacity than the BIOS.

> A disk that is less than twelve years old does not have a geometry.
> All disks that can handle LBA (that is, all disks less than
> twelve years old) use LBA under Linux.
> Thus, the disk has nothing to tell use except for its total capacity.

So you are saying the same thing I am, are you not? I said to use the
drive LBA capacity, you say that means nothing and then agree that is
exactly what the drive can tell us. Many people put new drives in old
machines which have a BIOS which doesn't understand large drives. So the
kernel should believe the drive about the size rather than the BIOS.

You call that nonsens and then say the same thing in other words as if you
were disagreeing with me.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

