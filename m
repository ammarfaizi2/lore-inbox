Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTDYRhc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 13:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTDYRhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 13:37:32 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50049 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263415AbTDYRha (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 13:37:30 -0400
Message-Id: <200304251748.h3PHmjQd012895@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: versioned filesystems in linux (was Re: kernel support for 
In-Reply-To: Your message of "Fri, 25 Apr 2003 13:06:18 EDT."
             <Pine.LNX.4.53.0304251259300.6839@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <200304251618.h3PGINWP001520@81-2-122-30.bradfords.org.uk>
            <Pine.LNX.4.53.0304251259300.6839@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_200861245P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Apr 2003 13:48:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_200861245P
Content-Type: text/plain; charset=us-ascii

On Fri, 25 Apr 2003 13:06:18 EDT, "Richard B. Johnson" said:
> On Fri, 25 Apr 2003, John Bradford wrote:

> > Just wondering how difficult it would be to make a 9-track tape drive
> > from scratch, and connect it up to the parallel port...  Do you think
> > that old hard disk motors, from 5.25" MFM disks be powerful enough for
> > the 120IPS tape transport?
> >
> > John.
> 
> The disk-drive motors, even for the 5.25 floppies were pancake motors
> designed to directly turn the floppy, or run a belt with a small
> ratio. You need a motor that runs at relatively high speed to turn the
> capstan. If the capstan was 1 inch in circumference (about 0.2'' in
> diameter), you need 120 revs/sec = 7200 r.p.m.  You won't do this with
> a floppy motor.

It's not that bad, actually - the capstan is more like 4 inches across, and the
minimum actual diameter of the tape is about 6 inches, giving a circumference
of 18" so you only need about 400RPM at the "empty" reel and maybe half that at
the "full" reel.

(More than you ever wanted to know about old tape drives, probably ;)

Of bigger concern is that the inter-block gap is only 0.5 (or maybe 0.75
inches, the memories are dim ;) - and you need to be able to stop and then get
back up to speed in that distance (or decelerate, rewind, and get a running
start).  This was why the IBM3420 (and predecessor) tape drives had vacuum
columns - there'd be a loop of up to 5-6 feet in a column on each side of the
head.  To move the tape for a single block, it would increase suction on one
column, causing the tape to be pulled in, and reduce it in the other, feeding
tape out.  Since the weight of the 6-10 feet of tape being moved is low,
acceleration is quite fast - a 3420 doesn't stream continuously, and it's QUITE
possible to be writing short blocks (80 bytes or so at 6250 bytes per inch,
which results in an actual block of about half an inch) where the tape stops,
accelerates, writes, stops, etc.. and still maintain 200 inches per second
throughput (yes, the vacuum columns ARE emitting a 200hz square wave sound when
you do this - programs have been done to play music by using different block
sizes...)

The actual capstans would then have several foot of buffering to get up to
speed (or stop), which was needed as the rotational inertia of a full 2400 foot
9 track tape is *not* trivial.  Low-end 9-track transports did a cheaper
version of this, using 2 tension arms and a drive motor near the head, similar
to audiophile reel-to-reel tape transports.


--==_Exmh_200861245P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+qXT3cC3lWbTT17ARAqwzAKC0NZ3Tth9V6QN0/+Dusa65j7ND4ACfSCqq
ofwyH2aWRlXjXimYISon1NM=
=Lp3k
-----END PGP SIGNATURE-----

--==_Exmh_200861245P--
