Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUF2UEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUF2UEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUF2UEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:04:05 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:25754 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S266006AbUF2UDq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:03:46 -0400
Message-Id: <200406292003.i5TK3Y6o017275@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Willy Tarreau <willy@w.ods.org>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt 
In-Reply-To: Your message of "Mon, 28 Jun 2004 21:26:07 +0200."
             <87vfhbjxgw.fsf@deneb.enyo.de> 
From: Valdis.Kletnieks@vt.edu
References: <40DC9B00@webster.usu.edu> <20040625150532.1a6d6e60.davem@redhat.com> <cbp62t$a38$1@news.cistron.nl> <20040628183709.GL29808@alpha.home.local>
            <87vfhbjxgw.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2116569714P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Jun 2004 16:03:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2116569714P
Content-Type: text/plain; charset=us-ascii

On Mon, 28 Jun 2004 21:26:07 +0200, Florian Weimer said:

> > The Cisco routers we deployed 3.5 years ago were already configured with MD
5
> > enabled on BGP, this was on IOS 12.0 at this time. And I guess that Cisco
> > still has a good share amongst the BGP setups.
> 
> Software deployed /= configured & enabled.
> 
> One of the main problems with the TCP MD5 option is that it requires a
> password which has to be negotiated by the peers.  This adds a
> non-trivial management burdern.

The latest numbers I saw on the NANOG list estimated that only 30% to 40% of
core peerings were using MD5 even several weeks after the Great MD5-Fest...

> If the packet is still handled by a real CPU (which is very likely the
> case given the complexity of the protocols involved), it will still
> overload.

I am told that at least some versions of IOS got it Very Very Wrong - rather
than first checking the simple things like "is the source/dest addr/ports/seq
on the RST in bounds?" or "is a BGP packet?", it would check the MD5 *first* -
meaning you could swamp the real CPU by sending it a totally bogus stream of
allegedly MD5-signed traffic.. which of course would induce a route flap
when the CPU fell too far behind... ;)

--==_Exmh_2116569714P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA4csWcC3lWbTT17ARAugUAJ9cF2QdCv7lHd15QZ8pLJ3IVpHteQCff271
31Mq8KhGfSJWX6P0PtZlF/E=
=Rl40
-----END PGP SIGNATURE-----

--==_Exmh_2116569714P--
