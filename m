Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUIBSQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUIBSQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUIBSQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:16:08 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:57291 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267362AbUIBSPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:15:54 -0400
Message-Id: <200409021815.i82IFpLT022145@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm2 - 'journal block not found' - ext3 on crack?
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_729735924P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Sep 2004 14:15:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_729735924P
Content-Type: text/plain; charset=us-ascii

I built 2.6.9-rc1-mm2 last night, and I've had this happen on 2 separate file systems today:

Sep  2 12:42:50 turing-police kernel: journal_bmap: journal block not found at offset 2316 on dm-6
Sep  2 12:42:52 turing-police kernel: Aborting journal on device dm-6.
Sep  2 12:42:52 turing-police kernel: ext3_abort called.
Sep  2 12:42:53 turing-police kernel: EXT3-fs error (device dm-6): ext3_journal_start: Detected aborted journal
Sep  2 12:42:53 turing-police kernel: Remounting filesystem read-only
Sep  2 12:42:54 turing-police kernel: EXT3-fs error (device dm-6) in start_transaction: Journal has aborted
Sep  2 12:42:54 turing-police kernel: EXT3-fs error (device dm-6) in start_transaction: Journal has aborted
Sep  2 12:42:54 turing-police kernel: journal commit I/O error
Sep  2 12:42:54 turing-police kernel: EXT3-fs error (device dm-6) in start_transaction: Journal has aborted
Sep  2 12:42:57 turing-police last message repeated 15 times

(This one was /home - I'd paste the other one, but it happened on /var so
it didn't get logged because /var/adm/messages went R/O..)

Of interest:

1) Didn't see this under 2.6.8-mm4.
2) Neither time had any actual disk I/O error messages...
3) I'm using ext3-on-LVM, if that matters...

--==_Exmh_729735924P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBN2NWcC3lWbTT17ARAiTfAKCuHIikl1mmd76Lb5G1gXM4mXuO+gCg/v5e
tujcDUzfO+HAIN1gXSXo18w=
=flLa
-----END PGP SIGNATURE-----

--==_Exmh_729735924P--
