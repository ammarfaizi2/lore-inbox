Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271938AbTHHVbe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 17:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271939AbTHHVbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 17:31:34 -0400
Received: from host-2.server.itns.de ([213.179.64.8]:15757 "EHLO
	host-2.server.itns.de") by vger.kernel.org with ESMTP
	id S271938AbTHHVbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 17:31:33 -0400
Date: Fri, 8 Aug 2003 23:32:13 +0200
From: Andreas Romeyke <art1@it-netservice.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel 2.5:  mlock broken?
Message-Id: <20030808233213.4ffb2c84.art1@it-netservice.de>
Organization: free user
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.dGc_:3hsicZy(B"
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.dGc_:3hsicZy(B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi folks,

By testing 2.6.0-test2, I detected that the glibc-function mlock(),
provided by /sys/mlock.h seems to be a deadlock in some cases on 2.5

If you want to lock more memory than physical RAM could be freed, the
mlock() does not return with an errorcode as under 2.4.21 does.
The system hangs around. This problem was catched under x86 and s390
architecture by using Debian distribution (woody and unstable) and
others  with the well known memtest program written by Charles Cazabon
from   http://www.qcc.ca/~charlesc/software/memtester/ (ver. 2.93.1).

IMHO the problem is effected in kernel  mm/mlock.c, ev. in do_mlock(),
because glibc was not changed between different kernelversions. The
glibc version was 2.3.1-17

Hope it helps.

Bye Andreas

PS.:If you think this report is not related to this list, please contact
me per private email.
PPS.: If you need further information, contact me too.

-- 

--=.dGc_:3hsicZy(B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/NBbk4xsrIFwuA1ERAhECAKDKOSCyt5FbmCb4COASyiQGQxYL+QCfTBsh
K3pffpzuHx3H/HBNcuU0Q7Y=
=Vn5f
-----END PGP SIGNATURE-----

--=.dGc_:3hsicZy(B--
