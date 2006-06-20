Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWFTI0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWFTI0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWFTI0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:26:34 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:35537 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S965001AbWFTI0d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:26:33 -0400
Message-ID: <4497B126.4000408@bull.net>
Date: Tue, 20 Jun 2006 10:26:14 +0200
From: Laurent Vivier <Laurent.Vivier@bull.net>
Organization: Bull S.A.S.
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Qi Yong <qiyong@fc-cn.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       alex@clusterfs.com, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org>	<1149885135.5776.100.camel@sisko.sctweedie.blueyonder.co.uk>	<Pine.LNX.4.64.0606091344290.5498@g5.osdl.org> <4497927F.4070307@fc-cn.com>
In-Reply-To: <4497927F.4070307@fc-cn.com>
X-Enigmail-Version: 0.94.0.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/06/2006 10:30:15,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/06/2006 10:30:17,
	Serialize complete at 20/06/2006 10:30:17
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9E9CDA42B220698FCA17ABA6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E9CDA42B220698FCA17ABA6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Qi Yong wrote:
> Linus Torvalds wrote:
>=20
>> On Fri, 9 Jun 2006, Stephen C. Tweedie wrote:
>> =20
>>
>>> When is the Linux syscall interface enough?  When should we just bump=
 it
>>> and cut out all the compatibility interfaces?
>>>
>>> No, we don't; we let people configure certain obsolete bits out (a.ou=
t
>>> support etc), but we keep it in the tree despite the indirection cost=
 to
>>> maintain multiple interfaces etc.
>>>   =20
>>>
>> Right. WE ADD NEW SYSTEM CALLS. WE DO NOT EXTEND THE OLD ONES IN WAYS =
THAT=20
>> MIGHT BREAK OLD USERS.
>>
>> Your point was exactly what?
>>
>> Btw, where did that 2TB limit number come from? Afaik, it should be 16=
TB=20
>> for a 4kB filesystem, no?
>> =20
>>
>=20
> Partition tables describe partitions in units of one sector.
> 2^(32+9) =3D 2T
>=20
> To prevent integer overflow, we should use only 31 bits of a 32-bit int=
eger.
> 2^(31+12) =3D 8T
>=20
> There's _terrible_ hacks to really get to 16T.
>=20
> -- qiyong
>=20

IMHO, a simple solution is to use "Logical Volume Manager" instead of par=
tition
manager: we create 64bit filesystem in a Logical Volume, not in a partiti=
on.

"partitioning is obsolete" ;-)

Regards,
Laurent

--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4


--------------enig9E9CDA42B220698FCA17ABA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFEl7Eq9Kffa9pFVzwRAnegAJ9qmnAQT8FsgHL4QmwS9ocR1W2X7QCeOFr3
2yXHSlWvhIdvdXh0yhGvvA8=
=Pdyx
-----END PGP SIGNATURE-----

--------------enig9E9CDA42B220698FCA17ABA6--
