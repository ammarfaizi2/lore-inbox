Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSHLMAH>; Mon, 12 Aug 2002 08:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317891AbSHLMAH>; Mon, 12 Aug 2002 08:00:07 -0400
Received: from ppp-217-133-217-5.dialup.tiscali.it ([217.133.217.5]:38552 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S317888AbSHLMAG>;
	Mon, 12 Aug 2002 08:00:06 -0400
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
	mips, m68k, sh, cris to use it
From: Luca Barbieri <ldb@ldb.ods.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20995.1029151008@redhat.com>
References: <1028850350.28882.121.camel@irongate.swansea.linux.org.uk> 
	<Pine.LNX.4.44.0208082357170.8911-100000@serv>
	<1028844681.1669.80.camel@ldb>   <20995.1029151008@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-FSGQDFUJR5MQe51Ot+eh"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Aug 2002 14:03:41 +0200
Message-Id: <1029153821.4713.13.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FSGQDFUJR5MQe51Ot+eh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-08-12 at 13:16, David Woodhouse wrote:
> 
> alan@lxorguk.ukuu.org.uk said:
> >  Possibly not - volatile doesnt guarantee the compiler won't do
> > 	x = 1
> > 	add *p into x
> > 	store x into *p
> 
> Er, AIUI 'volatile' guarantees that '*p++' will do precisely that. It's a 
> load, an add and a store, and the rules about volatile mean that the load 
> and the store _must_ be separate.

I noticed that while testing how rmk's code behaved differently than
mine (and corrected in the v2 patch).
Before that, I just assumed that since the CPU must anyway issue a
separate load and store, the compiler would use the faster instruction
(that's why there is a LOCK prefix in the i386 instruction set).


--=-FSGQDFUJR5MQe51Ot+eh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9V6Qcdjkty3ft5+cRAtv4AJ9vHSVBZshyveJpn2CfcMMwVlKHiQCeNFf1
2+25AhFYgCtq6fseSV9usBA=
=pwoL
-----END PGP SIGNATURE-----

--=-FSGQDFUJR5MQe51Ot+eh--
