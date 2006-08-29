Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWH2Jk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWH2Jk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWH2Jk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:40:28 -0400
Received: from natgw.netstream.ch ([62.65.128.28]:57846 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750839AbWH2Jk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:40:28 -0400
Date: Tue, 29 Aug 2006 11:40:14 +0200
From: Nico Schottelius <nico-kernel20060829@schottelius.org>
To: Neil Brown <neilb@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem with md: Not rebuilding rai5
Message-ID: <20060829094014.GC21160@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel20060829@schottelius.org>,
	Neil Brown <neilb@suse.de>, LKML <linux-kernel@vger.kernel.org>
References: <20060829091205.GB21160@schottelius.org> <17652.2140.871672.919816@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <17652.2140.871672.919816@cse.unsw.edu.au>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.17.6-hydrogenium
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Neil Brown [Tue, Aug 29, 2006 at 07:26:52PM +1000]:
> On Tuesday August 29, nico-kernel20060829@schottelius.org wrote:
> > Hello!
> >=20
> > I created a degrated raid5 on top of md1 and hde1. Then moved the data
> > from /dev/hdk to the mounted raid5, and then added hdk1 (repartitoned)
> > to the array. The sync began, but after that hde1 was faulty.
>=20
> So you created a raid5 containing one drive that was already faulty.
> That is unfortunate!

And reported in the manpage of mdadm to be usable (simply specify "missing"
as keyword).

> > I removed it, readded it, but now I've a raid5 with only one active
> > disk (which should not be possible imho, a raid5 always needs 2 disks)
> > AND what's even stranger for me, I've two spare disks.
>=20
> If you have a raid5 with 2 working drives and one fails, how many
> working drives do you expect to be left?  1.  So the raid is no longer
> fully functional.

That is what I also thought. But there are some points that make me
wonder:
   a) why is hdk1 marked as spare? I added it this morning and the
   rebuilt began. Though something happened (I do not know what)
   and made hdk1 not beeing in the array. (dmesg output
   is now available at
   http://home.schottelius.org/~nico/linux/debug/raid/raid5.strange.dmesg)

   b) what's the reason, linux does not mark md2 as faulty?

> You might be able to read some data, but you want
> able to write.
> What did you expect to happen when hde1 failed?

I expected hdk1 and md1 to work.

> > Is there a way to force rebuilding the array?
>=20
> Well, you can create the array over md1 and hde1 again, and your data
> should still be there, but it will just  fail again whenever it tries
> to access the block on hde1 which is bad.

That's clear.

> I suggest you:
>   - recreate the array over md1 and hde1
>   - copy the data back to hdk
>   - stop the array
>   - replace hde1
>   - make the array.
>   - read the entire array (dd > /dev/null) to make sure it is safe
>   - copy data back from hdk

Will linux detect, that md1 and hde1 are from the same array
and will it see which harddisk is xored with which one?

Perhaps this is the only way to go. I hope I did not loose too much
data with my 'moving to raid5'-experiement.

Thanks for the suggestions so far!

Nico

--=20
``...if there's one thing about Linux users, they're do-ers, not whiners.''
(A quotation of Andy Patrizio I completely agree with)

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iQIVAwUBRPQLfbOTBMvCUbrlAQLYLA/+NgGVLtavoAni5Zsv/A6NCe4aEmb7TggR
DbGH+C/NeJz5thZhLQK0O8Tushx03d4cwq8fUBWCtMr3OAh6tuoRDcJ5+zZTgVYc
E93AjtNl8GtBC2X/i13LLrRE2xOM2P3yryIac4y7bY74o9ysMNsACzAPpZqQ9FIR
4KSnr6nKb4r78n0qjqxX2KWEEWrcfkP2DAdDf4BPkYgS10JkMLDj8inMf3vYKo3D
xo6AQUFlb2kUzHodY2wKmWA4AgsiQsZMBbsfCKSltiEw/0WEYM9ho5YUHUM+U2YC
GsQp2xogkxCQB0x5jSAHVsIU1DtjLrCKEsFkzkNMdCO5vPvz+3/jsI5CTPCMGsU7
l9XYJTYAQLnRrRLtwoVhAcS8YqPnlxFFKmJZls97dmUcXtcFxWi21DswC+HAfmnt
WXrZUfhlbCoHOd0x9ciozrFDF5A3Zv6LZWjFRpjX3pxXRBG2s0C2TaKUMt1Sqnsv
Mgkr6lVAWAlW9E2DJKB+yuTm8vD+KpTdOOW9ezRYxLoCYKYb7tDBmc4tLrTactwH
Aww/StqfvG4W8bFQ08l4G8BqtfPlFtAHO2YzCCa6Yx7+xg5vfNS0tFwwM0LWaZBe
dnnkhDVASurwWcrLkm93aAihQ8fULKGtYuyzGHnCo9hOfLA3FTh55EBs6FumGFz9
V+qm5E9voz4=
=HxiW
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
