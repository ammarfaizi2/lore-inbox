Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUEDWZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUEDWZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUEDWZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:25:56 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:40551 "EHLO
	mwinf0202.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261396AbUEDWZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:25:52 -0400
Message-ID: <4098186D.2070008@reolight.net>
Date: Wed, 05 May 2004 00:25:49 +0200
From: Auzanneau Gregory <mls@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at net/core/dev.c:3031! (kernel 2.6.5-rc1)
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig79F78FF2BCAD6EA4140064C0"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79F78FF2BCAD6EA4140064C0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit


Each day, my ISP disconnects my pppoe session.
For the first time, i've a kernel bug that produce a crash of pppd, and
cannot restart connection before restarting my computer.
I haven't been able to reproduce the problem manually.
It's very closed to my last mail: http://lkml.org/lkml/2004/3/31/109
Jeff Garzik said me this may be caused by a corruption of my realtek
8139 with 8139_RXBUF_IDX=3. But now, this option disappeared.

my kernel version: Linux greg-port 2.6.6-rc2-mm1 #1 Sat Apr 24 13:41:12
CEST 2004 i686 GNU/Linux

Here the bug report in /var/log/message:
May  4 21:46:38 greg-port pppd[1016]: Connection terminated.
May  4 21:46:38 greg-port pppd[1016]: Connect time 1440.0 minutes.
May  4 21:46:38 greg-port pppd[1016]: Sent 429883861 bytes, received
832906312 bytes.
May  4 21:46:38 greg-port kernel: ------------[ cut here ]------------
May  4 21:46:38 greg-port kernel: kernel BUG at net/core/dev.c:3040!
May  4 21:46:38 greg-port kernel: invalid operand: 0000 [#1]
May  4 21:46:38 greg-port kernel: PREEMPT
May  4 21:46:38 greg-port kernel: CPU:    0
May  4 21:46:38 greg-port kernel: EIP:    0060:[<c02e6eae>]    Not
tainted VLI
May  4 21:46:38 greg-port kernel: EFLAGS: 00010297   (2.6.6-rc2-mm1)
May  4 21:46:38 greg-port kernel: EIP is at free_netdev+0x2b/0x44
May  4 21:46:38 greg-port kernel: eax: c498d800   ebx: df07e000   ecx:
c03d4440   edx: 00000003
May  4 21:46:38 greg-port kernel: esi: c498d800   edi: c1742880   ebp:
e189d600   esp: df07ff48

May  4 21:46:38 greg-port kernel: Process pppd (pid: 1016,
threadinfo=df07e000 task=df0672b0)
May  4 21:46:38 greg-port kernel: Stack: e189b148 c498d800 00000282
d472a780 c1742880 00000000 dfde4200 def70624
May  4 21:46:38 greg-port kernel:        e1898081 c1742880 cba67780
c0147afb def70624 cba67780 dfa73680 cba67780
May  4 21:46:38 greg-port kernel:        00000000 df393280 df07e000
c01463d9 cba67780 df393280 df393280 cba67780
May  4 21:46:38 greg-port kernel: Call Trace:
May  4 21:46:38 greg-port kernel:  [<e189b148>]
ppp_shutdown_interface+0x83/0xe5 [ppp_generic]
May  4 21:46:38 greg-port kernel:  [<e1898081>] ppp_release+0x5f/0x61
[ppp_generic]
May  4 21:46:38 greg-port kernel:  [<c0147afb>] __fput+0x108/0x11a
May  4 21:46:38 greg-port kernel:  [<c01463d9>] filp_close+0x59/0x86
May  4 21:46:38 greg-port kernel:  [<c0146469>] sys_close+0x63/0x96
May  4 21:46:38 greg-port kernel:  [<c01057fb>] syscall_call+0x7/0xb
May  4 21:46:38 greg-port kernel:
May  4 21:46:38 greg-port kernel: Code: 8b 44 24 04 8b 90 3c 01 00 00 85
d2 74 27 83 fa 04 75 18 c7 80 3c 01 00 00 05 00 00 00 05 a0 01 00 00 89
44 24 04 e9 dd b7 f4 ff <0f> 0b e0 0b 9f 59 37 c0 eb de 2b 80 00 02 00
00 89 44 24 04 e9


Thank you all for the good work with linux, keep up with it ! :)

-- 
Auzanneau Grégory
GPG 0x99137BEE


--------------enig79F78FF2BCAD6EA4140064C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAmBhw3H6YHZkTe+4RArmBAJ0dRo/HS+FxEuai1DhhjVvBpN+CswCfSQAa
JbbHiYxj0P5sD324x9TsNJI=
=UCDK
-----END PGP SIGNATURE-----

--------------enig79F78FF2BCAD6EA4140064C0--
