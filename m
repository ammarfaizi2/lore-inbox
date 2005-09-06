Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVIFUDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVIFUDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVIFUDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:03:17 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52915 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750849AbVIFUDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:03:17 -0400
Message-Id: <200509062002.j86K28R8019604@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch for link detection for R8169 
In-Reply-To: Your message of "Tue, 06 Sep 2005 21:46:02 +0200."
             <20050906194602.GA20862@electric-eye.fr.zoreil.com> 
From: Valdis.Kletnieks@vt.edu
References: <431DA887.2010008@zabrze.zigzag.pl>
            <20050906194602.GA20862@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126036928_2971P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Sep 2005 16:02:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126036928_2971P
Content-Type: text/plain; charset=us-ascii

On Tue, 06 Sep 2005 21:46:02 +0200, Francois Romieu said:
> Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl> :
> > There is a patch to driver of RLT8169 network card. This match make 
> > possible detection of the link status even if network interface is down.
> > This is usefull for laptop users.
> 
> (side note: there is maintainer entry for the r8169 and network related
> patches are welcome on netdev@vger.kernel.org)
> 
> Can you elaborate why it is usefull for laptop users ?

Desktops and rack mounts you tend to leave that RJ45 plugged into the back
all the time.  As a result, "no link" is a rare error condition.

On the other hand, laptops are often sitting around with no RJ45 in sight.
Being able to detect "card present but no cable plugged in" can be useful in
startup scripts and the like, so you can do something like

if [ link-is-up eth3 ];
then
	ifup eth3;
fi

and avoid throwing nasty error messages (and even worse, timeouts) trying to
bring up the card if there's nothing plugged in.  There's no sense in trying to
do the whole DHCP thing (or whatever you need to do) if you can tell beforehand
that it will fail....


--==_Exmh_1126036928_2971P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDHfXAcC3lWbTT17ARAiwDAJ4rcTDvCzMIT943P6CyBabKYmokLwCfeCQF
WsJqNjZfn3imfDeFlao99tQ=
=6ZHH
-----END PGP SIGNATURE-----

--==_Exmh_1126036928_2971P--
