Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWHBUVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWHBUVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWHBUVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:21:19 -0400
Received: from mail.isohunt.com ([69.64.61.20]:18146 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S932218AbWHBUVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:21:18 -0400
X-Spam-Check-By: mail.isohunt.com
Date: Wed, 2 Aug 2006 13:20:02 -0700
From: "Robin H. Johnson" <robbat2@orbis-terrarum.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17.7 leading to doubling system CPU usage?
Message-ID: <20060802202002.GH31144@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Please CC on responses, I'm not subscribed to LKML).

Short problem summary:=20
Between 2.6.17.4 and 2.6.17.7, SYS cpu usage doubled.

In short, before the upgrade, our DB cpu usage breakdown was:
		SYS	USER NICE IDLE IOWAIT IRQ SOFTIRQ
BEFORE  28% 71%  0%   80%  15%    1%  5%=20
AFTER   57% 93%  0%   41%  0%     1%  7%
(See the graphs for more detail.  http://isohunt.com/img/stuff/munin-captur=
e/db.isohunt.com-cpu.html)

Notice the big jump in SYS. USER is up a little as well.

IOWAIT should be ignored as we did a RAM upgrade to try and alleviate
some of the work on this box.

The userspace load on this box doesn't vary by more than 10% when
examined at the same time each day.

Here is a complete snapshot set of graphs for the machine in question:
http://isohunt.com/img/stuff/munin-capture/db.isohunt.com.html

Other misc answers before they get asked of me:
- The motherboard used is the Tyan S2881.
- There are two reboots in the graph timeline. The first on 29th was for
  the upgrade to 2.6.17.7. The second reboot was on the 31st, was the
  RAM being doubled.

Kernel config:
http://isohunt.com/img/stuff/munin-capture/kernel-config-2.6.17.7
http://isohunt.com/img/stuff/munin-capture/kernel-config-2.6.17.4
(oldconfig on .7 added CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy).

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFE0QjyPpIsIjIzwiwRAop2AKCCIIHcBYOrjso+uRwyMQhbq5kqrgCg4liy
j2lohAYcksBX1zaRWTWQf1g=
=YN6M
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
