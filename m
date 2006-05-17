Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWEQQ3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWEQQ3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 12:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWEQQ3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 12:29:38 -0400
Received: from pool-71-254-71-216.ronkva.east.verizon.net ([71.254.71.216]:62148
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750767AbWEQQ3i (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 12:29:38 -0400
Message-Id: <200605171629.k4HGTWiJ022335@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux cbon <linuxcbon@yahoo.fr>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: replacing X Window System !
In-Reply-To: Your message of "Wed, 17 May 2006 11:30:46 EDT."
             <Pine.LNX.4.61.0605171129570.31662@chaos.analogic.com>
From: Valdis.Kletnieks@vt.edu
References: <20060517145335.36079.qmail@web26611.mail.ukl.yahoo.com> <200605171509.k4HF9dPR019875@turing-police.cc.vt.edu> <200605171514.k4HFEPKq020058@turing-police.cc.vt.edu>
            <Pine.LNX.4.61.0605171129570.31662@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147883372_4166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 12:29:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147883372_4166P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 May 2006 11:30:46 EDT, "linux-os (Dick Johnson)" said:

> The X window system was an excellent design
> that just isn't used properly if you really
> need a high security environment. All you
> need is a "display machine" that runs X.

But now your "display machine" is inside the security perimeter,
and as such, has to be treated as high security as well.

Otherwise, you're basically doing the equivalent of granting
insufficiently authenticated VPN access into the high security
part of the net.

A more deployable answer is for the X server to compartmentalize the clients,
be aware of their security classifications, and mediate interactions (for
instance, if a "cut" is done in a high-security window, only allow it to
be "paste" into other high-security windows).  The X Security Extension
was one effort to start doing this, and more recently, there have been
patches to allow SELinux mediation of the interactions.

Of course, there will still be those applications where the user ends
up with 2 computers, monitors, keyboards, and mice on their desk,
each connected to a different level network.

--==_Exmh_1147883372_4166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEa09scC3lWbTT17ARAsuMAJ9b712hkg91iw9pQxNurbYUGDrktwCeNioS
JOjC3GOSvAx4tjIeFUxPD3o=
=JMgR
-----END PGP SIGNATURE-----

--==_Exmh_1147883372_4166P--
