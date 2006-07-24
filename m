Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWGXTQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWGXTQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 15:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWGXTQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 15:16:44 -0400
Received: from mail.gmx.net ([213.165.64.21]:28304 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751350AbWGXTQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 15:16:43 -0400
X-Authenticated: #5082238
Date: Mon, 24 Jul 2006 21:15:40 +0200
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: NFS errors
Message-ID: <20060724191540.GD19902@server.c-otto.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

My computer uses another server to boot and run with NFS root.
During normal work I notice strange NFS errors.
Please tell me what causes these errors and how I can resolve them.

Example 1:
I executed these commands directly after another.

cotto@carsten-otto:/home/cotto/.mozilla/firefox$ l
ls: .: Permission denied
cotto@carsten-otto:/home/cotto/.mozilla/firefox$ l
total 8.0K
drwx------ 6 cotto users 4.0K Jul 24 21:03 eir51v0r.default
?--------- ? ?     ?        ?            ? la2v5nug.default
?--------- ? ?     ?        ?            ? pluginreg.dat
-rw-r--r-- 1 cotto users   94 Jul 24 21:03 profiles.ini
?--------- ? ?     ?        ?            ? v1q37ws3.default
cotto@carsten-otto:/home/cotto/.mozilla/firefox$ l
total 20K
drwx------ 6 cotto users 4.0K Jul 24 21:03 eir51v0r.default
drwx------ 3 cotto users 4.0K Jul 24 21:03 la2v5nug.default
-rw------- 1 cotto users  286 Jul 24 20:57 pluginreg.dat
-rw-r--r-- 1 cotto users   94 Jul 24 21:03 profiles.ini
drwx------ 6 cotto users 4.0K Jul 24 21:04 v1q37ws3.default

Example 2:
GAIM shows "Could not read file: somewhere.txt" when scrolling through
the list of archived conversations.

Example 3:
Firefox crashes a lot during normal surfing, sometimes even the profile
gets lost.

Example 4:
I get a lot of "do_vfs_lock: VFS is out of sync with lock manager!"
during the day.

Example 5:
Some ./configure && make runs do not complete, because files are
missing. Running the command in a chroot locally on the server (which
has the disk drives) everything works.

The client (without disk drives) uses 2.6.17.6, but I have this problem
with several kernel versions.
The kernel is running 2.6.18-rc1-mm2, but here again the problem occurs
with several versions.
The client runs Debian testing, the server runs Debian stable (Sarge).
The network connection in between is:
(Client) Intel e1000 PCI <-> HP Procurve 2824 (Gigabit) <-> Intel e1000 PCI=
e (Server)

x:~# rpcinfo -p server
   Program Vers Proto   Port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100003    2   udp   2049  nfs
    100003    3   udp   2049  nfs
    100003    4   udp   2049  nfs
    100003    2   tcp   2049  nfs
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100021    1   udp  32768  nlockmgr
    100021    3   udp  32768  nlockmgr
    100021    4   udp  32768  nlockmgr
    100021    1   tcp  43642  nlockmgr
    100021    3   tcp  43642  nlockmgr
    100021    4   tcp  43642  nlockmgr
    100005    1   udp    779  mountd
    100005    1   tcp    782  mountd
    100005    2   udp    779  mountd
    100005    2   tcp    782  mountd
    100005    3   udp    779  mountd
    100005    3   tcp    782  mountd
    100024    1   udp    877  status
    100024    1   tcp    880  status

I enabled nfs4 in the kernels, but do not use it yet
(as a lot of changes are needed in userspace).

mount shows:
server:/export on / type nfs (rw,soft,tcp,intr)

Thanks a lot,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFExRxcjUF4jpCSQBQRAkjyAKCXTZmU39YwQxg88zFKMXH+JfbauACfbXXa
CJkV91NibjI+cvZBFGYr6ds=
=2+sJ
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
