Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTH3ArK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 20:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTH3AqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 20:46:21 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22152 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262188AbTH3AqQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 20:46:16 -0400
Message-Id: <200308300046.h7U0k8m8011982@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: don fisher <dfisher@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to choose between ip 2 identical ethernet cards 
In-Reply-To: Your message of "Fri, 29 Aug 2003 17:29:29 PDT."
             <3F4FEFE9.4050704@as.arizona.edu> 
From: Valdis.Kletnieks@vt.edu
References: <3F4FEFE9.4050704@as.arizona.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1616740185P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Aug 2003 20:46:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1616740185P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <11969.1062204360.1@turing-police.cc.vt.edu>

On Fri, 29 Aug 2003 17:29:29 PDT, don fisher <dfisher@as.arizona.edu>  said:

> I have tried changing the order of loading modules, along with a few 
> vain attempts in modules.conf. For info, this is a Redhat system. 
> Where is the definition as to which device will be associated with 
> eth0 made?

'man nameif'

Works great, less filling - my Dell 840 has up to *4* ethernets (the onboard
built-in, the dock, the built-in wireless, and a Xircom card that's a combo
56k modem/100BaseT).

My /etc/mactab looks like this:

# Onboard 10/100 port
eth0 00:06:5b:b9:5e:27
# 10/100 port on Xircom 10/100/56K card
eth2 00:10:a4:9c:a8:86
# wireless card
wvlan0 00:02:2d:5c:11:48
eth1 00:02:2d:5c:11:48
# 10/100 port on dock...
eth3 00:06:5b:ea:8e:4e

(yes, there's 2 entries for the wireless - 2.4 kernel wants wvlanX, 2.6 calls it ethX.

The magic under a RedHat system happens in:

/etc/sysconfig/network-scripts/ifup

Hope that helps.




--==_Exmh_-1616740185P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/T/PPcC3lWbTT17ARAgwbAKDgk/pGGzQWhO6nKX0NGmww7IlXeQCgpPd3
WzfJeyRRNK59KW+QCeSTYKo=
=LSA/
-----END PGP SIGNATURE-----

--==_Exmh_-1616740185P--
