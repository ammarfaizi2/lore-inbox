Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSGILbJ>; Tue, 9 Jul 2002 07:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSGILbI>; Tue, 9 Jul 2002 07:31:08 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:9620 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S314459AbSGILbH>;
	Tue, 9 Jul 2002 07:31:07 -0400
Date: Tue, 9 Jul 2002 13:35:37 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: questions about netfilter/iptables api
Message-ID: <20020709133537.A1834@crystal.2d3d.co.za>
Mail-Followup-To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 1:11pm  up 20 days, 21:52, 12 users,  load average: 0.15, 0.08, 0.04
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to figure out how to prepend rules into the INPUT/OUTPUT chains.
The way I see it, you do

1. getsockopt IPT_SO_GET_INFO and IPT_SO_GET_ENTRIES to get current entries
in chain.

2. construct a ``struct ipt_entry'' with the new rule.

3. construct a ``struct ipt_replace'' entry with new entry + old entries.

4. do setsockopt IPT_SO_SET_REPLACE to insert new entry in the chain.

Now, what I can't figure out is what those hook_entry and underflow arrays
in ``struct ipt_replace'' are used for and what offsets I need to put in th=
em.

Also, I see that iptables goes and appends elems entries for some of the
struct ipt_entry entries. When do I need to do that and is it necessary for
simple rules like these:

-I INPUT -d net/mask -i eth0
-I OUTPUT -s net/mask -o eth1
-I INPUT -d net/mask -p tcp --source-port 23 -i eth0
etc.

I don't see why any additional info would be necessary since you can fit all
that info in the the ``struct ipt_ip'' field.

--=20

Regards
 Abraham

Well, O.K.  I'll compromise with my principles because of EXISTENTIAL DESPA=
IR!

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9KsqJzNXhP0RCUqMRAuopAJ9GbFqnWw9kpcJhI5WLFWT8ufezZwCeOINO
KWGKFK0RPAi/5PcLkzCSNjg=
=UMBR
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
