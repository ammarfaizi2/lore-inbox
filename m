Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267148AbUBRWa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267202AbUBRWa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:30:56 -0500
Received: from [62.116.46.196] ([62.116.46.196]:42764 "EHLO it-loops.com")
	by vger.kernel.org with ESMTP id S267148AbUBRWaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:30:52 -0500
Date: Wed, 18 Feb 2004 23:29:32 +0100
From: Michael Guntsche <mike@it-loops.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3 Problems with firewire DVD-writer
Message-Id: <20040218232932.6b972907.mike@it-loops.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__18_Feb_2004_23_29_32_+0100_._Bg1LhtXjJ1aCQr"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__18_Feb_2004_23_29_32_+0100_._Bg1LhtXjJ1aCQr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi list,

Today I switched from 2.6.2 to 2.6.3 mostly for the new radeonfb driver.
Everything looked fine until I tried to burn a DVD with my external
DVD-writer (Plextor PX708UF), which worked without a problem in 2.6.2.


While trying to burn some files to it with growisofs I got the following
error message
and the program froze.

--- syslog ---

Feb 18 22:20:56 localhost kernel: SCSI error : <0 0 0 0> return code =
0x8000002
Feb 18 22:20:56 localhost kernel: Current sr0: sense = 70  4
Feb 18 22:20:56 localhost kernel: ASC=1b ASCQ= 0
Feb 18 22:20:56 localhost kernel: Raw sense data:0x70 0x00 0x04 0x00
0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x1b 0x00 0x00 0x00 0x00 0x00
<repeating>

--- syslog ---

Trying the same with USB 2.0 worked without a problem.

Looking through the changelog I saw that both the scsi and ieee1394
subsystem got several updates.

Can someone help me debug this further? Since the USB side seems to work
ok ( I tried it only once), I think that the problem lies between ieee1394 and scsi. 


Please CC: since I am not subscribed to the list.

Thanks in advance,
Michael

--Signature=_Wed__18_Feb_2004_23_29_32_+0100_._Bg1LhtXjJ1aCQr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAM+dP9lrUeNl8Hv8RAjbjAJ9Ea+OOEbfSgulvsrxP4RiMWUwDzgCgu+ZN
MzI/H5zF9OKkmtTb83q2c/s=
=r4j/
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Feb_2004_23_29_32_+0100_._Bg1LhtXjJ1aCQr--
