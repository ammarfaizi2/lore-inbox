Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269787AbUJANXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269787AbUJANXD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 09:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269786AbUJANXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 09:23:03 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:33450 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S269787AbUJANWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 09:22:53 -0400
Date: Fri, 1 Oct 2004 15:22:48 +0200
From: Harald Welte <laforge@netfilter.org>
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [BUG] active ftp doesn't work since 2.6.9-rc1
Message-ID: <20041001132248.GG27499@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>
References: <20041001111201.GA23033@pc11.op.pod.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20041001111201.GA23033@pc11.op.pod.cz>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: -4.8 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 01, 2004 at 01:12:01PM +0200, Vitezslav Samel wrote:
> 	Hi!
>=20
>   After upgrade to 2.6.9-rc3 on the firewall (with NAT), active ftp stopp=
ed
> working. The first kernel, which doesn't work is 2.6.9-rc1.
> Sympotms: passive ftp works O.K., active FTP doesn't open data stream (an=
d in
> logs there entries about invalid packets - using
> iptables ... -m state --state INVALID -j LOG)

I just tried to reproduce the problem.  Can you confirm the problem
disappears after executing

echo 1 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_be_liberal

on your NAT box?

> 	Cheers,
> 		Vita Samel

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXVooXaXGVTD0i/8RAjnaAJ9j37XDyfEEs3zNMLU5HXBhkyEIlQCfR9dy
ZTZDdpm67cUOrwk95rXbyM8=
=Nw5k
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
