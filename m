Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131254AbRDBSNl>; Mon, 2 Apr 2001 14:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131269AbRDBSNa>; Mon, 2 Apr 2001 14:13:30 -0400
Received: from ns0.petreley.net ([64.170.109.178]:13715 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S131254AbRDBSNQ>;
	Mon, 2 Apr 2001 14:13:16 -0400
Date: Mon, 2 Apr 2001 11:12:29 -0700
From: Nicholas Petreley <nicholas@petreley.com>
To: Robert NEDBAL <R.Nedbal@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org,
   ReiserFS Mailing List <reiserfs-list@namesys.com>
Subject: Re: ReiserFS - corrupted files (2.4.3)
Message-ID: <20010402111229.B482@petreley.com>
In-Reply-To: <20010402085448.A482@petreley.com> <Pine.BSF.4.31.0104021921380.36074-100000@veverka.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.BSF.4.31.0104021921380.36074-100000@veverka.sh.cvut.cz>; from R.Nedbal@sh.cvut.cz on Mon, Apr 02, 2001 at 07:27:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert,

That output below is part of the results from

 reiserfsck /dev/hde5 

(obviously /dev/hde5 is the partition that I checked).  I'm
using reiserfsprogs version 3.x.0i.  You can run reiserfsck
without any arguments and it can't do any harm to your
partition - it's read-only.  

I tried "reiserfsck -x /dev/hde5" but that didn't fix
anything.  (the -x switch is supposed to "fix fixable
without having to use --rebuild-tree).  But 

reiserfsck --rebuild-tree /dev/hde5 

fixed the bitmap problem in this case, and it didn't cause
any new problems.  Nevertheless, I'm using reiserfs on all
my machines, so I would be glad to help debug the problems
asap - I'm worried about losing a whole partition here and
there eventually.  I'd go back to kernel 2.2.18, which is
supposedly very stable, but I can't. It doesn't work for me
on reiserfs partitions created with 2.4.x.

I don't know where to start with debugging, either, but I'm
willing to take instructions.  

-Nick


* Robert NEDBAL (R.Nedbal@sh.cvut.cz) [010402 10:28]:
> Hello,
> thank you for your fast reply.
> 
> On Mon, 2 Apr 2001, Nicholas Petreley wrote:
> > Comparing bitmaps..free block count 613785 mismatches with
> > a correct one 613799.
> > byte 114154: bm1: ffffffff bm2 1f
> > byte 114155: bm1: ffffffff bm2 fffffffc
> > byte 118307: bm1: ffffffff bm2 ffffffef
> > byte 118309: bm1: ffffffff bm2 3f
> > byte 118310: bm1: ffffffff bm2 fffffffc
> > byte 118312: bm1: ffffffff bm2 ffffff87
> > on-disk bitmap does not match to the correct one. 6 bytes
> > differ
> 
> How you get these results?
> 
> >
> > And I found a recently updated log file with nulls in it -
> > I thought that problem was fixed long ago.  I've been using
> > ac28 and 2.4.3 while getting these errors.  The corruptions
> > occur on two machines, asus a7v and asus a7v133, via686a
> > and via686b.  I've had reasonably good luck with
> > reiserfsck, though, so it's not something to fear entirely.
> > ;-)
> >
> 
> I'll try running reiserfsck as the last option. (Just before complete
> reinstallation :-) )
> 
> > I'd be glad to help with any debugging as time permits.
> >
> 
> I'm happy that somebody is interrested in debugging. Bud I'm only C/C++
> coder, I dont know much about kernel internals. How can I begin with
> debugging?
> 
> regards,
> Robert
> 
> >
> > --
> > **********************************************************
> > Nicholas Petreley   Caldera Systems - LinuxWorld/InfoWorld
> > nicholas@petreley.com - http://www.petreley.com - Eph 6:12
> > **********************************************************
> > .
> >
> 
> --------------------------------------------------------------------
> Robert Nedbal - Czech Technical University in Prague, Czech Republic
> email: R.Nedbal@sh.cvut.cz             http://www.sh.cvut.cz/~robik/
>           /* Debuggers are evil. Never ever trust them. */
> --------------------------------------------------------------------
> 

-- 
**********************************************************
Nicholas Petreley   Caldera Systems - LinuxWorld/InfoWorld
nicholas@petreley.com - http://www.petreley.com - Eph 6:12
**********************************************************
.
