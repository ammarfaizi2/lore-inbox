Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTIXSVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 14:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTIXSVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 14:21:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:59776 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261595AbTIXSVf (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 14:21:35 -0400
Message-Id: <200309241821.h8OIL9P8003386@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Matt Heler <lkml@lpbproductions.com>,
       Scott Robert Ladd <coyote@coyotegulch.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minimizing the Kernel 
In-Reply-To: Your message of "Wed, 24 Sep 2003 19:13:28 +0200."
             <Pine.LNX.4.51.0309241912480.9178@dns.toxicfilms.tv> 
From: Valdis.Kletnieks@vt.edu
References: <3F71C712.9070503@coyotegulch.com> <200309240939.02316.lkml@lpbproductions.com>
            <Pine.LNX.4.51.0309241912480.9178@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1135540172P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 24 Sep 2003 14:21:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1135540172P
Content-Type: text/plain; charset=us-ascii

On Wed, 24 Sep 2003 19:13:28 +0200, Maciej Soltysiak said:
> > Well for starters dont use gcc 3 or above.. code size has increased
> > dramatically with thoose versions. sure they give you more optimization
> Hmm, has anyone tried -Os with gcc3+ ?
> Maybe that'd be good for size optimization?

I've usually been compiling with -Os on gcc3 for a while, works for me.

% size */vmlinux
   text    data     bss     dec     hex filename
3034134  620847  224824 3879805  3b337d linux-2.6.0-test4-mm6/vmlinux
3476451  621246  227512 4325209  41ff59 linux-2.6.0-test5-mm2/vmlinux
3034632  622210  226360 3883202  3b40c2 linux-2.6.0-test5-mm3/vmlinux
3037706  623409  226360 3887475  3b5173 linux-2.6.0-test5-mm4/vmlinux

-mm6, -mm3, and -mm4 were compiled with -Os, -mm2 with -O2.  All with gcc 3.3.1
from RedHat Rawhide.  Given how close -mm6, -mm3, and -mm4 are in size, the 12%
or so size saving is almost certainly the efects of -Os rather than changes in
the size of the code.  I could rebuild any of them to get an exact number, but
it would take a while on this laptop....


--==_Exmh_-1135540172P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ceCVcC3lWbTT17ARAskGAKCbbcnIqE63/G/2GX0wI4UQ5juCuQCfU2oL
PgiW/Iq+lno2UX/ntSEbpJk=
=ffF+
-----END PGP SIGNATURE-----

--==_Exmh_-1135540172P--
