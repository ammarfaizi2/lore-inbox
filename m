Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbVDBAUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbVDBAUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVDBASu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:18:50 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:35725 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S262955AbVDBAMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 19:12:55 -0500
Subject: Re: [Pcihpd-discuss] RE: [RFC/Patch 0/12] ACPI based root bridge
	hot-add
From: Tom Duffy <tduffy@sun.com>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Prasad Singamsetty <Prasad.Singamsetty@sun.com>, tony.luck@intel.com,
       pcihpd-discuss@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, dely.l.sy@intel.com, akpm@osdl.org, gregkh@suse.de,
       Dely Sy <dlsy@snoqualmie.dp.intel.com>
In-Reply-To: <20050331140304.C21596@unix-os.sc.intel.com>
References: <200503230313.j2N3DYpE010786@snoqualmie.dp.intel.com>
	 <1111618996.12700.44.camel@duffman>
	 <20050331140304.C21596@unix-os.sc.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YRzS5cHaYPtwx5+WaR2F"
Date: Fri, 01 Apr 2005 16:10:59 -0800
Message-Id: <1112400659.8432.15.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YRzS5cHaYPtwx5+WaR2F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-31 at 14:03 -0800, Rajesh Shah wrote:
> Does this patch help?

YES!  I can now power down the slot, see it gone from pci list, reenable
it, etc.  Awesome.  Thank you.

[root@intlhotp-1 ~]# lspci -s 08:00
08:00.0 Ethernet controller: Intel Corp.: Unknown device 105f (rev 03)
08:00.1 Ethernet controller: Intel Corp.: Unknown device 105f (rev 03)
[root@intlhotp-1 ~]# cd /sys/bus/pci/slots/4/
[root@intlhotp-1 4]# cat power
1
[root@intlhotp-1 4]# echo 0 > power
[root@intlhotp-1 4]# lspci -s 08:00
[root@intlhotp-1 4]# cat power
0
[root@intlhotp-1 4]# echo 1 > power
[root@intlhotp-1 4]# lspci -s 08:00
08:00.0 Ethernet controller: Intel Corp.: Unknown device 105f (rev 03)
08:00.1 Ethernet controller: Intel Corp.: Unknown device 105f (rev 03)


--=-YRzS5cHaYPtwx5+WaR2F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCTeMTdY502zjzwbwRArapAKCdezcFJEdFzV929zIR4ovUNZTWTACcCeP0
DHCAyFHjtBfPxTM6Xix8Ahk=
=3Iu1
-----END PGP SIGNATURE-----

--=-YRzS5cHaYPtwx5+WaR2F--
