Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTB0Jsq>; Thu, 27 Feb 2003 04:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTB0Jsq>; Thu, 27 Feb 2003 04:48:46 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:17404 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262796AbTB0Jsp>; Thu, 27 Feb 2003 04:48:45 -0500
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3E5DB2CA.32539D41@daimi.au.dk>
	<buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3E5DCB89.9086582F@daimi.au.dk>
	<buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3E5DDE5A.1BCD0747@daimi.au.dk>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 27 Feb 2003 18:58:59 +0900
In-Reply-To: <3E5DDE5A.1BCD0747@daimi.au.dk>
Message-ID: <buor89uqc2k.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont <kasperd@daimi.au.dk> writes:
> > > But AFAIK fsck uses mtab.
> > 
> > It uses /etc/fstab.
> 
> [kasperd:pts/0:~] grep /etc/mtab /sbin/fsck*
> Binary file /sbin/fsck.ext2 matches
> Binary file /sbin/fsck.ext3 matches
> Binary file /sbin/fsck.minix matches
> [kasperd:pts/0:~] 

God know why; the versions (e2fsprogs 1.32) on my system don't, so it's
probably not something very important.  fsck should still work fine.

> > Unless you use the `-n' flag, which an init-script should do if it
> > knows there's something wierd required to get /var mounted or something.
> 
> Of course the -n flag can be used to some extent, but that doesn't
> solve all our problems.  Current rc.sysinit implementations does use
> -n to mount a few filesystems, and later uses -f to initialize the
> mtab.  But all that happens before running fsck, so if /var is mounted
> that early, we are going to fsck it mounted.

So the init scripts are badly written, what can I say?  `Don't do that.'

-Miles
-- 
"Most attacks seem to take place at night, during a rainstorm, uphill,
 where four map sheets join."   -- Anon. British Officer in WW I
