Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVDGRBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVDGRBK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVDGRBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:01:10 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:23058 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S262528AbVDGRAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:00:51 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm1 - printk timing broken
Date: Thu, 7 Apr 2005 19:00:32 +0200
User-Agent: KMail/1.8
References: <20050405000524.592fc125.akpm@osdl.org> <425240C5.1050706@ens-lyon.org> <20050405004519.4be75785.akpm@osdl.org>
In-Reply-To: <20050405004519.4be75785.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart25886153.ApXMgv8byG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504071900.36224.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart25886153.ApXMgv8byG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andrew,

Le Tuesday 05 April 2005 09:45, Andrew Morton a =E9crit=A0:
> Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> > Andrew Morton a =E9crit :
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.
> >  >12-rc2/2.6.12-rc2-mm1/
> >
> >  Hi Andrew,
> >
> >  printk timing seems broken.
> >  It always shows [ 0.000000] on my Compaq Evo N600c.
>
> What sort of CPU does that thing have?  Please share the /proc/cpuinfo
> output.

i can reproduce this "[ 0.000000]"-bug with a Thinkpad A31p with a P4M:

cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz
stepping        : 7
cpu MHz         : 1998.447
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov=
=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid

> Does reverting
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc
>2/2.6.12-rc2-mm1/broken-out/sched-x86-sched_clock-to-use-tsc-on-config_h
>pet-or-config_numa-systems.patch fix it?

for me too - yes

strange, because the cpu supports tsc as the flags indicate in the cpuinfo=
=20
i posted. hopefully this mystery is no more, soon ;-)

best regards,
Damir

=2D-=20
Don't confuse things that need action with those that take care of=20
themselves.

--nextPart25886153.ApXMgv8byG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCVWczPABWKV6NProRAlpTAKDXKLjh43UpDI7XL/7dgTvXqDMICACgwgN0
Yz+mtocqxi80IT60UxVdzdc=
=nYMU
-----END PGP SIGNATURE-----

--nextPart25886153.ApXMgv8byG--
