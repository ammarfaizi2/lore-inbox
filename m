Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268329AbTBNKBD>; Fri, 14 Feb 2003 05:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268330AbTBNKBD>; Fri, 14 Feb 2003 05:01:03 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:30711 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S268329AbTBNKBB>; Fri, 14 Feb 2003 05:01:01 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.60-mm2
Date: Fri, 14 Feb 2003 11:10:41 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030214013144.2d94a9c5.akpm@digeo.com> <20030214093856.GC13845@codemonkey.org.uk>
In-Reply-To: <20030214093856.GC13845@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_pCMT+DYGeShQy4x";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302141110.49348.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_pCMT+DYGeShQy4x
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On Friday, 14. February 2003 10:38, Dave Jones wrote:
> On Fri, Feb 14, 2003 at 01:31:44AM -0800, Andrew Morton wrote:
>  > . Considerable poking at the NFS MAP_SHARED OOM lockup.  It is limping
>  >   along now, but writeout bandwidth is poor and it is still struggling.
>  >   Needs work.
>  >
>  > . There's a one-liner which removes an O(n^2) search in the NFS
>  > writeback path.  It increases writeout bandwidth by 4x and decreases C=
PU
>  > load from 100% to 3%.  Needs work.
>
> I'm puzzled that you've had NFS stable enough to test these.
> How much testing has this stuff had? Here 2.5.60+bk clients fall over und=
er
> moderate NFS load. (And go splat quickly under high load).
>
> Trying to run things like dbench causes lockups, fsx/fstress made it
> reboot, plus the odd 'cheating' errors reported yesterday.
>
> 		Dave

I've got NFS problems with 2.5.5x - 60-bk3, too, but here I can workaround=
=20
them by simply pinging the NFS-server every second... Funny, but it works!
Perhaps this can help finding the real bug?!

  Thomas
--Boundary-02=_pCMT+DYGeShQy4x
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+TMCpYAiN+WRIZzQRAkV8AJwKY8v7t1jvBMFbyNXaFt1c5QzKbQCdFcXB
/KQsXPQPTki+B5HzH3QsQZc=
=PNko
-----END PGP SIGNATURE-----

--Boundary-02=_pCMT+DYGeShQy4x--

