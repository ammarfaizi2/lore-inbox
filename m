Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTB0IcV>; Thu, 27 Feb 2003 03:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTB0IcV>; Thu, 27 Feb 2003 03:32:21 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:27312 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261907AbTB0IcU>; Thu, 27 Feb 2003 03:32:20 -0500
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3E5DB2CA.32539D41@daimi.au.dk>
	<buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3E5DCB89.9086582F@daimi.au.dk>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 27 Feb 2003 17:42:30 +0900
In-Reply-To: <3E5DCB89.9086582F@daimi.au.dk>
Message-ID: <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont <kasperd@daimi.au.dk> writes:
> > Yes.  On some systems, /var and /tmp are the _only_ read-write filesystems.
> 
> OK, but then on such a system with my approach it would be possible to
> make /mtab.d a symlink pointing to somewhere under /var.

... you could do the same with /etc/mtab.

In fact since /etc is almost guaranteed to be on the same filesystem as
/, it seems like "/mtab.d" offers zero advantages over just /etc/mtab --
the case where /etc/mtab is the most annoying is when /etc is R/O, but
this almost always means that / will be R/O, making /mtab.d useless too.

> But AFAIK fsck uses mtab.

It uses /etc/fstab.

> If mtab does not exist mount will attempt to create a new one with
> only the root listed.

Unless you use the `-n' flag, which an init-script should do if it
knows there's something wierd required to get /var mounted or something.

-Miles
-- 
80% of success is just showing up.  --Woody Allen
