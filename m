Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWDOWdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWDOWdL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWDOWdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:33:11 -0400
Received: from altrade.nijmegen.internl.net ([217.149.192.18]:49348 "EHLO
	altrade.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id S932087AbWDOWdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:33:10 -0400
From: jos poortvliet <jos@mijnkamer.nl>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: [patch][rfc] quell interactive feeding frenzy
Date: Sun, 16 Apr 2006 00:32:46 +0200
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, Al Boldi <a1426z@gawab.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
References: <200604112100.28725.kernel@kolivas.org> <200604140616.33370.a1426z@gawab.com> <200604151705.18786.kernel@kolivas.org>
In-Reply-To: <200604151705.18786.kernel@kolivas.org>
X-Face: $0>4o"Xx2u2q(Tx!D+6~yPc{ZhEfnQnu:/nthh%Kr%f$aiATk$xjx^X4admsd*)=?utf-8?q?IZz=3A=5FkT=0A=09=7CurITP!=2E?=)L`*)Vw@4\@6>#r;3xSPW`,~C9vb`W/s]}Gq]b!o_/+(lJ:b)=?utf-8?q?T0=26KCLMGvG=7CS=5E=0A=09z=7B=5C=2E7EtehxhFQE=27eYSsir/=7CtQ?=
 =?utf-8?q?j=23rWQe4o?=>WC>_R<vO,d]czmqWYkq[v~iB.e_GuxB'")
 =?utf-8?q?p3=0A=09jGdrhlY4=5E!vd=3F=3AegW?=)xn&fP4!FV<.
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2628709.0SE7c72Mk2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604160032.49845.jos@mijnkamer.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2628709.0SE7c72Mk2
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op zaterdag 15 april 2006 09:05, schreef Con Kolivas:
> Thanks for bringing this to my attention. A while back I had different
> management of forked tasks and merged it with PF_NONSLEEP. Since then I've
> changed the management of NONSLEEP tasks and didn't realise it had
> adversely affected the accounting of forking tasks. This patch should
> rectify it.
>
> Thanks!

hey con, i get this:

can't find file to patch at input line 9
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
=2D-------------------------
|=C2=A0include/linux/sched.h | =C2=A0 =C2=A01 +
|=C2=A0kernel/sched.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 ++++++---
|=C2=A02 files changed, 7 insertions(+), 3 deletions(-)
|
|Index: linux-2.6.16-ck5/include/linux/sched.h
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|--- linux-2.6.16-ck5.orig/include/linux/sched.h=C2=A02006-04-15 16:32:18.0=
00000000=20
+1000
|+++ linux-2.6.16-ck5/include/linux/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A02006-04-15 16:34:36.000000000=20
+1000
=2D-------------------------
=46ile to patch: include/linux/sched.h
patching file include/linux/sched.h
patch: **** malformed patch at line 10: =C2=A0#define=20
PF_SWAPWRITE=C2=A0=C2=A0=C2=A00x01000000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0/* Allowed to write to swap */

doesn't compile if i add the patch by hand... tried on 2.6.17-rc1-ck1 and o=
n=20
2.6.16-ck3.=20

=2D---------------
In file included from include/linux/mm.h:4,
                 from kernel/sched.c:24:
include/linux/sched.h:975:18: warning: missing whitespace after the macro n=
ame
kernel/sched.c: In function =E2=80=98recalc_task_prio=E2=80=99:
kernel/sched.c:820: error: stray =E2=80=98\194=E2=80=99 in program
=2D----------

i'm no coder at all, and have no idea what's goin on.

grtz

Jos

ps 2.6.17-rc2 won't be long i guess, maybe you can just roll this up in -ck=
=2E..

=2D-=20
You will have good luck and overcome many hardships.

--nextPart2628709.0SE7c72Mk2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEQXSR+wgQ1AD35iwRArLOAKDCWqbRt9y/GtHfbGh4xet+Iwa5dwCghpxq
2MP1Y3e/1MEQgUWPwEaSBUI=
=i53G
-----END PGP SIGNATURE-----

--nextPart2628709.0SE7c72Mk2--
