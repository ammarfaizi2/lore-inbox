Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVADUJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVADUJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVADUH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:07:59 -0500
Received: from grendel.firewall.com ([66.28.58.176]:8587 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S262100AbVADT4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:56:45 -0500
Date: Tue, 4 Jan 2005 20:56:36 +0100
From: Marek Habersack <grendel@caudium.net>
To: linux-kernel@vger.kernel.org
Subject: Very high load on P4 machines with 2.4.28
Message-ID: <20050104195636.GA23034@beowulf.thanes.org>
Reply-To: grendel@caudium.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

 We have several machines with similar configurations

0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (re=
v 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (re=
v 02)
0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Stora=
ge Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (r=
ev 02)
0000:02:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 2=
7)
0000:02:0a.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet Cont=
roller (Copper)
0000:02:0b.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet Cont=
roller (Copper)

and

0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM Con=
troller/Host-Hub Interface (rev 03)
0000:00:02.0 VGA compatible controller: Intel Corp. 82845G/GL[Brookdale-G]/=
GE Chipset Integrated Graphics Device (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridge (=
rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) UltraATA-=
100 IDE Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus =
Controller (rev 02)
0000:01:05.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Cont=
roller (rev 02)
0000:01:06.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Cont=
roller (rev 02)

equipped with 2.6Ghz P4 CPUs, 1Gb of ram, 2-4gb of swap, the kernel config
is attached. The machines have normal load averages hovering not higher than
7.0, depending on the time of the day etc. Two of the machines run 2.4.25,
one 2.4.27 and they work fine. When booted with 2.4.28, though (compiled
with Debian's gcc 2.3.5, with p3 or p4 CPU selected in the config), the load
is climbing very fast and hovers around a value 3-4 times higher than with
the older kernels. Booted back in the old kernel, the load comes to its
usual level. The logs suggest nothing, no errors, nothing unusual is
happening.=20

Has anyone had similar problems with 2.4.28 in an environment resembling the
above? Could it be a problem with highmem i/o?

tia,

marek

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2vT0q3909GIf5uoRAmBhAJ4hpWBaqm/Sq8duzmVuOe3pBlZ6KQCfW8W/
2ds6MkkgCaiukWh7DLAsZAg=
=D+FT
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
