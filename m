Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbTEMNnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbTEMNnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:43:20 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:12039 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261227AbTEMNnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:43:17 -0400
Date: Tue, 13 May 2003 15:51:50 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode values in file system driver
Message-ID: <20030513135150.GA1049@arthur.home>
References: <200305102118.20318.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <200305102118.20318.adrian@mcmen.demon.co.uk>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2003 at 09:18:20PM +0100, Adrian McMenamin wrote:
> Am I allowed to assign the value 0 to an inode in a file system driver? I=
 seem=20
> to be having problems with a file that is being assigned this inode value=
=20
> (its a FAT based filesystem so the inode values are totally artificial).

Yes, you are. However, glibc thinks that inode 0 is special and won't
show it.

Example: mount an NTFS filesystem with -o show_sys_files and do ls on
the mountpoint. You won't see the file $MFT, but it is there when you
copy it: cp /mountpoint/\$MFT /tmp .

Yes, this is a bug in glibc.


Erik

--=20
Erik Mouw
J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+wPh2/PlVHJtIto0RAvGvAJ90nQlorRfZcXTO2Ln0YWuAbwvnzACfdEG1
2qsGueiHmtzMaUkwqb54LK8=
=Ajht
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
