Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272947AbTG3Pxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272948AbTG3Pxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:53:49 -0400
Received: from [24.241.190.29] ([24.241.190.29]:17047 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S272947AbTG3Pxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:53:47 -0400
Date: Wed, 30 Jul 2003 11:53:45 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: devfs rescanning?
Message-ID: <20030730155345.GK786@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah9ph+G2cWRpKogL"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ah9ph+G2cWRpKogL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I have a system with 4 SCA drives.  Originally they were:

/dev/sda -> scsi/host0/bus0/target0/lun0/disc
/dev/sdb -> scsi/host0/bus0/target1/lun0/disc
/dev/sdc -> scsi/host1/bus0/target0/lun0/disc
/dev/sdd -> scsi/host1/bus0/target1/lun0/disc

SDA drive was hot-pulled to test the raid failover and it worked great.
Next the box was rebooted after the drive was replaced (these systems
can hang or go real stupid when a drive is pulled).  The drives remapped
as was expected.  When it came back up the sd? entries had shifted up 1
as expected

/dev/sda -> scsi/host0/bus0/target1/lun0/disc
/dev/sdb -> scsi/host1/bus0/target0/lun0/disc
/dev/sdc -> scsi/host1/bus0/target1/lun0/disc

and when the drive was put back in it came up as sdd.  Other than a
reboot is there any known way to get the drives back in the proper
order?  Killing devfsd, removing the entries and restarting, etc didn't
do any good.

Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--Ah9ph+G2cWRpKogL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/J+oJ8+1vMONE2jsRAougAJwNDrXYKiytC4LeSVFRJqUJuWZXrgCgp2Zf
s8xDsEkIN2siqPiKKZHbjQM=
=MIyx
-----END PGP SIGNATURE-----

--Ah9ph+G2cWRpKogL--
