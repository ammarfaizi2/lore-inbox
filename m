Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVFPD1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVFPD1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 23:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVFPD1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 23:27:38 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:19144 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261719AbVFPD1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 23:27:31 -0400
Date: Thu, 16 Jun 2005 13:26:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bodo Eggert <7eggert@gmx.de>
Cc: macro@linux-mips.org, linux-os@analogic.com, gene.heskett@verizon.net,
       cutaway@bellsouth.net, linux-kernel@vger.kernel.org
Subject: Re: .../asm-i386/bitops.h  performance improvements
Message-Id: <20050616132659.65a72842.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.58.0506152053010.3184@be1.lrz>
References: <4fB8l-73q-9@gated-at.bofh.it>
	<4fF2j-1Lo-19@gated-at.bofh.it>
	<E1DiZKe-0000em-58@be1.7eggert.dyndns.org>
	<Pine.LNX.4.61L.0506151629270.13835@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.61.0506151200490.24211@chaos.analogic.com>
	<Pine.LNX.4.61L.0506151723460.13835@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.58.0506152053010.3184@be1.lrz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__16_Jun_2005_13_26_59_+1000_5Zf8VOvDIN4/MKBp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__16_Jun_2005_13_26_59_+1000_5Zf8VOvDIN4/MKBp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jun 2005 21:10:26 +0200 (CEST) Bodo Eggert <7eggert@gmx.de> wrot=
e:
>
> My documentation says:
>=20
> lea reg16, mem
> Available on 8086, 80186, 80286, 80386, 80486
> 32-bit-extension available
> Opcode: 8D mod reg r/m
>=20
> reg will be the target register (AX .. DI), and mod and r/m will select
> something like a direct address, a register or a combination like=20
> BP+DI+ofs (I won't copy the table). A multiplier is not mentioned there.

In 32 bit mode on the 386 and above, a two byte version of the "mod reg
r/m" is possible which contains the scaling field ...

On the 386, using a second register in the ea calculation costs another
cycle.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__16_Jun_2005_13_26_59_+1000_5Zf8VOvDIN4/MKBp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCsPGL4CJfqux9a+8RAgQXAJ9nDzcq2m3fY5oujfgk1Ww/ENWLMQCfUA+g
3kZU3xoam6BPvqKpyMcwsLw=
=F+zj
-----END PGP SIGNATURE-----

--Signature=_Thu__16_Jun_2005_13_26_59_+1000_5Zf8VOvDIN4/MKBp--
