Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbSKLXSA>; Tue, 12 Nov 2002 18:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbSKLXSA>; Tue, 12 Nov 2002 18:18:00 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56580 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267023AbSKLXR6>; Tue, 12 Nov 2002 18:17:58 -0500
Date: Tue, 12 Nov 2002 18:23:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Adam Voigt <adam@cryptocomm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
In-Reply-To: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
Message-ID: <Pine.LNX.3.96.1021112181941.26099A-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"; BOUNDARY="=-gjU1b+qYiuNy2hSLpQYr"
Content-ID: <Pine.LNX.3.96.1021112181941.26099B@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--=-gjU1b+qYiuNy2hSLpQYr
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.3.96.1021112181941.26099C@gatekeeper.tmr.com>

On 12 Nov 2002, Adam Voigt wrote:

> I have a directory with 39,000 files in it, and I'm trying to use the cp
> command to copy them into another directory, and neither the cp or the
> mv command will work, they both same "argument list too long" when I
> use:
> 
> cp -f * /usr/local/www/images
> 
> or
> 
> mv -f * /usr/local/www/images
> 
> Is this a kernel limitation? If yes, how can I get around it?
> If no, anyone know a workaround? I appreciate it.

Sort of, there is a limit to how many k of arguments you can have on a
command line. Having grown up with much smaller limits in early UNIX, I
got into the habit of using xargs when I wasn't sure. You can avoid one
exec per file behaviour by something like:
  ls | xargs -l50 echo | xargs -i mv "{}" destdir

You can also do useful things by using find and the -p option of cpio.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--=-gjU1b+qYiuNy2hSLpQYr
Content-Type: APPLICATION/PGP-SIGNATURE; NAME="signature.asc"
Content-ID: <Pine.LNX.3.96.1021112181941.26099D@gatekeeper.tmr.com>
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA90SCPF9k9BmZXCWYRAqlsAJoCW1C/DfWSlwOiVQulcNLidr8RrACeIEph
MgAaBBF1vNaDnpS0rXfC/NI=
=Cd37
-----END PGP SIGNATURE-----

--=-gjU1b+qYiuNy2hSLpQYr--
