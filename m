Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272670AbRIGORU>; Fri, 7 Sep 2001 10:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272672AbRIGORK>; Fri, 7 Sep 2001 10:17:10 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:64313 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S272670AbRIGOQ6>; Fri, 7 Sep 2001 10:16:58 -0400
Date: Fri, 7 Sep 2001 09:17:16 -0500
From: Tim Walberg <twalberg@mindspring.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: nfs is stupid ("getfh failed")
Message-ID: <20010907091716.A15494@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	Michael Rothwell <rothwell@holly-springs.nc.us>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman> <15256.46017.7716.689482@notabene.cse.unsw.edu.au> <000c01c1379c$c427c0d0$81d4870a@cartman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000c01c1379c$c427c0d0$81d4870a@cartman> from Michael Rothwell on 09/07/2001 07:58
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09/07/2001 08:58 -0400, Michael Rothwell wrote:
>>	From: "Neil Brown" <neilb@cse.unsw.edu.au>
>>=09
>>	> This is not allowed, and makes no sense.
>>=09
>>	It apparently is (or was, anyway) allowed, because it worked until the
>>	server was rebooted. Fluke?
>>	Are you saying that, if I export "/export", I can mount "/export/home" f=
rom
>>	a client machine? That's nice.
>>=09

Yes. At least that's how Solaris, Irix, HP/UX, and several others do it. The
general rule is something along the lines of "if /a is exported, anything t=
hat
is a subdirectory of /a is accessible via NFS, so long as it is on the same
device (partition - actually major/minor pair)". So, if /export/home in your
case lives in the same file system as /export, it is accessible via NFS
as well. Now if /export/home is it's own mount point (i.e. a separate file
system), then it needs to be exported explicitly.

>>	> Simply remove the second line and your problems should go away.
>>=09
>>	Thanks. I actually switched to two explicit exports; /export/files and
>>	/export/home, which works.
>>=09

This works as well, with the caveat that you cannot then mount /export itse=
lf
on client machines.

				tw

--=20
twalberg@mindspring.com

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO5jW68PlnI9tqyVmEQJ4JACg4i6YPMVzX+Osk6Ux3K+PErFIu9oAnjsW
p4exFfRqLseFqynBtt8FSTTZ
=g35d
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
