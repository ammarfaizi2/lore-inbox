Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSKXODP>; Sun, 24 Nov 2002 09:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSKXODP>; Sun, 24 Nov 2002 09:03:15 -0500
Received: from diale043.ppp.lrz-muenchen.de ([129.187.28.43]:59101 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261305AbSKXODO>; Sun, 24 Nov 2002 09:03:14 -0500
Subject: Re: Bug with netfilter and NFS server on same machine
From: Daniel Egger <degger@fhm.edu>
To: Lars Knudsen <gandalfit@virgilio.it>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3DDFCAEE.7090705@virgilio.it>
References: <3DDFCAEE.7090705@virgilio.it>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-WWk1XK1FuAGaV7KIjM6G"
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Nov 2002 15:10:18 +0100
Message-Id: <1038147021.31189.10.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WWk1XK1FuAGaV7KIjM6G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, 2002-11-23 um 19.37 schrieb Lars Knudsen:

> The problem is this: A machine running linux 2.4.18 or 2.4.19 works just=20
> fine when running just the kernel nfsd. A single client connected to the=20
> server with 100Mbit ethernet sees throughput of 5-10MByte/sec even after=20
> an hour or two of continous transfers. If the nfs server is also running=20
> iptables the throughput is initially the same (5-10MByte/sec) but after=20
> a while (200MByte-500MByte total transfer) the client starts reporting=20
> "nfs server not responding" followed after a while by "nfs server OK"=20
> and of course the transfer rate goes way down (< 1MByte/sec). Using=20
> tcpdump on the client seems to indicate that some packets have their=20
> headers garbled - wrong fragment ids being the typical error.

Linux nicole 2.4.19-586tsc #1 Sun Oct 6 18:00:21 EST 2002 i586 unknown unkn=
own GNU/Linux

egger@nicole:~$ sudo lsmod
Module                  Size  Used by    Not tainted
ipt_TOS                 1016  12  (autoclean)
ipt_MASQUERADE          1176   1  (autoclean)
ipt_REDIRECT             728   1  (autoclean)
ipt_REJECT              2776   4  (autoclean)
ipt_LOG                 3160   6  (autoclean)
ipt_state                568  55  (autoclean)
iptable_mangle          2100   1  (autoclean)
ip_nat_irc              2288   0  (unused)
ip_nat_ftp              2960   0  (unused)
iptable_nat            13208   3  [ipt_MASQUERADE ipt_REDIRECT ip_nat_irc i=
p_nat_ftp]
ip_conntrack_irc        2464   0  (unused)
ip_conntrack_ftp        3200   0  (unused)
ip_conntrack           13148   4  [ipt_MASQUERADE ipt_REDIRECT ipt_state ip=
_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_ftp]
iptable_filter          1672   1  (autoclean)
ip_tables              10488  11  [ipt_TOS ipt_MASQUERADE ipt_REDIRECT ipt_=
REJECT ipt_LOG ipt_state iptable_mangle iptable_nat iptable_filter]
nfsd                   65616   5  (autoclean)
lockd                  46864   1  (autoclean) [nfsd]
sunrpc                 57436   1  (autoclean) [nfsd lockd]
af_packet              11656   1  (autoclean)

00:12.0 Ethernet controller: D-Link System Inc Sundance Ethernet
        Subsystem: D-Link System Inc Sundance Ethernet
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at d800 [size=3D128]
        Memory at e2810000 (32-bit, non-prefetchable) [size=3D128]
        Expansion ROM at e1000000 [disabled] [size=3D64K]
        Capabilities: <available only to root>

No problems with NFS whatsoever. Gigabytes of traffic get from or to
this machine without any lag. The firewall is rather restricted to the
inside and NFS nailed to fixed ports.

--=20
Servus,
       Daniel

--=-WWk1XK1FuAGaV7KIjM6G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA94N3Jchlzsq9KoIYRAqEsAJ0acrCRL+9saiw4pqhOUPFomkZG8gCgvEm/
YWj++DMh0fo0QyDWUiXfjiI=
=GWOf
-----END PGP SIGNATURE-----

--=-WWk1XK1FuAGaV7KIjM6G--

