Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTFJRa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 13:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTFJRa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 13:30:57 -0400
Received: from rdu26-81-149.nc.rr.com ([66.26.81.149]:1664 "EHLO
	max.bungled.net") by vger.kernel.org with ESMTP id S263737AbTFJRay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 13:30:54 -0400
Date: Tue, 10 Jun 2003 17:44:36 -0400
From: Nathan Conrad <conrad@bungled.net>
To: Oleg Drokin <green@namesys.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 / reiserfs data corruption, 2.5-bk
Message-ID: <20030610214436.GA6719@bungled.net>
References: <20030609193541.GA21106@suse.de> <20030610084323.GA16435@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20030610084323.GA16435@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've been noticing a similar problem on my laptop. This may, or may
not be related, but it did start somewhere within the past week (maybe
the IDE taskfile conversion???, to throw out a guess). I wonder if
Dave Jones is using IDE or SCSI. CONFIG_SMP and CONFIG_PREEMPT are
disabled on my machine (Sony Vaio PCG-FXA49 laptop, Athlon4). I'm
compiling the kernel with gcc 3.3 (Debian version).

Anyway, certain directories get locked up on occasion and when I try
to execute 'ls' or read from the directory, the process gets into a
locked up state; ^C does not work to kill the process. The only way to
make a directory "readable" is to restart the machine. I have not
noticed any FS corruption, just the lack of being able to enter the
directory.

 At the same time, a kernel bug will be displayed:


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c016781a
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[find_inode_fast+26/96]    Not tainted
EFLAGS: 00010286
EIP is at find_inode_fast+0x1a/0x60
eax: db0355c4   ebx: 0001859f   ecx: c3a69844   edx: 00000000
esi: dfd60c00   edi: dff99340   ebp: dff99340   esp: cc6dde50
ds: 007b   es: 007b   ss: 0068
Process emacs20 (pid: 16508, threadinfo=3Dcc6dc000 task=3Dc6d0adc0)
Stack: c4bca5b8 0001859f 0001859f dfd60c00 c0167d2e dfd60c00 dff99340 00018=
59f=20
       0001859f da191d40 dfd60c00 da191d40 c018e45b dfd60c00 0001859f db666=
130=20
       fffffff4 dca22aac dca22a44 c015cd60 dca22a44 da191d40 00000000 cc6dd=
f48=20
Call Trace:
 [iget_locked+78/160] iget_locked+0x4e/0xa0
 [ext3_lookup+107/208] ext3_lookup+0x6b/0xd0
 [real_lookup+192/240] real_lookup+0xc0/0xf0
 [do_lookup+158/176] do_lookup+0x9e/0xb0
 [link_path_walk+1066/2000] link_path_walk+0x42a/0x7d0
 [__user_walk+73/96] __user_walk+0x49/0x60
 [vfs_stat+31/96] vfs_stat+0x1f/0x60
 [sys_stat64+27/64] sys_stat64+0x1b/0x40
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 0f 18 02 90 39 59 18 89 c8 74 0f 85 d2 89 d1 75 ed 31 c0 83=20


On Tue, Jun 10, 2003 at 12:43:23PM +0400, Oleg Drokin wrote:
> Hello!
>=20
> On Mon, Jun 09, 2003 at 08:35:55PM +0100, Dave Jones wrote:
>=20
> > 2.5 Bitkeeper tree as of last 24 hrs. Running a lot
> > of disk IO stress (multiple fsstress, over 100 fsx instances,
> > and random sync calling) produced failures on both reiserfs
> > and ext3.
> > Tests were done on seperate disks, but concurrently.
>=20
> Do you have smp or preempt enabled?
>=20
> Bye,
>     Oleg

-Nathan Conrad

--=20
Nathan J. Conrad
GPG: F4FC 7E25 9308 ECE1 735C  0798 CE86 DA45 9170 3112
--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+5lFEzobaRZFwMRIRAiKLAKCE3RT51QweOi366sdqkdLaWijp5QCdF7ba
0UCW3GMzdq/O7OvWlxXkXkU=
=UhLT
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
