Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266328AbUFZR3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266328AbUFZR3y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 13:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUFZR3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 13:29:54 -0400
Received: from mout0.freenet.de ([194.97.50.131]:13972 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S266328AbUFZR3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 13:29:51 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: kernel@kolivas.org
Subject: Re: [PATCH] Staircase scheduler v7.4
Date: Sat, 26 Jun 2004 19:29:33 +0200
User-Agent: KMail/1.6.2
References: <200406251840.46577.mbuesch@freenet.de> <200406252148.37606.mbuesch@freenet.de> <1088212304.40dccd5035660@vds.kolivas.org>
In-Reply-To: <1088212304.40dccd5035660@vds.kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406261929.35950.mbuesch@freenet.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 26 June 2004 03:11, you wrote:
> Quoting Michael Buesch <mbuesch@freenet.de>:
> > But as the load grows, the system is usable as with load 0.0.
> > And it really should be usable with 76.0% nice. ;) No problem here.
> > This really high load is not correct.
>
> There was the one clear bug that Adrian Drzewiecki found (thanks!) that is easy
> to fix. Can you see if this has any effect before I go searching elsewhere?
>
> Con
>

The problem did not go away with this patch.
I did some stress test:

I downloaded latest kdeextragear-3 package from CVS and
ran ./configure script many times.
Directly after booting the script runs fine.
But as the uptime increases (I'm now at 15 minutes, when
the script is stuck completely for the first time),
my problem gets worse.
At the very beginning, there was no problem running the script,
but over time problems increased with uptime.
on 5 till 10 minutes of uptime, the configure began to
stuck for 3 or 4 seconds on several (reproducable!) places.#
(you can see these places as nice "holes" in the CPU graph
of gkrellm)
Now (15 min) it's completely stuck and doesn't get a timeslice.

Now another "problem":
Maybe it's because I'm tired, but it seems like
your fix-patch made moving windows in X11 is less smooth.
I wanted to mention it, just in case there's some other
person, who sees this behaviour, too. In case I'm the
only one seeing it, you may forget it. ;)

- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3bJ9FGK1OIvVOP4RAjHVAKCt3li6/x1hGZM6xSXeC2FFyFm2KQCgugWL
KJxX2zg0WcDSkIzP57JcrrY=
=IDNX
-----END PGP SIGNATURE-----
