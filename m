Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUFHJUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUFHJUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUFHJUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:20:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264913AbUFHJUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:20:07 -0400
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
	2.6.7-rc2-bk2
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andi Kleen <ak@suse.de>
Cc: Jakub Jelinek <jakub@redhat.com>, torvalds@osdl.org, luto@myrealbox.com,
       mingo@elte.hu, linux-kernel@vger.kernel.org, akpm@osdl.org,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com
In-Reply-To: <20040608111453.22cae15a.ak@suse.de>
References: <20040602205025.GA21555@elte.hu>
	 <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu>
	 <200406040826.15427.luto@myrealbox.com>
	 <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
	 <20040604154142.GF16897@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org>
	 <20040604155138.GG16897@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org>
	 <20040604181304.325000cb.ak@suse.de>
	 <20040608090712.GW4736@devserv.devel.redhat.com>
	 <20040608111453.22cae15a.ak@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f7jpNXGxhQ2doIFB05TH"
Organization: Red Hat UK
Message-Id: <1086686391.2736.29.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Jun 2004 11:19:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f7jpNXGxhQ2doIFB05TH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > When I added PT_GNU_STACK, it was meant from the beginning as
> > stack+heap+mmap w/o PROT_EXEC executability/non-executability.
> > I don't think it makes any sense to have separate bits for heap and sta=
ck.
> > Any program which assumes PROT_READ implies PROT_EXEC just can be marke=
d
> > PT_GNU_STACK PF_X.
>=20
> heap execution seems to be a lot more common than stack execution.

yep but because *BSD and ia64 and .. and .. already require the correct
mprotect/mmap flags for the heap most code has it ok.
(Ok X had broken ifdefs ;)

--=-f7jpNXGxhQ2doIFB05TH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAxYS3xULwo51rQBIRAjNFAJ4ifEQMeuZf2YRtwSJuiRzNnT7SdACfWyvs
xCQLVliDmCd8YfvFiRa9fAk=
=JkXS
-----END PGP SIGNATURE-----

--=-f7jpNXGxhQ2doIFB05TH--

