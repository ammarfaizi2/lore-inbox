Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTHSUte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbTHSUtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:49:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:24193 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261226AbTHSUoy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:44:54 -0400
Message-Id: <200308192044.h7JKinBC008427@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "David S. Miller" <davem@redhat.com>
Cc: dang@fprintf.net, ak@muc.de, lmb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices 
In-Reply-To: Your message of "Tue, 19 Aug 2003 12:37:11 PDT."
             <20030819123711.2f79fcf8.davem@redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <mdtk.Zy.1@gated-at.bofh.it> <mgUv.3Wb.39@gated-at.bofh.it> <mgUv.3Wb.37@gated-at.bofh.it> <miMw.5yo.31@gated-at.bofh.it> <m365ktxz3k.fsf@averell.firstfloor.org> <1061320620.3744.16.camel@athena.fprintf.net> <200308191938.h7JJcpBC004873@turing-police.cc.vt.edu>
            <20030819123711.2f79fcf8.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1703462784P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Aug 2003 16:44:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1703462784P
Content-Type: text/plain; charset=us-ascii

On Tue, 19 Aug 2003 12:37:11 PDT, "David S. Miller" said:

> Please set the preferred source for eth1 to $(IP_OF_ETH1)
> and the preferred source for eth3 to $(IP_OF_ETH3) then
> do this:
> 
> bash# echo "1" >/proc/sys/net/ipv4/conf/eth1/arp_filter
> bash# echo "1" >/proc/sys/net/ipv4/conf/eth3/arp_filter
> 
> This also will make applications connecting using unspecified
> source addresses behave more sanely as well.

If I'm reading the code right, this will cause the interface to only deal with
ARP that have that interface's IP configured, whatever it happens to be at this
instant, so will DTRT for my configuration even when I'm doing DHCP or other
similar...

> The thing you claim is the right thing to do is the wrong thing
> to do in environments other than your own.

I never said it was the Right Thing for all environments, only that
the default is sub-optimal for some (probably common) setups...

I'm off to test - if that's all that's needed, I'm outta this thread. ;)




--==_Exmh_1703462784P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQE/QoxAcC3lWbTT17ARAia+AJ9q0bi/JZ3rCsDpE7KuMZpdlFT0XACWMmlv
qD3Njbqd8j0y0fZ8CDevMA==
=8rUm
-----END PGP SIGNATURE-----

--==_Exmh_1703462784P--
