Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbTDGGmF (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 02:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTDGGmF (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 02:42:05 -0400
Received: from smtp-out.comcast.net ([24.153.64.110]:19153 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263186AbTDGGmC (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 02:42:02 -0400
Date: Mon, 07 Apr 2003 02:53:32 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: orinoco_cs under load
To: linux-kernel@vger.kernel.org
Message-id: <20030407065332.GA24606@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary="bp/iNruPH9dso1Pn";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

when my hawking tech 802.11b card gets heavily loaded (tar | bzip2 >
nfs_file) i see these errors repeated at a very high rate:
---
Apr  7 02:41:01 density kernel: eth0: Information frame lost.
Apr  7 02:41:01 density kernel: eth0: Information frame lost.
Apr  7 02:41:01 density kernel: eth0: Information frame lost.
Apr  7 02:41:01 density kernel: eth0: Information frame lost.
Apr  7 02:41:01 density kernel: eth0: Information frame lost.
Apr  7 02:41:01 density kernel: eth0: Information frame lost.
Apr  7 02:41:01 density kernel: eth0: Information frame lost.
Apr  7 02:41:01 density kernel: eth0: Information frame lost.
Apr  7 02:41:01 density kernel: eth0: Information frame lost.
---
then it eventually, in this case after 40 minutes, turns to repeating
this at a slower rate:
---
Apr  7 02:41:03 density kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Apr  7 02:41:03 density kernel: eth0: Tx timeout! ALLOCFID=3D0123,
TXCOMPLFID=3D0179, EVSTAT=3Da00a
Apr  7 02:41:03 density kernel: eth0: orinoco_reset()
Apr  7 02:41:04 density kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Apr  7 02:41:04 density kernel: eth0: Tx timeout! ALLOCFID=3D0000,
TXCOMPLFID=3D0000, EVSTAT=3D0000
Apr  7 02:41:05 density kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Apr  7 02:41:05 density kernel: eth0: Tx timeout! ALLOCFID=3D0000,
TXCOMPLFID=3D0000, EVSTAT=3D0000
Apr  7 02:41:06 density kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Apr  7 02:41:06 density kernel: eth0: Tx timeout! ALLOCFID=3D0000,
TXCOMPLFID=3D0000, EVSTAT=3D0000
---
once this is scrolling, the keyboard ceases to respond.  the mouse
works in x, and i can close things, but i can't type or switch vt's.
alt-sysrq does work though.

i've probably been seeing this behavior since the 2.5.5x kernels, but=20
that's probably when i got the wireless card.

this report is from the 2.5.66 kernel, but it looks the same as
earlier kernels.  i'm using the orinoco_cs module on debian unstable
on my dell inspiron 3800.

i have not been able to reproduce the error with processes other than
my tar | bzip2 > (nfs-mounted-file).

thanks.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+kSBsCGPRljI8080RAqjBAKCEBXuNB45K2XzQYJ5J1ET+sP6leQCeP9pw
QKpO65ub6fZYRRjojP7fVS8=
=EWSH
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
