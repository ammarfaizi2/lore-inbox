Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVEQRaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVEQRaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVEQR3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:29:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49935 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261827AbVEQR0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:26:02 -0400
Message-Id: <200505171725.j4HHPnJ1021224@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Kirill Korotaev <dev@sw.ru>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI) 
In-Reply-To: Your message of "Tue, 17 May 2005 11:04:55 +0400."
             <42899797.2090702@sw.ru> 
From: Valdis.Kletnieks@vt.edu
References: <42822B5F.8040901@sw.ru> <768860000.1116282855@flay>
            <42899797.2090702@sw.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116350744_5349P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 May 2005 13:25:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116350744_5349P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 May 2005 11:04:55 +0400, Kirill Korotaev said:

> BTW, why NMI watchdog is disabled by default? We constantly making it on 
> by default in our kernels and had no problems with it.
> I send a patch attached which tunes NMI watchdog by config option...

If you know how to get this to work on a Dell C840 laptop, please clue me in.
As far as I can tell, this requires a working LAPIC. If I boot without 'lapic',
no setting of nmi_watchdog increments the NMI counts in /proc/interrupts.
If I boot with 'lapic', nmi_watchdog=0 or 1 don't do anything, and 2 causes
a system hang during very early userspace (we don't live long enough to
get out of the initrd).

(Yes, I'm running the latest Dell BIOS (A13, 2/14/2004) on it.)

So if your patch was applied, my machine would hang at boot for no obvious
reason.  Not something we want to do to users by default.  All boxes will
boot with the NMI Watchdog turned off by default, so that's the *correct* default.

--==_Exmh_1116350744_5349P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCiikXcC3lWbTT17ARApXxAKCUSxbqezOhxl3old2IJworzavRgQCg4vFF
k8GlWRmdxCW1gNdSXx4LRWs=
=dbrW
-----END PGP SIGNATURE-----

--==_Exmh_1116350744_5349P--
