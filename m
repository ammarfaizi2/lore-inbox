Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274866AbRJALJL>; Mon, 1 Oct 2001 07:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274868AbRJALJB>; Mon, 1 Oct 2001 07:09:01 -0400
Received: from c207-202-243-179.sea1.cablespeed.com ([207.202.243.179]:52798
	"EHLO darklands.localhost.localdomain") by vger.kernel.org with ESMTP
	id <S274866AbRJALIz>; Mon, 1 Oct 2001 07:08:55 -0400
Date: Mon, 1 Oct 2001 04:09:14 -0700
From: Thomas Zimmerman <thomas@zimres.net>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.10-ac1-Preempt-kernel-1
Message-ID: <20011001040914.A1567@darklands.zimres.net>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux darklands 2.4.10-ac1
X-Operating-Status: 02:08:51 up 10 min,  1 user,  load average: 12.32, 5.67, 2.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just for fun:
$cd /usr/src/linux [2.4.10-ac1+netrand+preempt+reempt-stats]
$cat /proc/latencytimes
[snip empty report]
$make -j dep
[snip long make]
$cat /proc/latencytimes
Worst 20 latency times of 2604 measured in this period.
  usec      cause     mask   start line/file      address   end line/fil
e
 25673   reacqBKL        1  1374/sched.c         c0113219   696/sched.c
 22718  spin_lock        1   547/sched.c         c0111644   696/sched.c
 10238  spin_lock        1   547/sched.c         c0111644   303/namei.c
  7599      timer        5    76/softirq.c       c011a437   119/softirq.
c
  6832  spin_lock        0   547/sched.c         c0111644   280/time.c
  6731  spin_lock        1   708/open.c          c01370c8   757/open.c
  6174        BKL        0    59/ioctl.c         c0148204   121/ioctl.c
  6097       ide0        0   585/irq.c           c01084ef   647/irq.c
  4753        BKL        1  1462/inode.c         c0178979  1470/inode.c
  4008        BKL        1  1462/inode.c         c0178979   143/attr.c
  3961  spin_lock        0   547/sched.c         c0111644   647/irq.c
  3791   reacqBKL        0  1374/sched.c         c0113219  1378/sched.c
  3753        BKL        0  2687/buffer.c        c013cbe6   696/sched.c
  3519  spin_lock        0   547/sched.c         c0111644   133/file_tab
le.c
  2925  spin_lock        0  1308/audio.c         c01e5c0b  1319/audio.c
  1990  spin_lock        0   547/sched.c         c0111644   172/select.c
  1793  spin_lock        0   547/sched.c         c0111644   700/namei.c
  1500        BKL        0   301/namei.c         c0143757   133/file_tab
le.c
  1387        BKL        0   837/inode.c         c01776d3   647/irq.c
  1208   reacqBKL        0  1374/sched.c         c0113219  1470/inode.c
qubes@darklands:/usr/src/linux>
-------------
For full disclosure: I use the binary only nvidia driver and have vmware2.x
modules loaded (but unused yet). This is in X with kde loaded, gkrellm
running (reported ~280 procs at height of make), xmms running. Only one skip
in play back, and the mouse jumped a bit sometimes. :)

Now, it's off to build a kernel w/o the stats, to see it that changes
anything....and it does. The sound didn't skip this time, and the proc load
"only" got upto ~200.=20

This is a AMD Athlon 800 w/512 Meg ram, ext3 root, reiserfs /usr on sw raid=
0=20
over two sw raid1s.=20

Thomas
--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE7uE7aUHPW3p9PurIRAqo0AJ9RKZnUKIrpT2uWaxRtJ/ZSUdhxqwCfdY9v
ZegZ6cJ54r6oPq8UyW/SI00=
=PBMY
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
