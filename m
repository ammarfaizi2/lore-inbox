Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbTBIKoc>; Sun, 9 Feb 2003 05:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbTBIKoc>; Sun, 9 Feb 2003 05:44:32 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:53390 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267196AbTBIKob> convert rfc822-to-8bit; Sun, 9 Feb 2003 05:44:31 -0500
From: Florian Schmitt <florian@galois.de>
To: linux-kernel@vger.kernel.org
Subject: routing oddity in 2.5.59-mm8
Date: Sun, 9 Feb 2003 11:53:41 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200302091154.13187.florian@galois.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

in 2.5.59-mm8 the routing table behaves a bit strange:

# > route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
rtsl-stgt-de01. *               255.255.255.255 UH    0      0        0 ppp0
192.168.1.0     *               255.255.255.0   U     0      0        0 eth0

In 2.5.59-linus an additional default route is shown. If I try to add my 
default route, I get:

# > route add -net 0.0.0.0 netmask 0.0.0.0 dev ppp0 gw 213.20.223.152
SIOCADDRT: File exists
# > route 
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
rtsl-stgt-de01. *               255.255.255.255 UH    0      0        0 ppp0
192.168.1.0     *               255.255.255.0   U     0      0        0 eth0

Nothing has changed. The route seems to be there (but invisible), because I 
can access other subnets through the gateway.

- --
Flo

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: You may find my public key at http://www.galois.de/florian.schmitt.pubkey.asc

iD8DBQE+RjNLH7Gei80C0lQRAqWEAKC4az6znXaYRL04UMX1NkfPP/5UQwCgqvcW
QeDgvLbRwHvERLD78qoK8vA=
=JSv7
-----END PGP SIGNATURE-----

