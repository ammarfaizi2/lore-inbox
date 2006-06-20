Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWFTKk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWFTKk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWFTKk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:40:59 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:21221 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932574AbWFTKk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:40:57 -0400
Message-ID: <4497D0A9.6060704@bull.net>
Date: Tue, 20 Jun 2006 12:40:41 +0200
From: Laurent Vivier <Laurent.Vivier@bull.net>
Organization: Bull S.A.S.
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: Qi Yong <qiyong@fc-cn.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       alex@clusterfs.com, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org>	<1149885135.5776.100.camel@sisko.sctweedie.blueyonder.co.uk>	<Pine.LNX.4.64.0606091344290.5498@g5.osdl.org> <4497927F.4070307@fc-cn.com> <4497B126.4000408@bull.net> <4497B230.5000508@garzik.org> <4497BE00.1040409@bull.net> <4497C485.7000400@garzik.org>
In-Reply-To: <4497C485.7000400@garzik.org>
X-Enigmail-Version: 0.94.0.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/06/2006 12:44:45,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/06/2006 12:44:47,
	Serialize complete at 20/06/2006 12:44:47
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1EB8216EEB9A54DB7037A0B3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1EB8216EEB9A54DB7037A0B3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> Laurent Vivier wrote:
>> Jeff Garzik wrote:
>>> Laurent Vivier wrote:
>>>> Qi Yong wrote:
>>>>> Linus Torvalds wrote:
>>>>>
>>>>>> On Fri, 9 Jun 2006, Stephen C. Tweedie wrote:
>>>>>> =20
>>>>>>
>>>>>>> When is the Linux syscall interface enough?  When should we just
>>>>>>> bump it
>>>>>>> and cut out all the compatibility interfaces?
>>>>>>>
>>>>>>> No, we don't; we let people configure certain obsolete bits out
>>>>>>> (a.out
>>>>>>> support etc), but we keep it in the tree despite the indirection
>>>>>>> cost to
>>>>>>> maintain multiple interfaces etc.
>>>>>>>  =20
>>>>>> Right. WE ADD NEW SYSTEM CALLS. WE DO NOT EXTEND THE OLD ONES IN
>>>>>> WAYS THAT MIGHT BREAK OLD USERS.
>>>>>>
>>>>>> Your point was exactly what?
>>>>>>
>>>>>> Btw, where did that 2TB limit number come from? Afaik, it should b=
e
>>>>>> 16TB for a 4kB filesystem, no?
>>>>>> =20
>>>>>>
>>>>> Partition tables describe partitions in units of one sector.
>>>>> 2^(32+9) =3D 2T
>>>>>
>>>>> To prevent integer overflow, we should use only 31 bits of a 32-bit=

>>>>> integer.
>>>>> 2^(31+12) =3D 8T
>>>>>
>>>>> There's _terrible_ hacks to really get to 16T.
>>>>>
>>>>> -- qiyong
>>>>>
>>>> IMHO, a simple solution is to use "Logical Volume Manager" instead o=
f
>>>> partition
>>>> manager: we create 64bit filesystem in a Logical Volume, not in a
>>>> partition.
>>> That doesn't solve anything, if you are not using a 64bit filesystem.=

>>
>> Sorry, I don't undestand why ???
>>
>> You can use 32bit filesystem too, but you limit the size of the
>> logical volume
>> to be compatible with the filesystem you use. LVM allows to create
>> several 32bit
>> volumes on a big (> 8T) disk (if exists)
>=20
> Let's review the thread:
>=20
> qiyong: <these limits> exist in the filesystem
> you: bust those limits with LVM!
>=20
> I think you are misunderstanding the subthread.
>=20

Yes...

I understood:
qiyong: <these limits> exist in the partition manager.

(because with patches proposed on http://www.bullopensource.org/ext4 thes=
e
limits don't exist anymore in the filesystem.)

Regards,
Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4


--------------enig1EB8216EEB9A54DB7037A0B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFEl9Cv9Kffa9pFVzwRAsbiAKCOf70EE56Tk1XGkNwibp3VSnY0vgCfQO1v
IFStSksvLJM8UkQl/c0pNJA=
=/jhJ
-----END PGP SIGNATURE-----

--------------enig1EB8216EEB9A54DB7037A0B3--
