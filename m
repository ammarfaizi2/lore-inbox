Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265465AbSJXOwS>; Thu, 24 Oct 2002 10:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSJXOwS>; Thu, 24 Oct 2002 10:52:18 -0400
Received: from cpe-66-1-217-65.fl.sprintbbd.net ([66.1.217.65]:11273 "EHLO
	chef.linux-wlan.com") by vger.kernel.org with ESMTP
	id <S265465AbSJXOwR>; Thu, 24 Oct 2002 10:52:17 -0400
Date: Thu, 24 Oct 2002 10:58:22 -0400
From: Solomon Peachy <solomon@linux-wlan.com>
To: "David S. Miller" <davem@rth.ninka.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New ARPHRD types
Message-ID: <20021024145822.GA11876@linux-wlan.com>
References: <20021021221936.GA32390@linux-wlan.com> <1035330936.16084.23.camel@rth.ninka.net> <20021023141651.GA6644@linux-wlan.com> <1035433080.9629.8.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <1035433080.9629.8.camel@rth.ninka.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2002 at 09:18:00PM -0700, David S. Miller wrote:
> I'm not allowing you to put a hack special ARP header type into
> the kernel when the real fix is to clean up the 802.11 handling
> in the entire tree.

It's not so much a matter of "clean up" as "write to begin with"

> This is the second time I'm saying this.

And this is the second time I'm saying that I agree that it is the wrong
thing to do; I don't want to do it; I withdraw my request for the new
ARPHRD type; and again ask the question:

Do the network core &| protocol stacks have any dependencies on
(skb->mac.raw - skb->data) being the same as netdev->hard_header_len?
I'm asking you if the core networking stuff can handle variable-length
headers coming off of one netdev.  =20

Can I assume it generally works, or is it generally broken? You seem to
be implying the latter.

> If that means every ethernet driver has to be aware of variable length
> headers potentially, so be it.

The ethernet drivers are not broken.  The generic ethernet code is not
broken.  802.11 headers are not a "special case" of 802.[23] headers.=20
If anything is broken wrt variable headers, it would be net/ipv4 or
some other protocol stack. =20

So, what do you want me to do?

0) go away
1) audit the use of hard_header_len in net/* and submit fixes
2) write an 802.11 equivalent of the code in eth.c
3) mangle eth.c to handle 802.11 &| variable headers and fix all
    drivers that inevitably break

Bleh.

 - Pizza
--=20
Solomon Peachy                        solomon@linux-wlan.com
AbsoluteValue Systems                 http://www.linux-wlan.com
715-D North Drive                     +1 (321) 259-0737  (office)
Melbourne, FL 32934                   +1 (321) 259-0286  (fax)

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9uAqOgW9b/nAvdc4RAhMjAJ0a2vtc1ILF6kRefYMGpsd+NjzrSQCfWcUj
3UdAtzaTg/cVveud+U9p/00=
=+VIt
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
