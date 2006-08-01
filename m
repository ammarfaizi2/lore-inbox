Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWHASRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWHASRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWHASRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:17:08 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:15316 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751758AbWHASRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:17:06 -0400
Message-ID: <44CF9A23.9090409@t-online.de>
Date: Tue, 01 Aug 2006 20:14:59 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060714)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <44CF7E5A.2010903@gmail.com>
In-Reply-To: <44CF7E5A.2010903@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1A984B9BDC59A972C6DDBFD4"
X-ID: Ekyj+ZZr8e+uemtwrjAbbrCrp8lXx7M9ZIPptcEbyEobPjYYRTzJEI
X-TOI-MSGID: 051197c5-be9f-4e30-92f6-065a575a38b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A984B9BDC59A972C6DDBFD4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tejun Heo wrote:
>=20
> Can you try the following instead of hdparm?
>=20
> echo 1 > /sys/bus/scsi/devices/1:0:0:0/power/state
>=20
> It will make libata involved in putting the disk to sleep and waking it=

> up, and, when waking, it will kick the drive in the ass by resetting th=
e
> channel.  Please try with the latest -rc kernel.
>=20

Sorry to say, but this did not work:

# echo 1 > /sys/bus/scsi/devices/0:0:0:0/power/state
bash: echo: write error: Invalid argument
# ll !$
ll /sys/bus/scsi/devices/0:0:0:0/power/state
-rw-r--r-- 1 root root 0 Aug  1 20:00 /sys/bus/scsi/devices/0:0:0:0/power=
/state
# cat !$
cat /sys/bus/scsi/devices/0:0:0:0/power/state
0
# uname -a
Linux bugs 2.6.18-rc3 #2 PREEMPT Sun Jul 30 16:26:22 CEST 2006 i686 GNU/L=
inux


Regards

Harri



--------------enig1A984B9BDC59A972C6DDBFD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEz5qaUTlbRTxpHjcRAnwSAJsEw1OAqTlCpf1LWSnI2MCo4RkgNQCggEUa
OSi6nnQVgPkoxorflu1oyD8=
=CyOR
-----END PGP SIGNATURE-----

--------------enig1A984B9BDC59A972C6DDBFD4--
