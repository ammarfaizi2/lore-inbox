Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWAWJW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWAWJW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 04:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWAWJW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 04:22:59 -0500
Received: from mail.21torr.com ([213.143.192.7]:16388 "EHLO mail.21torr.com")
	by vger.kernel.org with ESMTP id S932115AbWAWJW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 04:22:58 -0500
Date: Mon, 23 Jan 2006 10:28:05 +0100
From: Florian Engelhardt <f.engelhardt@21torr.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel assertion in net/ipv4/tcp.c
Message-ID: <20060123102805.6bd39bcc@HAL2000>
Organization: 21TORR AGENCY
X-Mailer: Sylpheed-Claws 2.0.0-rc3 (GTK+ 2.8.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_GihChYMF22CzJ+XBMzi.vQv
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_GihChYMF22CzJ+XBMzi.vQv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

i have a linux system running:
Linux www 2.6.14-gentoo-r2 #4 SMP Mon Nov 28 10:35:23 CET 2005 i686
Intel(R) Xeon(TM) CPU 3.20GHz GenuineIntel GNU/Linux

I have a Marvell Yukon Ethernet card inside.

And i have some trouble with it (see the attached log file).
I get tons of error messages in my kern.log, all the same:
Jan 15 11:11:20 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed
at net/ipv4/tcp.c (1171)

Then, after some hours, the error message changes to something like
this:
Jan 15 17:58:44 www kernel: KERNEL: assertion
(flags & MSG_PEEK) fa->rcviled at net/ipv4/tcp.->rcv_nxt || (iled at
net/ipv4/tc->rcv_nxt iled at net/ipv4/tcp.c ->rcv_nxt || (flile
d at net/ipv4/tcp->rcv_nxt || (fliled at net/ipv4/t->rcv_nxt || (fliled
at net/ipv4/tc->rcv_nxt |iled at net/ipv4/tcp->rcv_nxt ||iled at
net/ipv4/tcp.c ->rcv_nxt ||iled at net/ip
v4/tcp.c (->rcv_nxtiled at net/ipv4/tcp->rcv_nxt || (fliled at
net/ipv4/tcp->rcv_nxt |iled at net/ipv4/tcp.c ->rcv_nxiled at 
net/ipv4/tcp.c->rcv_nxt ||iled at net/ipv4/tcp.c->rcv
_nxt || (iled at net/ipv4/tcp.c (->rcv_nxt || iled at
net/ipv4/tcp.c->rcv_nxt || (filed at net/ipv4/tcp.c (->rcv_nxt || iled
at net/ipv4/tcp.c ->rcv_nxt || iled at net/ipv4/tc->r
cv_nxt ||iled at net/ipv4/tcp->rcv_nxt || (filed at
net/ipv4/tcp->rcv_nxt || iled at net/ipv4/tcp.->rcv_nxt || iled at
net/ipv4/tcp.c ->rcv_nxt || (filed at net/ipv4/tcp.->rcv_nx
t || iled at net/ipv4/tcp.c (->rcv_nxt || (fliled at
net/ipv4/tcp.->rcv_nxt || iled at net/ipv4/tcp.c (->rcv_nxt ||iled at
net/ipv4/t

and then, after some days i have this gibberish:
Jan 22 15:42:20 www kernel: KERNEL: ->rcv_niilediiled at net/ipv4iililed
iled ailililed ailed at neililedilililed atiled at nililediililed at
netiled iiiililed at niled at niledi
lilililed atililed at netiled at iledililililed atiliiiliiiled at niiled
iililed at iled at iiled at niiliiiiiliiilileiliiled at iililed iled
iled at neiled aiiled at net/iled ai
led at ilediled ailedililed at niled aileililed at iled at niled at
neiled at net/iled aililed ailed atiliililed atiledililiiled at
net/iiiled at niled aiiililiiledililiiledilili
lilililed iliiileililiiiled ailed atililililed at netiled
ile->ilililililed at net/iilediiiled atiled at netiiled at
netiilileiiled at net/ipv4ililed atiled ililiiled aiilililed
ailed at net/->rcv_nxtileiled->rcv_nxt(123->r--->->rcv--->rc-->rcv_nxt
|(1235)iliiiled at niiiled at net/ii->iliililed at neiiliililed at
net/iiiiled iled ilililed iiiiled aiilii
ililiiliiliileilililiiililiiiled at ilililed at ->-iiled atiled at
neilililiiliilililed at niliiledilediiled at net/ipiled at net/iil

See the log file attached. I also attached the kernels .config file.

Kind Regards

Florian Engelhardt

PS: please CC me, couse i am not on the list.
--MP_GihChYMF22CzJ+XBMzi.vQv
Content-Type: text/plain; name=log.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=log.txt

Linux www 2.6.14-gentoo-r2 #4 SMP Mon Nov 28 10:35:23 CET 2005 i686 Intel(R)
Xeon(TM) CPU 3.20GHz GenuineIntel GNU/Linux



Jan 15 11:11:20 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:20 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:20 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:20 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:20 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:20 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:20 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:20 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:20 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:20 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:20 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:21 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:21 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:25 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:25 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:25 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:25 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:25 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:25 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:25 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:25 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:25 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:25 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:25 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 11:11:25 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 11:11:25 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) fa->rcviled
at net/ipv4/tcp.->rcv_nxt || (iled at net/ipv4/tc->rcv_nxt iled at
net/ipv4/tcp.c ->rcv_nxt || (flile
d at net/ipv4/tcp->rcv_nxt || (fliled at net/ipv4/t->rcv_nxt || (fliled at
net/ipv4/tc->rcv_nxt |iled at net/ipv4/tcp->rcv_nxt ||iled at net/ipv4/tcp.c
->rcv_nxt ||iled at net/ip
v4/tcp.c (->rcv_nxtiled at net/ipv4/tcp->rcv_nxt || (fliled at
net/ipv4/tcp->rcv_nxt |iled at net/ipv4/tcp.c ->rcv_nxiled at
net/ipv4/tcp.c->rcv_nxt ||iled at net/ipv4/tcp.c->rcv
_nxt || (iled at net/ipv4/tcp.c (->rcv_nxt || iled at
net/ipv4/tcp.c->rcv_nxt || (filed at net/ipv4/tcp.c (->rcv_nxt || iled at
net/ipv4/tcp.c ->rcv_nxt || iled at net/ipv4/tc->r
cv_nxt ||iled at net/ipv4/tcp->rcv_nxt || (filed at net/ipv4/tcp->rcv_nxt ||
iled at net/ipv4/tcp.->rcv_nxt || iled at net/ipv4/tcp.c ->rcv_nxt || (filed
at net/ipv4/tcp.->rcv_nx
t || iled at net/ipv4/tcp.c (->rcv_nxt || (fliled at net/ipv4/tcp.->rcv_nxt
|| iled at net/ipv4/tcp.c (->rcv_nxt ||iled at net/ipv4/t
Jan 15 17:58:44 www kernel: p->rcv_nxt ||iled at net/ipv4/tcp->rcv_nxt ||
iled at net/ipv4/tcp.c (->rcv_nxt || (fliled at net/ipv4/tc->rcv_nxt |iled
at net/ipv4/tcp.c ->rcv_nxt i
led at net/ipv4/tcp.c (1->rcv_nxt ||iled at net/ipv4/tcp->rcv_nxt || (iled
at net/ipv4/tcp.c (->rcv_nxt ||iled at net/ipv4/tcp.c (->rcv_nxt iled at
net/ipv4/tcp.->rcv_nxtiled at
net/ipv4/tcp->rcv_niled at net/ipv4/tcp.c->rcv_nxiled at net/ipv4/tcp.c
->rcv_nxt || (iled at net/ipv4/t->rcv_nxt ||iled at net/ipv4/->rcv_nxt iled
at net/ipv4/tc->rcv_niled at n
et/ipv4/tcp.->rcv_nxtiled at net/ipv4/tcp->rcv_nxt iled at
net/ipv4/tcp->rcv_nxt iled at net/ipv4/tcp->rcv_nxiled at
net/ipv4/tcp->rcv_nxt || (flailed at net/ipv4/tcp->rcv_nxt il
ed at net/ipv4/tcp->rcv_nxt iled at net/ipv4/tcp->rcv_nxt |iled at
net/ipv4/tcp->rcv_nxt |iled at net/ipv4/tcp.c (1171)
Jan 15 17:58:44 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 15 17:58:44 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)






and then, after a while i have this...






Jan 22 15:42:20 www kernel: KERNEL: assertion (tp->copied_seq =3D=3D tp->rc=
v_nxt
|| (flags & (MSG_PEEK | MSG_TRUNC))) failed at net/ipv4/tcp.c (1235)
Jan 22 15:42:20 www kernel: KERNEL: assertion (flags & MSG_PEEK) failed at
net/ipv4/tcp.c (1171)
Jan 22 15:42:20 www kernel: KERNEL: assertion (tp->ciled at nililed aiiled
at niled at nililed ailiiiiliilileililed at iled ilediled at(1iii->rciled at
net/iilililed atiled at il
ed at niled at(1235)
Jan 22 15:42:20 www kernel: iled aililileiled ailiilililedililediled iled
ililed atiled at neiliililed at niilediledilediiiled atiled ailililililed at
netiled at (1235-iled at ne
t/ililediled at net/ipv4/iled atililileilililed at
net/ipv4/tc->rcv_niililediled->r->->rcv_nx->->-->->rcv_nxt ||
(fla->->rcv_n->->->->->->rcv_n->rcv_n-->->->->->->rcv->->rcv->->-
>->-->->->->-->rcv_nxt ->->rcv_nxt ||
->->->->->rcv_n->->rcv_nxt->->rcv_n->rcv_nxt |->->->->->rcv_n(1235)
Jan 22 15:42:20 www kernel: iled -iled aiili-iled at net/ipv4/iled at
neilililed atiled at neililed atiled ililililiiled at iliilililed
a->->->->->-->rcv-->rcv->->-(123ilileiled
ailediled at il->rcv_niililililed at net/ipv4/iled aiililiiliiliililed
atililed at ilililililililedililed ileiled at netiled at neiled
atilileililedililed at niled at net/ipv4/tc
p.ciled at net/iled at iled at ilediled ->riiiilililed atilileileiiiled at
net/ipv4iled at net/ililed at iled a->->rcv_->r(123ilileiliilililed at
netililed aililiiililililililiil
iliiliilililililediilediiled at net/ipv4/tc->rcv_nxt iiled at ilediliiled
atiililiiled ileililed at nileiililed ailiiled at neililililed
ailililediilediled at net/ipv->->-->->->-
>->->->rcv-->iled at->rcv_n->rcv_nxt |-iled atiiiled atiled atililedililed
at net/iiled at net/ipiled atiii-->rcv_n->--->rc->--->rc-->->rcv_nxt
|(12->rcv_n-->rcv_->-->rcv_->rcv_n
xt || (fl--->rc->->->(12->->r->r-->rcv_nxt ||->->->r--->rc->rcv_->rcv_nxt
||->rcv_-->rcv_n->rcv_->->->->->->-->->->--->->->-->->(123i
Jan 22 15:42:20 www kernel: lililililiiiiled atiilililediiiled at niled iled
at net/ipv4iilililililiiliil->rcviled at->ililed at net/i->rcv_nxiiiiled at
netililedililediileiiled
at neiiiiliililediilililileiledilililed at neiiiliiiled at net/ipv4/tcililed
at neilileiled at net/ipiililed iliiled at net/ipv4/iled atiiiliililed at
net/ipv4/iiliililiiled at n
ililed at niliililed at net/iiiliiilililileililiiililediiiled aileiled
atililed ailed aiiiled at->rcv_nxt ||ililed ailed atiled at iled at net-iled
atililed at net/iled at niled
-ililed atiled aiileiledililediiililed at nililed at net/iliiled at ililed
at net/ipv4/tcp.c (ililiilediled at ili-iliiiled at ne->->rcv_(ilililed at
nililiiliiiled at net/iiledi
iled at iledililed atiled at neiliileililililed ailed at net/ipv4/tcp.c
(11->rcviled atiled i-->rcv_-->->->rcv_nxt ->-->rcv_nx-->rcv_nxt ||
(fla-->->rcv_nxt |->->rc->rcv_n->rc->-
>->---->rc-->->r-->->->->->rcv_n->->---->rc->->->-->rcv_n->---->r->->rcv_n-=
>rcv_nxt
|| (->rcv_->rcv_nx->rcv_nx->rc->rcv_n->---->rcv->
Jan 22 15:42:20 www kernel: nx->->--->--->rc->rc->r->r->->r->rcv_nxt ||
(f->rcv_iiled atileiledililili->rcv_nxt->->iil->->(123-ililediled at
ne->rcv_n(1235)
Jan 22 15:42:20 www kernel: KERNEL: ->rcv_niilediiled at net/ipv4iililed
iled ailililed ailed at neililedilililed atiled at nililediililed at netiled
iiiililed at niled at niledi
lilililed atililed at netiled at iledililililed atiliiiliiiled at niiled
iililed at iled at iiled at niiliiiiiliiilileiliiled at iililed iled iled at
neiled aiiled at net/iled ai
led at ilediled ailedililed at niled aileililed at iled at niled at neiled
at net/iled aililed ailed atiliililed atiledililiiled at net/iiiled at niled
aiiililiiledililiiledilili
lilililed iliiileililiiiled ailed atililililed at netiled ile->ilililililed
at net/iilediiiled atiled at netiiled at netiilileiiled at net/ipv4ililed
atiled ililiiled aiilililed
ailed at net/->rcv_nxtileiled->rcv_nxt(123->r--->->rcv--->rc-->rcv_nxt
|(1235)iliiiled at niiiled at net/ii->iliililed at neiiliililed at
net/iiiiled iled ilililed iiiiled aiilii
ililiiliiliileilililiiililiiiled at ilililed at ->-iiled atiled at
neilililiiliilililed at niliiledilediiled at net/ipiled at net/iil





after this log message, the systen wasn=C2=B4t reacting anymore to ssh, htt=
p,
mysql, ... i had to reset the system.



--MP_GihChYMF22CzJ+XBMzi.vQv
Content-Type: application/octet-stream; name=kernel.config
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=kernel.config

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4xNC1nZW50b28tcjIKIyBNb24gTm92IDI4IDEwOjI5OjI3
IDIwMDUKIwpDT05GSUdfWDg2PXkKQ09ORklHX1NFTUFQSE9SRV9TTEVFUEVSUz15CkNPTkZJR19N
TVU9eQpDT05GSUdfVUlEMTY9eQpDT05GSUdfR0VORVJJQ19JU0FfRE1BPXkKQ09ORklHX0dFTkVS
SUNfSU9NQVA9eQpDT05GSUdfQVJDSF9NQVlfSEFWRV9QQ19GREM9eQoKIwojIENvZGUgbWF0dXJp
dHkgbGV2ZWwgb3B0aW9ucwojCkNPTkZJR19FWFBFUklNRU5UQUw9eQpDT05GSUdfQ0xFQU5fQ09N
UElMRT15CkNPTkZJR19MT0NLX0tFUk5FTD15CkNPTkZJR19JTklUX0VOVl9BUkdfTElNSVQ9MzIK
CiMKIyBHZW5lcmFsIHNldHVwCiMKQ09ORklHX0xPQ0FMVkVSU0lPTj0iIgpDT05GSUdfTE9DQUxW
RVJTSU9OX0FVVE89eQpDT05GSUdfU1dBUD15CkNPTkZJR19TWVNWSVBDPXkKQ09ORklHX1BPU0lY
X01RVUVVRT15CiMgQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1QgaXMgbm90IHNldApDT05GSUdfU1lT
Q1RMPXkKQ09ORklHX0FVRElUPXkKQ09ORklHX0FVRElUU1lTQ0FMTD15CkNPTkZJR19IT1RQTFVH
PXkKQ09ORklHX0tPQkpFQ1RfVUVWRU5UPXkKQ09ORklHX0lLQ09ORklHPXkKIyBDT05GSUdfSUtD
T05GSUdfUFJPQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVVNFVFMgaXMgbm90IHNldApDT05GSUdf
SU5JVFJBTUZTX1NPVVJDRT0iIgojIENPTkZJR19FTUJFRERFRCBpcyBub3Qgc2V0CkNPTkZJR19L
QUxMU1lNUz15CiMgQ09ORklHX0tBTExTWU1TX0VYVFJBX1BBU1MgaXMgbm90IHNldApDT05GSUdf
UFJJTlRLPXkKQ09ORklHX0JVRz15CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05GSUdfRlVURVg9eQpD
T05GSUdfRVBPTEw9eQpDT05GSUdfU0hNRU09eQpDT05GSUdfQ0NfQUxJR05fRlVOQ1RJT05TPTAK
Q09ORklHX0NDX0FMSUdOX0xBQkVMUz0wCkNPTkZJR19DQ19BTElHTl9MT09QUz0wCkNPTkZJR19D
Q19BTElHTl9KVU1QUz0wCiMgQ09ORklHX1RJTllfU0hNRU0gaXMgbm90IHNldApDT05GSUdfQkFT
RV9TTUFMTD0wCgojCiMgTG9hZGFibGUgbW9kdWxlIHN1cHBvcnQKIwpDT05GSUdfTU9EVUxFUz15
CkNPTkZJR19NT0RVTEVfVU5MT0FEPXkKIyBDT05GSUdfTU9EVUxFX0ZPUkNFX1VOTE9BRCBpcyBu
b3Qgc2V0CkNPTkZJR19PQlNPTEVURV9NT0RQQVJNPXkKIyBDT05GSUdfTU9EVkVSU0lPTlMgaXMg
bm90IHNldAojIENPTkZJR19NT0RVTEVfU1JDVkVSU0lPTl9BTEwgaXMgbm90IHNldApDT05GSUdf
S01PRD15CkNPTkZJR19TVE9QX01BQ0hJTkU9eQoKIwojIFByb2Nlc3NvciB0eXBlIGFuZCBmZWF0
dXJlcwojCkNPTkZJR19YODZfUEM9eQojIENPTkZJR19YODZfRUxBTiBpcyBub3Qgc2V0CiMgQ09O
RklHX1g4Nl9WT1lBR0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X05VTUFRIGlzIG5vdCBzZXQK
IyBDT05GSUdfWDg2X1NVTU1JVCBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9CSUdTTVAgaXMgbm90
IHNldAojIENPTkZJR19YODZfVklTV1MgaXMgbm90IHNldAojIENPTkZJR19YODZfR0VORVJJQ0FS
Q0ggaXMgbm90IHNldAojIENPTkZJR19YODZfRVM3MDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTTM4
NiBpcyBub3Qgc2V0CiMgQ09ORklHX000ODYgaXMgbm90IHNldAojIENPTkZJR19NNTg2IGlzIG5v
dCBzZXQKIyBDT05GSUdfTTU4NlRTQyBpcyBub3Qgc2V0CiMgQ09ORklHX001ODZNTVggaXMgbm90
IHNldAojIENPTkZJR19NNjg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTVBFTlRJVU1JSSBpcyBub3Qg
c2V0CiMgQ09ORklHX01QRU5USVVNSUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBFTlRJVU1NIGlz
IG5vdCBzZXQKQ09ORklHX01QRU5USVVNND15CiMgQ09ORklHX01LNiBpcyBub3Qgc2V0CiMgQ09O
RklHX01LNyBpcyBub3Qgc2V0CiMgQ09ORklHX01LOCBpcyBub3Qgc2V0CiMgQ09ORklHX01DUlVT
T0UgaXMgbm90IHNldAojIENPTkZJR19NRUZGSUNFT04gaXMgbm90IHNldAojIENPTkZJR19NV0lO
Q0hJUEM2IGlzIG5vdCBzZXQKIyBDT05GSUdfTVdJTkNISVAyIGlzIG5vdCBzZXQKIyBDT05GSUdf
TVdJTkNISVAzRCBpcyBub3Qgc2V0CiMgQ09ORklHX01HRU9ERUdYMSBpcyBub3Qgc2V0CiMgQ09O
RklHX01DWVJJWElJSSBpcyBub3Qgc2V0CiMgQ09ORklHX01WSUFDM18yIGlzIG5vdCBzZXQKIyBD
T05GSUdfWDg2X0dFTkVSSUMgaXMgbm90IHNldApDT05GSUdfWDg2X0NNUFhDSEc9eQpDT05GSUdf
WDg2X1hBREQ9eQpDT05GSUdfWDg2X0wxX0NBQ0hFX1NISUZUPTcKQ09ORklHX1JXU0VNX1hDSEdB
RERfQUxHT1JJVEhNPXkKQ09ORklHX0dFTkVSSUNfQ0FMSUJSQVRFX0RFTEFZPXkKQ09ORklHX1g4
Nl9XUF9XT1JLU19PSz15CkNPTkZJR19YODZfSU5WTFBHPXkKQ09ORklHX1g4Nl9CU1dBUD15CkNP
TkZJR19YODZfUE9QQURfT0s9eQpDT05GSUdfWDg2X0dPT0RfQVBJQz15CkNPTkZJR19YODZfSU5U
RUxfVVNFUkNPUFk9eQpDT05GSUdfWDg2X1VTRV9QUFJPX0NIRUNLU1VNPXkKIyBDT05GSUdfSFBF
VF9USU1FUiBpcyBub3Qgc2V0CkNPTkZJR19TTVA9eQpDT05GSUdfTlJfQ1BVUz00CkNPTkZJR19T
Q0hFRF9TTVQ9eQpDT05GSUdfUFJFRU1QVF9OT05FPXkKIyBDT05GSUdfUFJFRU1QVF9WT0xVTlRB
UlkgaXMgbm90IHNldAojIENPTkZJR19QUkVFTVBUIGlzIG5vdCBzZXQKQ09ORklHX1BSRUVNUFRf
QktMPXkKQ09ORklHX1g4Nl9MT0NBTF9BUElDPXkKQ09ORklHX1g4Nl9JT19BUElDPXkKQ09ORklH
X1g4Nl9UU0M9eQpDT05GSUdfWDg2X01DRT15CkNPTkZJR19YODZfTUNFX05PTkZBVEFMPXkKQ09O
RklHX1g4Nl9NQ0VfUDRUSEVSTUFMPXkKIyBDT05GSUdfVE9TSElCQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0k4SyBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9SRUJPT1RGSVhVUFMgaXMgbm90IHNldAoj
IENPTkZJR19NSUNST0NPREUgaXMgbm90IHNldAojIENPTkZJR19YODZfTVNSIGlzIG5vdCBzZXQK
IyBDT05GSUdfWDg2X0NQVUlEIGlzIG5vdCBzZXQKCiMKIyBGaXJtd2FyZSBEcml2ZXJzCiMKIyBD
T05GSUdfRUREIGlzIG5vdCBzZXQKIyBDT05GSUdfREVMTF9SQlUgaXMgbm90IHNldApDT05GSUdf
RENEQkFTPW0KIyBDT05GSUdfTk9ISUdITUVNIGlzIG5vdCBzZXQKQ09ORklHX0hJR0hNRU00Rz15
CiMgQ09ORklHX0hJR0hNRU02NEcgaXMgbm90IHNldApDT05GSUdfSElHSE1FTT15CkNPTkZJR19T
RUxFQ1RfTUVNT1JZX01PREVMPXkKQ09ORklHX0ZMQVRNRU1fTUFOVUFMPXkKIyBDT05GSUdfRElT
Q09OVElHTUVNX01BTlVBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NQQVJTRU1FTV9NQU5VQUwgaXMg
bm90IHNldApDT05GSUdfRkxBVE1FTT15CkNPTkZJR19GTEFUX05PREVfTUVNX01BUD15CiMgQ09O
RklHX1NQQVJTRU1FTV9TVEFUSUMgaXMgbm90IHNldAojIENPTkZJR19ISUdIUFRFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUFUSF9FTVVMQVRJT04gaXMgbm90IHNldApDT05GSUdfTVRSUj15CiMgQ09O
RklHX0VGSSBpcyBub3Qgc2V0CkNPTkZJR19JUlFCQUxBTkNFPXkKIyBDT05GSUdfUkVHUEFSTSBp
cyBub3Qgc2V0CkNPTkZJR19TRUNDT01QPXkKIyBDT05GSUdfSFpfMTAwIGlzIG5vdCBzZXQKQ09O
RklHX0haXzI1MD15CiMgQ09ORklHX0haXzEwMDAgaXMgbm90IHNldApDT05GSUdfSFo9MjUwCkNP
TkZJR19QSFlTSUNBTF9TVEFSVD0weDEwMDAwMAojIENPTkZJR19LRVhFQyBpcyBub3Qgc2V0Cgoj
CiMgUG93ZXIgbWFuYWdlbWVudCBvcHRpb25zIChBQ1BJLCBBUE0pCiMKQ09ORklHX1BNPXkKIyBD
T05GSUdfUE1fREVCVUcgaXMgbm90IHNldAoKIwojIEFDUEkgKEFkdmFuY2VkIENvbmZpZ3VyYXRp
b24gYW5kIFBvd2VyIEludGVyZmFjZSkgU3VwcG9ydAojCkNPTkZJR19BQ1BJPXkKQ09ORklHX0FD
UElfQUM9eQpDT05GSUdfQUNQSV9CQVRURVJZPXkKQ09ORklHX0FDUElfQlVUVE9OPXkKQ09ORklH
X0FDUElfVklERU89eQojIENPTkZJR19BQ1BJX0hPVEtFWSBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJ
X0ZBTj15CkNPTkZJR19BQ1BJX1BST0NFU1NPUj15CkNPTkZJR19BQ1BJX1RIRVJNQUw9eQojIENP
TkZJR19BQ1BJX0FTVVMgaXMgbm90IHNldApDT05GSUdfQUNQSV9JQk09eQojIENPTkZJR19BQ1BJ
X1RPU0hJQkEgaXMgbm90IHNldApDT05GSUdfQUNQSV9CTEFDS0xJU1RfWUVBUj0wCiMgQ09ORklH
X0FDUElfREVCVUcgaXMgbm90IHNldApDT05GSUdfQUNQSV9FQz15CkNPTkZJR19BQ1BJX1BPV0VS
PXkKQ09ORklHX0FDUElfU1lTVEVNPXkKIyBDT05GSUdfWDg2X1BNX1RJTUVSIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUNQSV9DT05UQUlORVIgaXMgbm90IHNldAoKIwojIEFQTSAoQWR2YW5jZWQgUG93
ZXIgTWFuYWdlbWVudCkgQklPUyBTdXBwb3J0CiMKIyBDT05GSUdfQVBNIGlzIG5vdCBzZXQKCiMK
IyBDUFUgRnJlcXVlbmN5IHNjYWxpbmcKIwojIENPTkZJR19DUFVfRlJFUSBpcyBub3Qgc2V0Cgoj
CiMgQnVzIG9wdGlvbnMgKFBDSSwgUENNQ0lBLCBFSVNBLCBNQ0EsIElTQSkKIwpDT05GSUdfUENJ
PXkKIyBDT05GSUdfUENJX0dPQklPUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9HT01NQ09ORklH
IGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX0dPRElSRUNUIGlzIG5vdCBzZXQKQ09ORklHX1BDSV9H
T0FOWT15CkNPTkZJR19QQ0lfQklPUz15CkNPTkZJR19QQ0lfRElSRUNUPXkKQ09ORklHX1BDSV9N
TUNPTkZJRz15CkNPTkZJR19QQ0lFUE9SVEJVUz15CiMgQ09ORklHX1BDSV9NU0kgaXMgbm90IHNl
dApDT05GSUdfUENJX0xFR0FDWV9QUk9DPXkKQ09ORklHX0lTQV9ETUFfQVBJPXkKIyBDT05GSUdf
SVNBIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0N4MjAwIGlz
IG5vdCBzZXQKIyBDT05GSUdfSE9UUExVR19DUFUgaXMgbm90IHNldAoKIwojIFBDQ0FSRCAoUENN
Q0lBL0NhcmRCdXMpIHN1cHBvcnQKIwojIENPTkZJR19QQ0NBUkQgaXMgbm90IHNldAoKIwojIFBD
SSBIb3RwbHVnIFN1cHBvcnQKIwojIENPTkZJR19IT1RQTFVHX1BDSSBpcyBub3Qgc2V0CgojCiMg
RXhlY3V0YWJsZSBmaWxlIGZvcm1hdHMKIwpDT05GSUdfQklORk1UX0VMRj15CkNPTkZJR19CSU5G
TVRfQU9VVD15CkNPTkZJR19CSU5GTVRfTUlTQz15CgojCiMgTmV0d29ya2luZwojCkNPTkZJR19O
RVQ9eQoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCkNPTkZJR19QQUNLRVQ9eQojIENPTkZJR19Q
QUNLRVRfTU1BUCBpcyBub3Qgc2V0CkNPTkZJR19VTklYPXkKIyBDT05GSUdfTkVUX0tFWSBpcyBu
b3Qgc2V0CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CiMgQ09ORklHX0lQX0FE
VkFOQ0VEX1JPVVRFUiBpcyBub3Qgc2V0CkNPTkZJR19JUF9GSUJfSEFTSD15CiMgQ09ORklHX0lQ
X1BOUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUElQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X0lQR1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTVJPVVRFIGlzIG5vdCBzZXQKIyBDT05GSUdf
QVJQRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NZTl9DT09LSUVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5FVF9BSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfRVNQIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5FVF9JUENPTVAgaXMgbm90IHNldAojIENPTkZJR19JTkVUX1RVTk5FTCBpcyBub3Qgc2V0CkNP
TkZJR19JTkVUX0RJQUc9eQpDT05GSUdfSU5FVF9UQ1BfRElBRz15CiMgQ09ORklHX1RDUF9DT05H
X0FEVkFOQ0VEIGlzIG5vdCBzZXQKQ09ORklHX1RDUF9DT05HX0JJQz15CgojCiMgSVA6IFZpcnR1
YWwgU2VydmVyIENvbmZpZ3VyYXRpb24KIwojIENPTkZJR19JUF9WUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0lQVjYgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSPXkKIyBDT05GSUdfTkVURklMVEVS
X0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX05FVExJTksgaXMgbm90IHNldAoK
IwojIElQOiBOZXRmaWx0ZXIgQ29uZmlndXJhdGlvbgojCkNPTkZJR19JUF9ORl9DT05OVFJBQ0s9
eQojIENPTkZJR19JUF9ORl9DVF9BQ0NUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTkZfQ09OTlRS
QUNLX01BUksgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9DT05OVFJBQ0tfRVZFTlRTIGlzIG5v
dCBzZXQKIyBDT05GSUdfSVBfTkZfQ1RfUFJPVE9fU0NUUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQ
X05GX0ZUUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX0lSQyBpcyBub3Qgc2V0CiMgQ09ORklH
X0lQX05GX05FVEJJT1NfTlMgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9URlRQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBfTkZfQU1BTkRBIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTkZfUFBUUCBp
cyBub3Qgc2V0CkNPTkZJR19JUF9ORl9RVUVVRT15CkNPTkZJR19JUF9ORl9JUFRBQkxFUz15CkNP
TkZJR19JUF9ORl9NQVRDSF9MSU1JVD15CkNPTkZJR19JUF9ORl9NQVRDSF9JUFJBTkdFPXkKQ09O
RklHX0lQX05GX01BVENIX01BQz15CkNPTkZJR19JUF9ORl9NQVRDSF9QS1RUWVBFPXkKQ09ORklH
X0lQX05GX01BVENIX01BUks9eQpDT05GSUdfSVBfTkZfTUFUQ0hfTVVMVElQT1JUPXkKQ09ORklH
X0lQX05GX01BVENIX1RPUz15CkNPTkZJR19JUF9ORl9NQVRDSF9SRUNFTlQ9eQpDT05GSUdfSVBf
TkZfTUFUQ0hfRUNOPXkKQ09ORklHX0lQX05GX01BVENIX0RTQ1A9eQpDT05GSUdfSVBfTkZfTUFU
Q0hfQUhfRVNQPXkKQ09ORklHX0lQX05GX01BVENIX0xFTkdUSD15CkNPTkZJR19JUF9ORl9NQVRD
SF9UVEw9eQpDT05GSUdfSVBfTkZfTUFUQ0hfVENQTVNTPXkKQ09ORklHX0lQX05GX01BVENIX0hF
TFBFUj15CkNPTkZJR19JUF9ORl9NQVRDSF9TVEFURT15CkNPTkZJR19JUF9ORl9NQVRDSF9DT05O
VFJBQ0s9eQpDT05GSUdfSVBfTkZfTUFUQ0hfT1dORVI9eQojIENPTkZJR19JUF9ORl9NQVRDSF9B
RERSVFlQRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENIX1JFQUxNIGlzIG5vdCBzZXQK
IyBDT05GSUdfSVBfTkZfTUFUQ0hfU0NUUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENI
X0RDQ1AgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9NQVRDSF9DT01NRU5UIGlzIG5vdCBzZXQK
IyBDT05GSUdfSVBfTkZfTUFUQ0hfSEFTSExJTUlUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfTkZf
TUFUQ0hfU1RSSU5HIGlzIG5vdCBzZXQKQ09ORklHX0lQX05GX0ZJTFRFUj15CkNPTkZJR19JUF9O
Rl9UQVJHRVRfUkVKRUNUPXkKQ09ORklHX0lQX05GX1RBUkdFVF9MT0c9eQpDT05GSUdfSVBfTkZf
VEFSR0VUX1VMT0c9eQpDT05GSUdfSVBfTkZfVEFSR0VUX1RDUE1TUz15CiMgQ09ORklHX0lQX05G
X1RBUkdFVF9ORlFVRVVFIGlzIG5vdCBzZXQKQ09ORklHX0lQX05GX05BVD15CkNPTkZJR19JUF9O
Rl9OQVRfTkVFREVEPXkKQ09ORklHX0lQX05GX1RBUkdFVF9NQVNRVUVSQURFPXkKQ09ORklHX0lQ
X05GX1RBUkdFVF9SRURJUkVDVD15CkNPTkZJR19JUF9ORl9UQVJHRVRfTkVUTUFQPXkKQ09ORklH
X0lQX05GX1RBUkdFVF9TQU1FPXkKIyBDT05GSUdfSVBfTkZfTkFUX1NOTVBfQkFTSUMgaXMgbm90
IHNldApDT05GSUdfSVBfTkZfTUFOR0xFPXkKQ09ORklHX0lQX05GX1RBUkdFVF9UT1M9eQpDT05G
SUdfSVBfTkZfVEFSR0VUX0VDTj15CkNPTkZJR19JUF9ORl9UQVJHRVRfRFNDUD15CkNPTkZJR19J
UF9ORl9UQVJHRVRfTUFSSz15CkNPTkZJR19JUF9ORl9UQVJHRVRfQ0xBU1NJRlk9eQojIENPTkZJ
R19JUF9ORl9UQVJHRVRfVFRMIGlzIG5vdCBzZXQKQ09ORklHX0lQX05GX1JBVz1tCkNPTkZJR19J
UF9ORl9UQVJHRVRfTk9UUkFDSz1tCkNPTkZJR19JUF9ORl9BUlBUQUJMRVM9eQpDT05GSUdfSVBf
TkZfQVJQRklMVEVSPXkKQ09ORklHX0lQX05GX0FSUF9NQU5HTEU9eQoKIwojIERDQ1AgQ29uZmln
dXJhdGlvbiAoRVhQRVJJTUVOVEFMKQojCiMgQ09ORklHX0lQX0RDQ1AgaXMgbm90IHNldAoKIwoj
IFNDVFAgQ29uZmlndXJhdGlvbiAoRVhQRVJJTUVOVEFMKQojCiMgQ09ORklHX0lQX1NDVFAgaXMg
bm90IHNldAojIENPTkZJR19BVE0gaXMgbm90IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNl
dAojIENPTkZJR19WTEFOXzgwMjFRIGlzIG5vdCBzZXQKIyBDT05GSUdfREVDTkVUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTExDMiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQWCBpcyBub3Qgc2V0CiMgQ09O
RklHX0FUQUxLIGlzIG5vdCBzZXQKIyBDT05GSUdfWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQ
QiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9ESVZFUlQgaXMgbm90IHNldAojIENPTkZJR19FQ09O
RVQgaXMgbm90IHNldAojIENPTkZJR19XQU5fUk9VVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1NDSEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19ST1VURSBpcyBub3Qgc2V0CgojCiMg
TmV0d29yayB0ZXN0aW5nCiMKIyBDT05GSUdfTkVUX1BLVEdFTiBpcyBub3Qgc2V0CiMgQ09ORklH
X0hBTVJBRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJEQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JU
IGlzIG5vdCBzZXQKIyBDT05GSUdfSUVFRTgwMjExIGlzIG5vdCBzZXQKCiMKIyBEZXZpY2UgRHJp
dmVycwojCgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucwojCkNPTkZJR19TVEFOREFMT05FPXkK
Q09ORklHX1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQpDT05GSUdfRldfTE9BREVSPW0KCiMKIyBD
b25uZWN0b3IgLSB1bmlmaWVkIHVzZXJzcGFjZSA8LT4ga2VybmVsc3BhY2UgbGlua2VyCiMKIyBD
T05GSUdfQ09OTkVDVE9SIGlzIG5vdCBzZXQKCiMKIyBNZW1vcnkgVGVjaG5vbG9neSBEZXZpY2Vz
IChNVEQpCiMKIyBDT05GSUdfTVREIGlzIG5vdCBzZXQKCiMKIyBQYXJhbGxlbCBwb3J0IHN1cHBv
cnQKIwojIENPTkZJR19QQVJQT1JUIGlzIG5vdCBzZXQKCiMKIyBQbHVnIGFuZCBQbGF5IHN1cHBv
cnQKIwpDT05GSUdfUE5QPXkKIyBDT05GSUdfUE5QX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBQcm90
b2NvbHMKIwpDT05GSUdfUE5QQUNQST15CgojCiMgQmxvY2sgZGV2aWNlcwojCkNPTkZJR19CTEtf
REVWX0ZEPXkKIyBDT05GSUdfQkxLX0NQUV9EQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19DUFFf
Q0lTU19EQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfREFDOTYwIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9VTUVNIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DT1dfQ09NTU9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9MT09QIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9OQkQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NYOCBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19ERVZfVUIgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1JBTSBpcyBub3Qgc2V0
CkNPTkZJR19CTEtfREVWX1JBTV9DT1VOVD0xNgpDT05GSUdfTEJEPXkKIyBDT05GSUdfQ0RST01f
UEtUQ0RWRCBpcyBub3Qgc2V0CgojCiMgSU8gU2NoZWR1bGVycwojCkNPTkZJR19JT1NDSEVEX05P
T1A9eQpDT05GSUdfSU9TQ0hFRF9BUz15CkNPTkZJR19JT1NDSEVEX0RFQURMSU5FPXkKQ09ORklH
X0lPU0NIRURfQ0ZRPXkKIyBDT05GSUdfQVRBX09WRVJfRVRIIGlzIG5vdCBzZXQKCiMKIyBBVEEv
QVRBUEkvTUZNL1JMTCBzdXBwb3J0CiMKQ09ORklHX0lERT15CkNPTkZJR19CTEtfREVWX0lERT15
CgojCiMgUGxlYXNlIHNlZSBEb2N1bWVudGF0aW9uL2lkZS50eHQgZm9yIGhlbHAvaW5mbyBvbiBJ
REUgZHJpdmVzCiMKIyBDT05GSUdfQkxLX0RFVl9JREVfU0FUQSBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfSERfSURFIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFRElTSz15CkNPTkZJ
R19JREVESVNLX01VTFRJX01PREU9eQpDT05GSUdfQkxLX0RFVl9JREVDRD15CiMgQ09ORklHX0JM
S19ERVZfSURFVEFQRSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSURFRkxPUFBZIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVTQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdfSURFX1RB
U0tfSU9DVEwgaXMgbm90IHNldAoKIwojIElERSBjaGlwc2V0IHN1cHBvcnQvYnVnZml4ZXMKIwpD
T05GSUdfSURFX0dFTkVSSUM9eQpDT05GSUdfQkxLX0RFVl9DTUQ2NDA9eQojIENPTkZJR19CTEtf
REVWX0NNRDY0MF9FTkhBTkNFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSURFUE5QIGlz
IG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFUENJPXkKQ09ORklHX0lERVBDSV9TSEFSRV9JUlE9
eQojIENPTkZJR19CTEtfREVWX09GRkJPQVJEIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfR0VO
RVJJQz15CiMgQ09ORklHX0JMS19ERVZfT1BUSTYyMSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVW
X1JaMTAwMD15CkNPTkZJR19CTEtfREVWX0lERURNQV9QQ0k9eQojIENPTkZJR19CTEtfREVWX0lE
RURNQV9GT1JDRUQgaXMgbm90IHNldApDT05GSUdfSURFRE1BX1BDSV9BVVRPPXkKIyBDT05GSUdf
SURFRE1BX09OTFlESVNLIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9BRUM2MlhYIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9BTEkxNVgzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RF
Vl9BTUQ3NFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9BVElJWFAgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX0NNRDY0WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVFJJRkxF
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ1k4MkM2OTMgaXMgbm90IHNldAojIENPTkZJ
R19CTEtfREVWX0NTNTUyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ1M1NTMwIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IUFQzNFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVW
X0hQVDM2NiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU0MxMjAwIGlzIG5vdCBzZXQKQ09O
RklHX0JMS19ERVZfUElJWD15CiMgQ09ORklHX0JMS19ERVZfSVQ4MjFYIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9OUzg3NDE1IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9QREMyMDJY
WF9PTEQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1BEQzIwMlhYX05FVyBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfU1ZXS1MgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NJSU1B
R0UgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NJUzU1MTMgaXMgbm90IHNldAojIENPTkZJ
R19CTEtfREVWX1NMQzkwRTY2IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9UUk0yOTAgaXMg
bm90IHNldAojIENPTkZJR19CTEtfREVWX1ZJQTgyQ1hYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0lE
RV9BUk0gaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVETUE9eQojIENPTkZJR19JREVETUFf
SVZCIGlzIG5vdCBzZXQKQ09ORklHX0lERURNQV9BVVRPPXkKIyBDT05GSUdfQkxLX0RFVl9IRCBp
cyBub3Qgc2V0CgojCiMgU0NTSSBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX1JBSURfQVRUUlMg
aXMgbm90IHNldApDT05GSUdfU0NTST15CkNPTkZJR19TQ1NJX1BST0NfRlM9eQoKIwojIFNDU0kg
c3VwcG9ydCB0eXBlIChkaXNrLCB0YXBlLCBDRC1ST00pCiMKQ09ORklHX0JMS19ERVZfU0Q9eQoj
IENPTkZJR19DSFJfREVWX1NUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hSX0RFVl9PU1NUIGlzIG5v
dCBzZXQKQ09ORklHX0JMS19ERVZfU1I9eQojIENPTkZJR19CTEtfREVWX1NSX1ZFTkRPUiBpcyBu
b3Qgc2V0CkNPTkZJR19DSFJfREVWX1NHPXkKIyBDT05GSUdfQ0hSX0RFVl9TQ0ggaXMgbm90IHNl
dAoKIwojIFNvbWUgU0NTSSBkZXZpY2VzIChlLmcuIENEIGp1a2Vib3gpIHN1cHBvcnQgbXVsdGlw
bGUgTFVOcwojCiMgQ09ORklHX1NDU0lfTVVMVElfTFVOIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9DT05TVEFOVFMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0xPR0dJTkcgaXMgbm90IHNldAoK
IwojIFNDU0kgVHJhbnNwb3J0IEF0dHJpYnV0ZXMKIwojIENPTkZJR19TQ1NJX1NQSV9BVFRSUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRkNfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X0lTQ1NJX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TQVNfQVRUUlMgaXMgbm90IHNl
dAoKIwojIFNDU0kgbG93LWxldmVsIGRyaXZlcnMKIwojIENPTkZJR19CTEtfREVWXzNXX1hYWFhf
UkFJRCBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJXzNXXzlYWFg9eQojIENPTkZJR19TQ1NJX0FDQVJE
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BQUNSQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9BSUM3WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSUM3WFhYX09MRCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfQUlDNzlYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRFBUX0kyTyBp
cyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX05FV0dFTiBpcyBub3Qgc2V0CiMgQ09ORklHX01F
R0FSQUlEX0xFR0FDWSBpcyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX1NBUyBpcyBub3Qgc2V0
CkNPTkZJR19TQ1NJX1NBVEE9eQojIENPTkZJR19TQ1NJX1NBVEFfQUhDSSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfU0FUQV9TVlcgaXMgbm90IHNldApDT05GSUdfU0NTSV9BVEFfUElJWD15CiMg
Q09ORklHX1NDU0lfU0FUQV9NViBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FUQV9OViBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FUQV9QUk9NSVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9TQVRBX1FTVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TQVRBX1NYNCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfU0FUQV9TSUwgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBVEFfU0lT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TQVRBX1VMSSBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfU0FUQV9WSUEgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBVEFfVklURVNTRSBpcyBub3Qg
c2V0CkNPTkZJR19TQ1NJX1NBVEFfSU5URUxfQ09NQklORUQ9eQojIENPTkZJR19TQ1NJX0JVU0xP
R0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ETVgzMTkxRCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDU0lfRUFUQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRlVUVVJFX0RPTUFJTiBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfR0RUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVBTIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9JTklUSU8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOSUEx
MDAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NZTTUzQzhYWF8yIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9JUFIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ19GQyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfUUxPR0lDXzEyODAgaXMgbm90IHNldApDT05GSUdfU0NTSV9RTEEyWFhY
PXkKIyBDT05GSUdfU0NTSV9RTEEyMVhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEEyMlhY
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEEyMzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV9RTEEyMzIyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEE2MzEyIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9RTEEyNFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9MUEZDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9EQzM5NXggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RDMzkwVCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTlNQMzIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RF
QlVHIGlzIG5vdCBzZXQKCiMKIyBNdWx0aS1kZXZpY2Ugc3VwcG9ydCAoUkFJRCBhbmQgTFZNKQoj
CiMgQ09ORklHX01EIGlzIG5vdCBzZXQKCiMKIyBGdXNpb24gTVBUIGRldmljZSBzdXBwb3J0CiMK
IyBDT05GSUdfRlVTSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVTSU9OX1NQSSBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZVU0lPTl9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0lPTl9TQVMgaXMgbm90
IHNldAoKIwojIElFRUUgMTM5NCAoRmlyZVdpcmUpIHN1cHBvcnQKIwpDT05GSUdfSUVFRTEzOTQ9
eQoKIwojIFN1YnN5c3RlbSBPcHRpb25zCiMKIyBDT05GSUdfSUVFRTEzOTRfVkVSQk9TRURFQlVH
IGlzIG5vdCBzZXQKIyBDT05GSUdfSUVFRTEzOTRfT1VJX0RCIGlzIG5vdCBzZXQKIyBDT05GSUdf
SUVFRTEzOTRfRVhUUkFfQ09ORklHX1JPTVMgaXMgbm90IHNldAojIENPTkZJR19JRUVFMTM5NF9F
WFBPUlRfRlVMTF9BUEkgaXMgbm90IHNldAoKIwojIERldmljZSBEcml2ZXJzCiMKCiMKIyBUZXhh
cyBJbnN0cnVtZW50cyBQQ0lMeW54IHJlcXVpcmVzIEkyQwojCkNPTkZJR19JRUVFMTM5NF9PSENJ
MTM5ND15CgojCiMgUHJvdG9jb2wgRHJpdmVycwojCiMgQ09ORklHX0lFRUUxMzk0X1ZJREVPMTM5
NCBpcyBub3Qgc2V0CiMgQ09ORklHX0lFRUUxMzk0X1NCUDIgaXMgbm90IHNldAojIENPTkZJR19J
RUVFMTM5NF9FVEgxMzk0IGlzIG5vdCBzZXQKIyBDT05GSUdfSUVFRTEzOTRfRFYxMzk0IGlzIG5v
dCBzZXQKQ09ORklHX0lFRUUxMzk0X1JBV0lPPXkKIyBDT05GSUdfSUVFRTEzOTRfQ01QIGlzIG5v
dCBzZXQKCiMKIyBJMk8gZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19JMk8gaXMgbm90IHNldAoK
IwojIE5ldHdvcmsgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfTkVUREVWSUNFUz15CkNPTkZJR19E
VU1NWT1tCiMgQ09ORklHX0JPTkRJTkcgaXMgbm90IHNldAojIENPTkZJR19FUVVBTElaRVIgaXMg
bm90IHNldAojIENPTkZJR19UVU4gaXMgbm90IHNldAojIENPTkZJR19ORVRfU0IxMDAwIGlzIG5v
dCBzZXQKCiMKIyBBUkNuZXQgZGV2aWNlcwojCiMgQ09ORklHX0FSQ05FVCBpcyBub3Qgc2V0Cgoj
CiMgUEhZIGRldmljZSBzdXBwb3J0CiMKCiMKIyBFdGhlcm5ldCAoMTAgb3IgMTAwTWJpdCkKIwoj
IENPTkZJR19ORVRfRVRIRVJORVQgaXMgbm90IHNldAoKIwojIEV0aGVybmV0ICgxMDAwIE1iaXQp
CiMKIyBDT05GSUdfQUNFTklDIGlzIG5vdCBzZXQKIyBDT05GSUdfREwySyBpcyBub3Qgc2V0CkNP
TkZJR19FMTAwMD1tCkNPTkZJR19FMTAwMF9OQVBJPXkKIyBDT05GSUdfTlM4MzgyMCBpcyBub3Qg
c2V0CiMgQ09ORklHX0hBTUFDSEkgaXMgbm90IHNldAojIENPTkZJR19ZRUxMT1dGSU4gaXMgbm90
IHNldAojIENPTkZJR19SODE2OSBpcyBub3Qgc2V0CiMgQ09ORklHX1NJUzE5MCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NLR0UgaXMgbm90IHNldApDT05GSUdfU0s5OExJTj1tCkNPTkZJR19TSzk4TElO
X05BUEk9eQojIENPTkZJR19USUdPTjMgaXMgbm90IHNldAojIENPTkZJR19CTlgyIGlzIG5vdCBz
ZXQKCiMKIyBFdGhlcm5ldCAoMTAwMDAgTWJpdCkKIwojIENPTkZJR19DSEVMU0lPX1QxIGlzIG5v
dCBzZXQKIyBDT05GSUdfSVhHQiBpcyBub3Qgc2V0CiMgQ09ORklHX1MySU8gaXMgbm90IHNldAoK
IwojIFRva2VuIFJpbmcgZGV2aWNlcwojCiMgQ09ORklHX1RSIGlzIG5vdCBzZXQKCiMKIyBXaXJl
bGVzcyBMQU4gKG5vbi1oYW1yYWRpbykKIwojIENPTkZJR19ORVRfUkFESU8gaXMgbm90IHNldAoK
IwojIFdhbiBpbnRlcmZhY2VzCiMKIyBDT05GSUdfV0FOIGlzIG5vdCBzZXQKIyBDT05GSUdfRkRE
SSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJUFBJIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBQIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0xJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GQyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NIQVBFUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVENPTlNPTEUgaXMgbm90IHNl
dAojIENPTkZJR19ORVRQT0xMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1BPTExfQ09OVFJPTExF
UiBpcyBub3Qgc2V0CgojCiMgSVNETiBzdWJzeXN0ZW0KIwojIENPTkZJR19JU0ROIGlzIG5vdCBz
ZXQKCiMKIyBUZWxlcGhvbnkgU3VwcG9ydAojCiMgQ09ORklHX1BIT05FIGlzIG5vdCBzZXQKCiMK
IyBJbnB1dCBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19JTlBVVD15CgojCiMgVXNlcmxhbmQgaW50
ZXJmYWNlcwojCkNPTkZJR19JTlBVVF9NT1VTRURFVj15CkNPTkZJR19JTlBVVF9NT1VTRURFVl9Q
U0FVWD15CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWD0xMDI0CkNPTkZJR19JTlBVVF9N
T1VTRURFVl9TQ1JFRU5fWT03NjgKIyBDT05GSUdfSU5QVVRfSk9ZREVWIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfVFNERVYgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9FVkRFViBpcyBub3Qg
c2V0CiMgQ09ORklHX0lOUFVUX0VWQlVHIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBEZXZpY2UgRHJp
dmVycwojCkNPTkZJR19JTlBVVF9LRVlCT0FSRD15CkNPTkZJR19LRVlCT0FSRF9BVEtCRD15CiMg
Q09ORklHX0tFWUJPQVJEX1NVTktCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX0xLS0JE
IGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfWFRLQkQgaXMgbm90IHNldAojIENPTkZJR19L
RVlCT0FSRF9ORVdUT04gaXMgbm90IHNldApDT05GSUdfSU5QVVRfTU9VU0U9eQpDT05GSUdfTU9V
U0VfUFMyPXkKIyBDT05GSUdfTU9VU0VfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0Vf
VlNYWFhBQSBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0pPWVNUSUNLIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU4gaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9NSVNDIGlz
IG5vdCBzZXQKCiMKIyBIYXJkd2FyZSBJL08gcG9ydHMKIwpDT05GSUdfU0VSSU89eQpDT05GSUdf
U0VSSU9fSTgwNDI9eQojIENPTkZJR19TRVJJT19TRVJQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VSSU9fQ1Q4MkM3MTAgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19QQ0lQUzIgaXMgbm90IHNl
dApDT05GSUdfU0VSSU9fTElCUFMyPXkKIyBDT05GSUdfU0VSSU9fUkFXIGlzIG5vdCBzZXQKIyBD
T05GSUdfR0FNRVBPUlQgaXMgbm90IHNldAoKIwojIENoYXJhY3RlciBkZXZpY2VzCiMKQ09ORklH
X1ZUPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdfSFdfQ09OU09MRT15CiMgQ09ORklHX1NF
UklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0CgojCiMgU2VyaWFsIGRyaXZlcnMKIwpDT05GSUdf
U0VSSUFMXzgyNTA9eQojIENPTkZJR19TRVJJQUxfODI1MF9DT05TT0xFIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VSSUFMXzgyNTBfQUNQSSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfODI1MF9OUl9V
QVJUUz00CiMgQ09ORklHX1NFUklBTF84MjUwX0VYVEVOREVEIGlzIG5vdCBzZXQKCiMKIyBOb24t
ODI1MCBzZXJpYWwgcG9ydCBzdXBwb3J0CiMKQ09ORklHX1NFUklBTF9DT1JFPXkKIyBDT05GSUdf
U0VSSUFMX0pTTSBpcyBub3Qgc2V0CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJR19MRUdBQ1lf
UFRZUz15CkNPTkZJR19MRUdBQ1lfUFRZX0NPVU5UPTI1NgoKIwojIElQTUkKIwojIENPTkZJR19J
UE1JX0hBTkRMRVIgaXMgbm90IHNldAoKIwojIFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfV0FU
Q0hET0cgaXMgbm90IHNldAojIENPTkZJR19IV19SQU5ET00gaXMgbm90IHNldAojIENPTkZJR19O
VlJBTSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQyBpcyBub3Qgc2V0CiMgQ09ORklHX0dFTl9SVEMg
aXMgbm90IHNldAojIENPTkZJR19SMzk2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0FQUExJQ09NIGlz
IG5vdCBzZXQKIyBDT05GSUdfU09OWVBJIGlzIG5vdCBzZXQKCiMKIyBGdGFwZSwgdGhlIGZsb3Bw
eSB0YXBlIGRldmljZSBkcml2ZXIKIwpDT05GSUdfQUdQPXkKIyBDT05GSUdfQUdQX0FMSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FHUF9BVEkgaXMgbm90IHNldAojIENPTkZJR19BR1BfQU1EIGlzIG5v
dCBzZXQKIyBDT05GSUdfQUdQX0FNRDY0IGlzIG5vdCBzZXQKQ09ORklHX0FHUF9JTlRFTD15CiMg
Q09ORklHX0FHUF9OVklESUEgaXMgbm90IHNldAojIENPTkZJR19BR1BfU0lTIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUdQX1NXT1JLUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9WSUEgaXMgbm90IHNl
dAojIENPTkZJR19BR1BfRUZGSUNFT04gaXMgbm90IHNldAojIENPTkZJR19EUk0gaXMgbm90IHNl
dAojIENPTkZJR19NV0FWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JBV19EUklWRVIgaXMgbm90IHNl
dApDT05GSUdfSFBFVD15CiMgQ09ORklHX0hQRVRfUlRDX0lSUSBpcyBub3Qgc2V0CkNPTkZJR19I
UEVUX01NQVA9eQojIENPTkZJR19IQU5HQ0hFQ0tfVElNRVIgaXMgbm90IHNldAoKIwojIFRQTSBk
ZXZpY2VzCiMKIyBDT05GSUdfVENHX1RQTSBpcyBub3Qgc2V0CgojCiMgSTJDIHN1cHBvcnQKIwoj
IENPTkZJR19JMkMgaXMgbm90IHNldAoKIwojIERhbGxhcydzIDEtd2lyZSBidXMKIwojIENPTkZJ
R19XMSBpcyBub3Qgc2V0CgojCiMgSGFyZHdhcmUgTW9uaXRvcmluZyBzdXBwb3J0CiMKQ09ORklH
X0hXTU9OPXkKIyBDT05GSUdfSFdNT05fVklEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19I
REFQUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hXTU9OX0RFQlVHX0NISVAgaXMgbm90IHNldAoKIwoj
IE1pc2MgZGV2aWNlcwojCiMgQ09ORklHX0lCTV9BU00gaXMgbm90IHNldAoKIwojIE11bHRpbWVk
aWEgQ2FwYWJpbGl0aWVzIFBvcnQgZHJpdmVycwojCgojCiMgTXVsdGltZWRpYSBkZXZpY2VzCiMK
IyBDT05GSUdfVklERU9fREVWIGlzIG5vdCBzZXQKCiMKIyBEaWdpdGFsIFZpZGVvIEJyb2FkY2Fz
dGluZyBEZXZpY2VzCiMKIyBDT05GSUdfRFZCIGlzIG5vdCBzZXQKCiMKIyBHcmFwaGljcyBzdXBw
b3J0CiMKIyBDT05GSUdfRkIgaXMgbm90IHNldAojIENPTkZJR19WSURFT19TRUxFQ1QgaXMgbm90
IHNldAoKIwojIENvbnNvbGUgZGlzcGxheSBkcml2ZXIgc3VwcG9ydAojCkNPTkZJR19WR0FfQ09O
U09MRT15CkNPTkZJR19EVU1NWV9DT05TT0xFPXkKCiMKIyBTcGVha3VwIGNvbnNvbGUgc3BlZWNo
CiMKIyBDT05GSUdfU1BFQUtVUCBpcyBub3Qgc2V0CkNPTkZJR19TUEVBS1VQX0RFRkFVTFQ9Im5v
bmUiCgojCiMgU291bmQKIwojIENPTkZJR19TT1VORCBpcyBub3Qgc2V0CgojCiMgVVNCIHN1cHBv
cnQKIwpDT05GSUdfVVNCX0FSQ0hfSEFTX0hDRD15CkNPTkZJR19VU0JfQVJDSF9IQVNfT0hDST15
CkNPTkZJR19VU0I9eQojIENPTkZJR19VU0JfREVCVUcgaXMgbm90IHNldAoKIwojIE1pc2NlbGxh
bmVvdXMgVVNCIG9wdGlvbnMKIwpDT05GSUdfVVNCX0RFVklDRUZTPXkKIyBDT05GSUdfVVNCX0JB
TkRXSURUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9EWU5BTUlDX01JTk9SUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9TVVNQRU5EIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX09URyBpcyBub3Qg
c2V0CgojCiMgVVNCIEhvc3QgQ29udHJvbGxlciBEcml2ZXJzCiMKQ09ORklHX1VTQl9FSENJX0hD
RD15CiMgQ09ORklHX1VTQl9FSENJX1NQTElUX0lTTyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9F
SENJX1JPT1RfSFVCX1RUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDExNlhfSENEIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX09IQ0lfSENEIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9VSENJX0hD
RD15CiMgQ09ORklHX1VTQl9TTDgxMV9IQ0QgaXMgbm90IHNldAoKIwojIFVTQiBEZXZpY2UgQ2xh
c3MgZHJpdmVycwojCiMgQ09ORklHX1VTQl9CTFVFVE9PVEhfVFRZIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0FDTSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfUFJJTlRFUj15CgojCiMgTk9URTogVVNC
X1NUT1JBR0UgZW5hYmxlcyBTQ1NJLCBhbmQgJ1NDU0kgZGlzayBzdXBwb3J0JyBtYXkgYWxzbyBi
ZSBuZWVkZWQ7IHNlZSBVU0JfU1RPUkFHRSBIZWxwIGZvciBtb3JlIGluZm9ybWF0aW9uCiMKQ09O
RklHX1VTQl9TVE9SQUdFPXkKIyBDT05GSUdfVVNCX1NUT1JBR0VfREVCVUcgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfU1RPUkFHRV9EQVRBRkFCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JB
R0VfRlJFRUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0lTRDIwMCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0RQQ00gaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RP
UkFHRV9VU0JBVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFIwOSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFI1NSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9T
VE9SQUdFX0pVTVBTSE9UIGlzIG5vdCBzZXQKCiMKIyBVU0IgSW5wdXQgRGV2aWNlcwojCkNPTkZJ
R19VU0JfSElEPXkKQ09ORklHX1VTQl9ISURJTlBVVD15CiMgQ09ORklHX0hJRF9GRiBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9ISURERVYgaXMgbm90IHNldAojIENPTkZJR19VU0JfQUlQVEVLIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1dBQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FDRUNB
RCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9LQlRBQiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9Q
T1dFUk1BVEUgaXMgbm90IHNldAojIENPTkZJR19VU0JfTVRPVUNIIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0lUTVRPVUNIIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9FR0FMQVg9bQojIENPTkZJR19V
U0JfWUVBTElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9YUEFEIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0FUSV9SRU1PVEUgaXMgbm90IHNldAojIENPTkZJR19VU0JfS0VZU1BBTl9SRU1PVEUg
aXMgbm90IHNldAojIENPTkZJR19VU0JfQVBQTEVUT1VDSCBpcyBub3Qgc2V0CgojCiMgVVNCIElt
YWdpbmcgZGV2aWNlcwojCiMgQ09ORklHX1VTQl9NREM4MDAgaXMgbm90IHNldAojIENPTkZJR19V
U0JfTUlDUk9URUsgaXMgbm90IHNldAoKIwojIFVTQiBNdWx0aW1lZGlhIGRldmljZXMKIwojIENP
TkZJR19VU0JfREFCVVNCIGlzIG5vdCBzZXQKCiMKIyBWaWRlbzRMaW51eCBzdXBwb3J0IGlzIG5l
ZWRlZCBmb3IgVVNCIE11bHRpbWVkaWEgZGV2aWNlIHN1cHBvcnQKIwoKIwojIFVTQiBOZXR3b3Jr
IEFkYXB0ZXJzCiMKIyBDT05GSUdfVVNCX0NBVEMgaXMgbm90IHNldAojIENPTkZJR19VU0JfS0FX
RVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1BFR0FTVVMgaXMgbm90IHNldAojIENPTkZJR19V
U0JfUlRMODE1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9VU0JORVQgaXMgbm90IHNldApDT05G
SUdfVVNCX01PTj15CgojCiMgVVNCIHBvcnQgZHJpdmVycwojCgojCiMgVVNCIFNlcmlhbCBDb252
ZXJ0ZXIgc3VwcG9ydAojCiMgQ09ORklHX1VTQl9TRVJJQUwgaXMgbm90IHNldAoKIwojIFVTQiBN
aXNjZWxsYW5lb3VzIGRyaXZlcnMKIwojIENPTkZJR19VU0JfRU1JNjIgaXMgbm90IHNldAojIENP
TkZJR19VU0JfRU1JMjYgaXMgbm90IHNldAojIENPTkZJR19VU0JfQVVFUlNXQUxEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1JJTzUwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MRUdPVE9XRVIg
aXMgbm90IHNldAojIENPTkZJR19VU0JfTENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xFRCBp
cyBub3Qgc2V0CkNPTkZJR19VU0JfQ1lUSEVSTT1tCiMgQ09ORklHX1VTQl9QSElER0VUS0lUIGlz
IG5vdCBzZXQKQ09ORklHX1VTQl9QSElER0VUU0VSVk89bQojIENPTkZJR19VU0JfSURNT1VTRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TSVNVU0JWR0EgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
TEQgaXMgbm90IHNldAojIENPTkZJR19VU0JfVEVTVCBpcyBub3Qgc2V0CgojCiMgVVNCIERTTCBt
b2RlbSBzdXBwb3J0CiMKCiMKIyBVU0IgR2FkZ2V0IFN1cHBvcnQKIwojIENPTkZJR19VU0JfR0FE
R0VUIGlzIG5vdCBzZXQKCiMKIyBNTUMvU0QgQ2FyZCBzdXBwb3J0CiMKIyBDT05GSUdfTU1DIGlz
IG5vdCBzZXQKCiMKIyBJbmZpbmlCYW5kIHN1cHBvcnQKIwojIENPTkZJR19JTkZJTklCQU5EIGlz
IG5vdCBzZXQKCiMKIyBTTiBEZXZpY2VzCiMKCiMKIyBGaWxlIHN5c3RlbXMKIwpDT05GSUdfRVhU
Ml9GUz15CiMgQ09ORklHX0VYVDJfRlNfWEFUVFIgaXMgbm90IHNldAojIENPTkZJR19FWFQyX0ZT
X1hJUCBpcyBub3Qgc2V0CkNPTkZJR19FWFQzX0ZTPXkKQ09ORklHX0VYVDNfRlNfWEFUVFI9eQoj
IENPTkZJR19FWFQzX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDNfRlNfU0VD
VVJJVFkgaXMgbm90IHNldApDT05GSUdfSkJEPXkKIyBDT05GSUdfSkJEX0RFQlVHIGlzIG5vdCBz
ZXQKQ09ORklHX0ZTX01CQ0FDSEU9eQojIENPTkZJR19SRUlTRVJGU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0pGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0
CiMgQ09ORklHX1hGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX01JTklYX0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfUk9NRlNfRlMgaXMgbm90IHNldApDT05GSUdfSU5PVElGWT15CiMgQ09ORklHX1FV
T1RBIGlzIG5vdCBzZXQKQ09ORklHX0ROT1RJRlk9eQojIENPTkZJR19BVVRPRlNfRlMgaXMgbm90
IHNldApDT05GSUdfQVVUT0ZTNF9GUz15CiMgQ09ORklHX0ZVU0VfRlMgaXMgbm90IHNldAoKIwoj
IENELVJPTS9EVkQgRmlsZXN5c3RlbXMKIwpDT05GSUdfSVNPOTY2MF9GUz15CkNPTkZJR19KT0xJ
RVQ9eQojIENPTkZJR19aSVNPRlMgaXMgbm90IHNldApDT05GSUdfVURGX0ZTPXkKQ09ORklHX1VE
Rl9OTFM9eQoKIwojIERPUy9GQVQvTlQgRmlsZXN5c3RlbXMKIwpDT05GSUdfRkFUX0ZTPXkKQ09O
RklHX01TRE9TX0ZTPXkKQ09ORklHX1ZGQVRfRlM9eQpDT05GSUdfRkFUX0RFRkFVTFRfQ09ERVBB
R0U9NDM3CkNPTkZJR19GQVRfREVGQVVMVF9JT0NIQVJTRVQ9Imlzbzg4NTktMSIKIyBDT05GSUdf
TlRGU19GUyBpcyBub3Qgc2V0CgojCiMgUHNldWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BST0Nf
RlM9eQpDT05GSUdfUFJPQ19LQ09SRT15CkNPTkZJR19TWVNGUz15CkNPTkZJR19UTVBGUz15CiMg
Q09ORklHX0hVR0VUTEJGUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hVR0VUTEJfUEFHRSBpcyBub3Qg
c2V0CkNPTkZJR19SQU1GUz15CiMgQ09ORklHX1JFTEFZRlNfRlMgaXMgbm90IHNldAoKIwojIE1p
c2NlbGxhbmVvdXMgZmlsZXN5c3RlbXMKIwojIENPTkZJR19BREZTX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfQUZGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU19GUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0hGU1BMVVNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRUZTX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JBTUZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU1FVQVNIRlMgaXMgbm90IHNldAojIENPTkZJ
R19WWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1FOWDRGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU1ZfRlMgaXMgbm90IHNldAojIENPTkZJ
R19VRlNfRlMgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgRmlsZSBTeXN0ZW1zCiMKIyBDT05GSUdf
TkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTRCBpcyBub3Qgc2V0CkNPTkZJR19TTUJfRlM9
eQojIENPTkZJR19TTUJfTkxTX0RFRkFVTFQgaXMgbm90IHNldAojIENPTkZJR19DSUZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkNQX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09EQV9GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0FGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHXzlQX0ZTIGlzIG5vdCBzZXQK
CiMKIyBQYXJ0aXRpb24gVHlwZXMKIwojIENPTkZJR19QQVJUSVRJT05fQURWQU5DRUQgaXMgbm90
IHNldApDT05GSUdfTVNET1NfUEFSVElUSU9OPXkKCiMKIyBOYXRpdmUgTGFuZ3VhZ2UgU3VwcG9y
dAojCkNPTkZJR19OTFM9eQpDT05GSUdfTkxTX0RFRkFVTFQ9Imlzbzg4NTktMSIKQ09ORklHX05M
U19DT0RFUEFHRV80Mzc9eQojIENPTkZJR19OTFNfQ09ERVBBR0VfNzM3IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzc3NSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQ09ERVBBR0VfODUw
PXkKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU3IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV84NjEgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYyIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NjQgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY1IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzg2NiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84Njkg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTM2IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzk1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzIgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTQ5IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0NPREVQQUdFXzg3NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzggaXMgbm90IHNl
dAojIENPTkZJR19OTFNfQ09ERVBBR0VfMTI1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV8xMjUxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0FTQ0lJIGlzIG5vdCBzZXQKQ09ORklH
X05MU19JU084ODU5XzE9eQojIENPTkZJR19OTFNfSVNPODg1OV8yIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0lTTzg4NTlfMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzQgaXMgbm90
IHNldAojIENPTkZJR19OTFNfSVNPODg1OV81IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4
NTlfNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzcgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfSVNPODg1OV85IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTMgaXMgbm90
IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xNCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084
ODU5XzE1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tPSThfUiBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19LT0k4X1UgaXMgbm90IHNldApDT05GSUdfTkxTX1VURjg9eQoKIwojIFByb2ZpbGluZyBz
dXBwb3J0CiMKIyBDT05GSUdfUFJPRklMSU5HIGlzIG5vdCBzZXQKCiMKIyBLZXJuZWwgaGFja2lu
ZwojCiMgQ09ORklHX1BSSU5US19USU1FIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfS0VSTkVM
IGlzIG5vdCBzZXQKQ09ORklHX0xPR19CVUZfU0hJRlQ9MTUKQ09ORklHX0RFQlVHX0JVR1ZFUkJP
U0U9eQpDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX1g4Nl9GSU5EX1NNUF9DT05GSUc9eQpD
T05GSUdfWDg2X01QUEFSU0U9eQoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwojIENPTkZJR19LRVlT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFkgaXMgbm90IHNldAoKIwojIENyeXB0b2dyYXBo
aWMgb3B0aW9ucwojCiMgQ09ORklHX0NSWVBUTyBpcyBub3Qgc2V0CgojCiMgSGFyZHdhcmUgY3J5
cHRvIGRldmljZXMKIwoKIwojIExpYnJhcnkgcm91dGluZXMKIwojIENPTkZJR19DUkNfQ0NJVFQg
aXMgbm90IHNldAojIENPTkZJR19DUkMxNiBpcyBub3Qgc2V0CkNPTkZJR19DUkMzMj15CkNPTkZJ
R19MSUJDUkMzMkM9bQpDT05GSUdfR0VORVJJQ19IQVJESVJRUz15CkNPTkZJR19HRU5FUklDX0lS
UV9QUk9CRT15CkNPTkZJR19HRU5FUklDX1BFTkRJTkdfSVJRPXkKQ09ORklHX1g4Nl9TTVA9eQpD
T05GSUdfWDg2X0hUPXkKQ09ORklHX1g4Nl9CSU9TX1JFQk9PVD15CkNPTkZJR19YODZfVFJBTVBP
TElORT15CkNPTkZJR19QQz15Cg==

--MP_GihChYMF22CzJ+XBMzi.vQv--
