Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265407AbTGAA05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 20:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTGAA05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 20:26:57 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54730 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265407AbTGAA0t (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 20:26:49 -0400
Message-Id: <200307010041.h610f6jn016310@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.73-mm2 - odd audio problem, bad intel8x0/ac97 clocking. 
In-Reply-To: Your message of "Mon, 30 Jun 2003 17:25:48 PDT."
             <1057019147.28319.367.camel@w-jstultz2.beaverton.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <200306282131.h5SLVjGk001833@turing-police.cc.vt.edu>
            <1057019147.28319.367.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-343649577P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Jun 2003 20:41:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-343649577P
Content-Type: text/plain; charset=us-ascii

On Mon, 30 Jun 2003 17:25:48 PDT, john stultz said:
> On Sat, 2003-06-28 at 14:31, Valdis.Kletnieks@vt.edu wrote:
> > 2.5.73-mm1 is fine.
> > 
> > This is *not* the "clock runs really really fas"t issue - I left -mm2 runni
ng overnight and
> > in some 8 hours the system clock only drifted a few seconds versus wall clo
ck (and it's
> > possible it was off a few seconds when it booted, as it didn't get an NTP s
ync at boot).
> > 
> > Audio plays "too fast" - a 4 minute .ogg goes through in about 3:40, soundi
ng a bit
> > high-pitched in the process.
> 
> > Any ideas?
> 
> Hrmmm. Are you seeing something like:
> 
> Loosing too many ticks!
> TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> Falling back to a sane timesource.

Nope, it's a pretty clear bug in the Speedstep code leaving loops_per_jiffies bogus.

I posted a follow-up note explaining in more detail...

--==_Exmh_-343649577P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ANihcC3lWbTT17ARAllIAJ0TOe77YE0f6dSOxfY+2EnqBGQYgwCfSSDl
8BD2V2JElj0q/BaCajgJE2A=
=uCS2
-----END PGP SIGNATURE-----

--==_Exmh_-343649577P--
