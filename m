Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUBERDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUBERDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:03:25 -0500
Received: from 1002-19.lowesthosting.com ([216.127.84.7]:23963 "HELO
	1002-19.lowesthosting.com") by vger.kernel.org with SMTP
	id S266311AbUBERC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:02:58 -0500
Date: Thu, 5 Feb 2004 11:02:20 -0600
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Cc: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Subject: Re:
Message-Id: <20040205110220.454ee909.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <7A25937D23A1E64C8E93CB4A50509C2A0310F099@stca204a.bus.sc.rolm.com>
References: <7A25937D23A1E64C8E93CB4A50509C2A0310F099@stca204a.bus.sc.rolm.com>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__5_Feb_2004_11_02_20_-0600_gO9JQwOQ7HxlQIs2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__5_Feb_2004_11_02_20_-0600_gO9JQwOQ7HxlQIs2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Uttered "Bloch, Jack" <Jack.Bloch@icn.siemens.com>, spake thus:

Please do not include me in the CC: list as I belong to this mailing
list.

Do not reply privately to this message, keep it all out in the open ;-)

> It is not really a device, simply a file loaded into memory by another
> process at a fixed location.

Userland processes _do_ have resource limits.  Try a "man getrlimit"
for some hints here.

There is a max process size limit (RLIMIT_DATA) and the number of VM
pages kept in RAM (RLIMIT_RSS).

Keep in mind that a child processes usually inherits whatever rlimits
are left unused by the parent process, so if your program is being
started from another program near its limits, the child process
begins with those limitations as well.

1)  Can a standalone test program, started from the shell, map the
    data?

2)  How was the kernel memory used to hold the data obtained?

--Signature=_Thu__5_Feb_2004_11_02_20_-0600_gO9JQwOQ7HxlQIs2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAIncg8HSaBDCaXBoRAoZ9AKCyW6+b+b/U8EsFdwTl19OaHvJ9ywCfV1tH
7rcJDEjkQhgSN9vJJC7UB6A=
=xiQV
-----END PGP SIGNATURE-----

--Signature=_Thu__5_Feb_2004_11_02_20_-0600_gO9JQwOQ7HxlQIs2--
