Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUCaSge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUCaSge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:36:34 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:16513 "EHLO
	mwinf0602.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262304AbUCaSg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:36:28 -0500
Message-ID: <406B0F9E.10504@gregory5.sytes.net>
Date: Wed, 31 Mar 2004 20:36:14 +0200
From: Auzanneau Gregory <mls@gregory5.sytes.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at net/core/dev.c:3031! (kernel 2.6.5-rc1)
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1A975E61B4A003F21CE90C02"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A975E61B4A003F21CE90C02
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit


Each day, my ISP disconnects my pppoe session. 3 times (03/24, 03/30,
03/31), this produced a kernel bug that don't allow me to start again
pppd without rebooting my computer. I haven't been able to reproduce the
problem manually. The problem started with kernel 2.6.5-rc1. I never saw
it with 2.6.4 and before.

my kernel version: Linux greg-port 2.6.5-rc1 #1 Fri Mar 19 18:29:21 CET
2004 i686 GNU/Linux

Here the bug report in /var/log/message

Mar 30 17:44:27 greg-port kernel: ------------[ cut here ]------------
Mar 30 17:44:27 greg-port kernel: kernel BUG at net/core/dev.c:3031!
Mar 30 17:44:27 greg-port kernel: invalid operand: 0000 [#1]
Mar 30 17:44:27 greg-port kernel: PREEMPT
Mar 30 17:44:27 greg-port kernel: CPU:    0
Mar 30 17:44:27 greg-port kernel: EIP:    0060:[free_netdev+43/68]
Not tainted
Mar 30 17:44:27 greg-port kernel: EFLAGS: 00210297   (2.6.5-rc1)
Mar 30 17:44:27 greg-port kernel: EIP is at free_netdev+0x2b/0x44
Mar 30 17:44:27 greg-port kernel: eax: de75e400   ebx: d3d56000   ecx:
c03d05a0   edx: 00000003
Mar 30 17:44:27 greg-port kernel: esi: de75e400   edi: de289a80   ebp:
e189e7a0   esp: d3d57f48
Mar 30 17:44:27 greg-port kernel: ds: 007b   es: 007b   ss: 0068
Mar 30 17:44:27 greg-port kernel: Process pppd (pid: 12530,
threadinfo=d3d56000 task=dbad0dc0)
Mar 30 17:44:27 greg-port kernel: Stack: e189c356 de75e400 00200286
d10c0d80 de289a80 00000000 dfde4240 df1e9b0c
Mar 30 17:44:27 greg-port kernel:        e1899081 de289a80 c9a76280
c014b3a0 df1e9b0c c9a76280 df1d8380 c9a76280
Mar 30 17:44:27 greg-port kernel:        00000000 d8c36080 d3d56000
c0149b9d c9a76280 d8c36080 d8c36080 c9a76280
Mar 30 17:44:27 greg-port kernel: Call Trace:
Mar 30 17:44:27 greg-port kernel:  [pg0+558187350/1069244416]
ppp_shutdown_interface+0x83/0xe5 [ppp_generic]
Mar 30 17:44:27 greg-port kernel:  [pg0+558174337/1069244416]
ppp_release+0x5f/0x61 [ppp_generic]
Mar 30 17:44:27 greg-port kernel:  [__fput+264/282] __fput+0x108/0x11a
Mar 30 17:44:27 greg-port kernel:  [filp_close+89/134] filp_close+0x59/0x86
Mar 30 17:44:27 greg-port kernel:  [sys_close+99/150] sys_close+0x63/0x96
Mar 30 17:44:27 greg-port kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 30 17:44:27 greg-port kernel:
Mar 30 17:44:27 greg-port kernel: Code: 0f 0b d7 0b 04 29 37 c0 eb de 2b
80 00 02 00 00 89 44 24 04


Thank you all for the good work with linux, keep up with it ! :)

-- 
Auzanneau Grégory
GPG 0x99137BEE

--------------enig1A975E61B4A003F21CE90C02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAaw+h3H6YHZkTe+4RAlbuAJ97mOwjG1CrVSGGWqQmFvBMQ2iScQCdGVU5
Tfk61Lc1Ddq0sV3CuXgGRQE=
=bLot
-----END PGP SIGNATURE-----

--------------enig1A975E61B4A003F21CE90C02--
