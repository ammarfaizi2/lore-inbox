Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVFNP2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFNP2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVFNP2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:28:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13587 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261153AbVFNP2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 11:28:16 -0400
Message-Id: <200506141527.j5EFRV5K014080@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: =?ISO-8859-1?Q?Mattias Engdeg=E5rd?= <mattias@virtutech.se>
Cc: cfriesen@nortel.com, jakub@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, dwmw2@infradead.org,
       drepper@redhat.com
Subject: Re: Add pselect, ppoll system calls. 
In-Reply-To: Your message of "Tue, 14 Jun 2005 16:07:54 +0200."
             <200506141407.j5EE7sZ11314@virtutech.se> 
From: Valdis.Kletnieks@vt.edu
References: <200506131938.j5DJcKc10799@virtutech.se> <42ADE52E.1040705@nortel.com> <200506132008.j5DK8t010817@virtutech.se> <200506132023.j5DKNhoG021339@turing-police.cc.vt.edu>
            <200506141407.j5EE7sZ11314@virtutech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118762850_3658P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jun 2005 11:27:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118762850_3658P
Content-Type: text/plain; charset=us-ascii

On Tue, 14 Jun 2005 16:07:54 +0200, =?ISO-8859-1?Q?Mattias Engdeg=E5rd?= said:
> >Monotonic clocks are guaranteed to not go backward. A sudden warp 35
> >seconds into the future when you have timers set for 15 and 20
> >seconds into the future is still ugly....
> 
> I don't have the POSIX specs handy, but I see no reason we could not let
> it use a warpless monotonic clock.

Right - I just mentioned it because "warpless" is an additional constraint
on the clock implementation.

The last time I looked at the NTP code, there was a definite upper limit to
how much warpless slewing of the clock was easily achievable - if you had a
large initial adjustment to make, you still have to either take one large
step, or be prepared to spend literally hours/days slewing the clock.

And then there's always the sysadmin issuing a 'date' command to manually
set the clock.  The kernel *still* needs to be able to handle warps correctly,
because I believe 'date' *is* in Posix? ;)

(The other possible way to handle this is the old IBM S/370 way - where setting
the system clock by warping it was only practical during system boot (as it was
done before any timers got launched), and required an operator intervention to
hit the 'TOD Clock Set Enable' button.  So the operator would look at their
watch, enter a time 15-20 seconds into the future, and whack the button at the
specified time).


--==_Exmh_1118762850_3658P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrvdicC3lWbTT17ARAs/OAJ9LWAdpqhI4a+8fOZFHBGkNZHT2DgCgj/vA
m0pX1XlU5fpH63WD9/Pwqks=
=Gp1R
-----END PGP SIGNATURE-----

--==_Exmh_1118762850_3658P--
