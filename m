Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVETTpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVETTpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVETTpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:45:46 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:22797 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261534AbVETTpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:45:38 -0400
Message-Id: <200505201945.j4KJjSAW014218@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Richard B. Johnson" <linux-os@analogic.com>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000 
In-Reply-To: Your message of "Fri, 20 May 2005 21:26:59 +0200."
             <Pine.LNX.4.62.0505202125440.18326@numbat.sonytel.be> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com> <20050520141434.GZ2417@lug-owl.de> <Pine.LNX.4.61.0505201124230.5107@chaos.analogic.com>
            <Pine.LNX.4.62.0505202125440.18326@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116618328_13523P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 20 May 2005 15:45:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116618328_13523P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 May 2005 21:26:59 +0200, Geert Uytterhoeven said:
> On Fri, 20 May 2005, Richard B. Johnson wrote:

> > I think that I've discovered a bug. I know that what I have written gets
> > to the screen buffer because I can read in back! This doesn't make
> > any sense.
> 
> Even if it's only in the CPU cache, of course you can read it back (using the
> CPU, not DMA ;-).

No, the bug is in Richard's assuming that because he can read it back in means
that it's in the screen buffer.  In fact, it only means he wrote it into some
memory location that he can read back in. ;)

Now if he added a description that verified that a read *from the screen buffer*
(rather than "from where he wrote") shows his changes, *then* he'd have something...

--==_Exmh_1116618328_13523P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCjj5XcC3lWbTT17ARAtyPAKDRIQy00wXtaVrO32L1Smh+WF3IjgCgl1Dw
1eKn6XgxTnr+s5UojbExC0A=
=JYhi
-----END PGP SIGNATURE-----

--==_Exmh_1116618328_13523P--
