Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSCMRFO>; Wed, 13 Mar 2002 12:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310827AbSCMRFE>; Wed, 13 Mar 2002 12:05:04 -0500
Received: from foo-bar-baz.cc.vt.edu ([128.173.14.103]:63897 "EHLO
	foo-bar-baz.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S310835AbSCMREy>; Wed, 13 Mar 2002 12:04:54 -0500
Message-Id: <200203131703.g2DH3ij6019570@foo-bar-baz.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Alexander Viro <viro@math.psu.edu>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Rik van Riel <riel@conectiva.com.br>, Hans Reiser <reiser@namesys.com>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: PROBLEM: Kernel Panic on 2.5.6 and 2.5.7-pre1 boot [PATCH] and discussion of Linux testing procedures 
In-Reply-To: Your message of "Wed, 13 Mar 2002 09:09:52 EST."
             <Pine.GSO.4.21.0203130903470.22930-100000@weyl.math.psu.edu> 
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
In-Reply-To: <Pine.GSO.4.21.0203130903470.22930-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_946383256P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Mar 2002 12:03:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_946383256P
Content-Type: text/plain; charset=us-ascii

On Wed, 13 Mar 2002 09:09:52 EST, Alexander Viro said:

> Proposal is a bit naive, though - in most of the cases fuckups merrily
> pass original testing.


We're not going to create a testing procedure that will find all bugs,
since that's essentially impossible.  On the other hand, I think we
all need to collectively take 24 or 48 hour off, spend the time downing
several <insert beverage here>, and see if anybody has a good proposal
that would catch 90% of the show-stopper bugs that have slipped through
so far in the 2.4 and 2.5 series, without complicating matters TOO much.

Here's a simple one:  a -rcN release has to sit there at least 96
hours before it gets tagged as "final".  That's something we've been
quite poor at so far:

rel     final         last -pre rel        delay
2.4.1  29 Jan 23:56  -pre12 29 Jan 10:16      13h40m
2.4.2  21 Feb 17:00  -pre4  16 Feb 11:17   5d  3h45m  (2 weekend days)
2.4.3  29 Mar 21:03  -pre8  25 Mar 20:08   4d  1h
2.4.4  27 Apr 18:43  -pre8  26 Apr 10:58   1d  7h45m
2.4.5  25 May 18:26  -pre6  24 May 17:47   1d  0h45m
2.4.6  03 Jul 17:07  -pre9  02 Jul 17:41      23h45m  (all on weekend)
2.4.7  20 Jul 14:25  -pre9  19 Jul 22:03      16h22m
2.4.8  10 Aug 21:13  -pre8  09 Aug 17:34   1d  3h45m
2.4.9  16 Aug 11:32  -pre4  14 Aug 19:06   1d 16h24m
2.4.10 23 Sep 11:30  -pre15 22 Sep 20:58      14h32m  (all on weekend)
2.4.11 09 Oct 16.55  -pre6  08 Oct 14:18   1d  2h37m
2.4.12 11 Oct 00:59  <none>                --  -----
2.4.13 23 Oct 22:28  -pre6  21 Oct 10:54   1d 11h30m  (1 weekend day)
2.4.14 05 Nov 15:30  -pre8  03 Nov 17:42   1d 21h45m  (2 weekend days)
2.4.15 22 Nov 22:18  -pre9  21 Nov 22:46      23h28m
2.4.16 26 Nov 05:32  -pre1  24 Nov 12:05   1d 17h27m  (2 weekend days)
2.4.17 21 Dec 09:52  -rc2   18 Dec 13:38   2d 18h14m
2.4.18 25 Feb 11:40  -rc4   22 Feb 04:28   3d  7h12m  (2 weekend days)

So even in many cases where there *were* 2 or 3 day waits, they were
across a weekend - which means quite likely a lot of people didn't
test because they were *home* having *lives*.

Think about it.  "Just wait 96 hours".

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_946383256P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE8j4ZwcC3lWbTT17ARAkgnAKCbVEBe62bCZRIb3YI9kosca4nsewCfX5xd
DH0wh77ZwDhwbbrn2jFlKzM=
=xe8C
-----END PGP SIGNATURE-----

--==_Exmh_946383256P--
