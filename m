Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWCAXX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWCAXX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWCAXX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:23:58 -0500
Received: from mail.goelsen.net ([195.202.170.130]:7331 "EHLO
	power2u.goelsen.net") by vger.kernel.org with ESMTP
	id S1751325AbWCAXX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:23:57 -0500
From: Michael Monnerie <m.monnerie@zmi.at>
Organization: it-management http://zmi.at
To: linux-kernel@vger.kernel.org
Subject: forcedeth driver on Asus A8N-E hangs
Date: Thu, 2 Mar 2006 00:23:43 +0100
User-Agent: KMail/1.9.1
Cc: manfred@colorfullife.com, suse-linux-e@suse.com
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1340307.aQkWSuIecb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603020023.43763@zmi.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1340307.aQkWSuIecb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello, I apologize I'm not a developer, but want to try helping in=20
fixing a bug with the forcedeth driver. I use SUSE 10.0 with all=20
updates and actual kernel 2.6.13-15.8 as provided from SUSE (just self=20
compiled to optimize for Athlon64, SMP, and HZ=3D100), with an Asus A8N-E=20
motherboard, and an Athlon64x2 CPU. The onboard network card is this:
00:0a.0 Class 0680: 10de:0057 (rev a3)

00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Flags: 66MHz, fast devsel, IRQ 50
        Memory at 00000000d3000000 (32-bit, non-prefetchable) [size=3D4K]
        I/O ports at b000 [size=3D8]
        Capabilities: [44] Power Management version 2

and the problem is that it hangs and stops working when there is a=20
higher load. Even before that, there seems to be a disturbance, as I/O=20
was quite slow: Linux server, Apple client: FTP/NFS, etc all slow.
I put a Realtek8169 into the system and now it works perfect, so its=20
obviously a driver bug, as I have the same hardware in another place=20
showing the same behaviour (works on very low load, stops when really=20
used).

Is there a workaround?

Output from the kernel source script "sh scripts/ver_linux":

Linux baum 2.6.13-15.8-ZMI #1 SMP Tue Feb 28 16:07:49 CET 2006 x86_64=20
x86_64 x86_64 GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.91.0.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.2-pre8
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.6.36
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      6.0.6
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   068
Modules Loaded         vmnet vmmon joydev af_packet iptable_filter=20
ip_tables button battery ac ipv6 ide_cd cdrom sundance mii shpchp=20
pci_hotplug generic ehci_hcd i2c_nforce2 ohci_hcd usbcore i2c_core=20
dm_mod reiserfs raid1 fan thermal processor sg sata_nv libata amd74xx=20
sd_mod scsi_mod ide_disk ide_core
=2D-=20
// Michael Monnerie, Ing.BSc  ---   it-management Michael Monnerie
// http://zmi.at           Tel: 0660/4156531          Linux 2.6.11
// PGP Key:   "lynx -source http://zmi.at/zmi2.asc | gpg --import"
// Fingerprint: EB93 ED8A 1DCD BB6C F952  F7F4 3911 B933 7054 5879
// Keyserver: www.keyserver.net                 Key-ID: 0x70545879

--nextPart1340307.aQkWSuIecb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEBiz/ORG5M3BUWHkRAgsLAJ4+bhu2dw/5TOBon4seCMpSAZ7BewCgpHLV
go9EsXZiGYlRkn6WpcMdyMk=
=jAiF
-----END PGP SIGNATURE-----

--nextPart1340307.aQkWSuIecb--
