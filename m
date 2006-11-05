Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161686AbWKETvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161686AbWKETvN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 14:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161687AbWKETvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 14:51:13 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:32703 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1161686AbWKETvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 14:51:12 -0500
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Andi Kleen <ak@suse.de>
Subject: Re: [Opps] Invalid opcode
Date: Sun, 5 Nov 2006 21:51:06 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>,
       Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>
References: <200611051507.37196.caglar@pardus.org.tr> <200611051917.56971.caglar@pardus.org.tr> <200611051957.45260.ak@suse.de>
In-Reply-To: <200611051957.45260.ak@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1399515.S75ohVJijM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611052151.14861.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1399515.S75ohVJijM
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi;

05 Kas 2006 Paz 20:57 tarihinde, Andi Kleen =C5=9Funlar=C4=B1 yazm=C4=B1=C5=
=9Ft=C4=B1:=20
> Can you test with "noreplacement" to make sure?

I sorry for not to mention that, i tried noreplacement before reporting whi=
ch=20
is also ends up with same panic.

> Anyways I suspect we're just getting back some variant of the old CPU set=
up
> race.
>
> Normally CPU booting in Linux follows a special "cpu hotplug" state
> machine, but for historical reasons i386 only implements one state of=20
> this. At one point we had a similar bug (but not in the callback on CPU #=
0,
> but in the timer on newly booted CPU). I don't see currently how it can
> happen (but i haven't thought very deeply about it yet)
>
> Probably your timing is just unlucky on those simulators.

Hmm, Novell bugzilla seems has similiar issues,=20
https://bugzilla.novell.com/show_bug.cgi?id=3D204647 and its duplicated one=
s=20
gaves same or similiar panic outputs.

> Previously we avoided converting i386 cpu bootup fully to the new state
> machine because it is very fragile, but it's possible that there
> is no other choice than to do it properly. Or maybe another kludge
> is possible.

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1399515.S75ohVJijM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFTkCyy7E6i0LKo6YRAtnwAJ9SOfoqYGUjS+el7sa4ScrqF8decQCgpZNB
o/zKGlqv0NFl30mc0LErMfw=
=onCO
-----END PGP SIGNATURE-----

--nextPart1399515.S75ohVJijM--
