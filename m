Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVHLUgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVHLUgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 16:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVHLUgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 16:36:03 -0400
Received: from svana.org ([203.20.62.76]:21517 "EHLO svana.org")
	by vger.kernel.org with ESMTP id S1750810AbVHLUgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 16:36:02 -0400
Date: Fri, 12 Aug 2005 22:35:57 +0200
From: Martijn van Oosterhout <kleptog@svana.org>
To: KrnlUsr <kdp102@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: copy_from_user, copy_to_user in kernel
Message-ID: <20050812203552.GG4305@svana.org>
Reply-To: Martijn van Oosterhout <kleptog@svana.org>
References: <20050812181623.6814.qmail@web80214.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Content-Disposition: inline
In-Reply-To: <20050812181623.6814.qmail@web80214.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
X-PGP-Key-ID: Length=1024; ID=0x0DC67BE6
X-PGP-Key-Fingerprint: 295F A899 A81A 156D B522  48A7 6394 F08A 0DC6 7BE6
X-PGP-Key-URL: <http://svana.org/kleptog/0DC67BE6.pgp.asc>
X-Warning: Normally my messages are signed, but not on the ozTiVo list due to legacy application support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2005 at 11:16:23AM -0700, KrnlUsr wrote:
> Hi
>=20
> Why does copy_from/to_user routines fail if both
> source and destination are in kernel space. I have a
> kernel module that:

I had this problem when writing a kernel module that was using a UDP
socket to send and receive stuff. It would work fine in UML but fail in
the real kernel. I never worked it out but someone later patched it by
using the [gs]et_[df]s() functions. If you grep the kernel source you
can see a lot of places use it. The problem is I still have no idea why
it works...

Hope this helps,
--=20
Martijn van Oosterhout   <kleptog@svana.org>   http://svana.org/kleptog/
> Patent. n. Genius is 5% inspiration and 95% perspiration. A patent is a
> tool for doing 5% of the work and then sitting around waiting for someone
> else to do the other 95% so you can sue them.

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQFC/QgnIB7bNG8LQkwRAtcpAJ9m0jxnZLSwDrkJmjESa+Cpub6BYgCggZK5
mvWuPBZuPuS/XN8ac9mrnoM=
=49Qt
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--
