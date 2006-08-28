Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWH1Rgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWH1Rgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWH1Rgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:36:48 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:644 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750915AbWH1Rgs (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:36:48 -0400
Message-Id: <200608281735.k7SHZdo6012805@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <w@1wt.eu>, Ernie Petrides <petrides@redhat.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: printk()s of user-supplied strings
In-Reply-To: Your message of "Mon, 28 Aug 2006 05:52:24 +0400."
             <20060828015224.GA27199@openwall.com>
From: Valdis.Kletnieks@vt.edu
References: <20060822030755.GB830@openwall.com> <200608222023.k7MKNHpH018036@pasta.boston.redhat.com> <20060824164425.GA17692@openwall.com> <20060824164633.GA21807@1wt.eu> <20060826022955.GB21620@openwall.com> <20060826082236.GA29736@1wt.eu> <20060826231314.GA24109@openwall.com> <20060827200440.GA229@1wt.eu>
            <20060828015224.GA27199@openwall.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1156786539_3039P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Aug 2006 13:35:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1156786539_3039P
Content-Type: text/plain; charset=us-ascii

On Mon, 28 Aug 2006 05:52:24 +0400, Solar Designer said:

> > Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P
CI ISAPNP enabled^J<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
> 
> The first line (before the ^J) is output with:
> 
> 	printk(KERN_INFO "%s version %s%s (%s) with%s", serial_name,
> 	       serial_version, LOCAL_VERSTRING, serial_revdate,
> 	       serial_options);
> 
> The linefeed is embedded in serial_options.

Gaak.  And I suppose that in *addition* to having an embedded trailing \n,
it *also* has a leading blank to make 'with%s' work correctly?

Fortunately, find . | xargs grep 'serial_revdate' comes up empty on
a 2.6.18-rc4-mm3 tree, so somebody's swatted this blecherousness already.

--==_Exmh_1156786539_3039P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE8ylqcC3lWbTT17ARArIjAJ9+X/lJcLOmapp4XkopZB3HlrfgNwCg4wNR
KguUPh8us3aDlRpGaHLKZys=
=8noF
-----END PGP SIGNATURE-----

--==_Exmh_1156786539_3039P--
