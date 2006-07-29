Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752067AbWG2CFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbWG2CFI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbWG2CFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:05:08 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:52164
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1752067AbWG2CFG (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:05:06 -0400
Message-Id: <200607290204.k6T24kOO003208@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>
Subject: Re: 2.6.18-rc2-mm1
In-Reply-To: Your message of "Fri, 28 Jul 2006 13:39:50 PDT."
             <1154119190.21787.2528.camel@stark>
From: Valdis.Kletnieks@vt.edu
References: <20060727015639.9c89db57.akpm@osdl.org> <6bffcb0e0607270632i2ae56e21k40fb12c712980de0@mail.gmail.com> <6bffcb0e0607280117k68184559t531b737815b2c6e9@mail.gmail.com> <20060728013442.6fabae54.akpm@osdl.org> <1154112567.21787.2522.camel@stark> <6bffcb0e0607281253j28e04ba2icec85589e9390b3e@mail.gmail.com>
            <1154119190.21787.2528.camel@stark>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154138685_2988P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 22:04:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154138685_2988P
Content-Type: text/plain; charset=us-ascii

On Fri, 28 Jul 2006 13:39:50 PDT, Matt Helsley said:
> On Fri, 2006-07-28 at 21:53 +0200, Michal Piotrowski wrote:
> > On 28/07/06, Matt Helsley <matthltc@us.ibm.com> wrote:
> > >         I noticed the delay accounting functions in the stack trace. Perhaps
> > > task-watchers-register-per-task-delay-accounting.patch is causing the
> > > problem.
> > 
> > Confirmed.
> 
> Excellent, thanks for the rapid confirmation. I'll work with Shailabh
> and Balbir to fix this. In the meantime perhaps
> task-watchers-register-per-task-delay-accounting.patch should be dropped
> from -mm.

I finished a bisect on -mm - I ca confirm that this one patch is also
responsible for the solid lockups I was seeing on a Dell C840.  Am now up
and running on -rc2-mm1 with this one reverted.

--==_Exmh_1154138685_2988P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEysI9cC3lWbTT17ARAmLiAKC+8qYBHi6JLTaLFPmz/Ay4JFrunACeLmuu
sEoBPznXdSJu7b92kh9kcrs=
=6LCw
-----END PGP SIGNATURE-----

--==_Exmh_1154138685_2988P--
