Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVCCPUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVCCPUj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 10:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVCCPUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 10:20:38 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:61584 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261211AbVCCPU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 10:20:26 -0500
Date: Thu, 3 Mar 2005 16:20:21 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: sounak chakraborty <sounakrin@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: architecture to implement communication between static kernel
 with dynamic module
Message-ID: <20050303162021.1839dad4@phoebee>
In-Reply-To: <20050303150901.71989.qmail@web53301.mail.yahoo.com>
References: <20050303150901.71989.qmail@web53301.mail.yahoo.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Thu__3_Mar_2005_16_20_21_+0100_h.RdMgq+/08ZB63f";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Thu__3_Mar_2005_16_20_21_+0100_h.RdMgq+/08ZB63f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Mar 2005 15:09:01 +0000 (GMT)
sounak chakraborty <sounakrin@yahoo.co.in> bubbled:

> there is one my_own module
> which i will insert whenever i like through=20
> insmod.
> thus when the module is loaded it will create a proc
> file=20
>=20
> now i want to send the structure variable of
> task_struct
> i.e p to the module from the kernel at point when the
> execution passes
> through forking a new process i.e=20
> at the function do_fork() in fork.c in linux/kernel
> folder
>=20
> how to do this
>=20
> how can i call the module from that point  (i.e in
> do_fork())
> and pass the task_struct *p as parameter to the module
>=20
> can i declare an arbitary name in fork.c of my module
> and compile the new kernel?
> i think i cannot since i am inserting a dynamic module
> to a static kernel executable
> and how does the kernel will know that this module
> will be attached later to it.
> it will show errors while compiling the new modified
> kernel
>=20
> can you help me ?
> what path i must take
> thanks=20
> sounak=20
>=20

Some kind of callback registration would do the job.

Regards,
Martin

--=20
MyExcuse:
Cow-tippers tipped a cow onto the server.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Thu__3_Mar_2005_16_20_21_+0100_h.RdMgq+/08ZB63f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCJys1mjLYGS7fcG0RAtcQAJ43V5253k1ZwtX0XmcOZPHg4u8zhwCbBNGi
rwWO37JR0CIaifA7lgUxaC0=
=cnJL
-----END PGP SIGNATURE-----

--Signature_Thu__3_Mar_2005_16_20_21_+0100_h.RdMgq+/08ZB63f--
