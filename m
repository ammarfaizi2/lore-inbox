Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWCOVgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWCOVgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWCOVf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:35:56 -0500
Received: from smtpout10-04.prod.mesa1.secureserver.net ([64.202.165.238]:34791
	"HELO smtpout10-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1751557AbWCOVft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:35:49 -0500
From: hackmiester / Hunter Fuller <hackmiester@hackmiester.com>
Reply-To: hackmiester@hackmiester.com
Organization: hackmiester.com, Ltd.
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Date: Wed, 15 Mar 2006 15:35:15 -0600
User-Agent: KMail/1.8
References: <20060315193114.GA7465@in.ibm.com> <20060315211335.GD25361@kvack.org> <90BA5A4C-6EC1-47E2-954A-5EDEB240DD4B@kernel.crashing.org>
In-Reply-To: <90BA5A4C-6EC1-47E2-954A-5EDEB240DD4B@kernel.crashing.org>
X-Face: #pm4uI.4%U/S1i<i'(UPkahbf^inZ;WOH{EKM,<n/P;R5m8#`2&`HN`hB;ht_>=?utf-8?q?oJYRGD3o=0A=09?=)AM
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1394183.QXIXys2Hip";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603151535.17977.hackmiester@hackmiester.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1394183.QXIXys2Hip
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 15 March 2006 15:30, Kumar Gala  wrote:
> On Mar 15, 2006, at 3:13 PM, Benjamin LaHaise wrote:
> > On Wed, Mar 15, 2006 at 03:05:30PM -0600, Kumar Gala wrote:
> >> I disagree.  I think we need to look to see what the "bloat" is
> >> before we go and make start/end config dependent.
> >
> > Eh?  32 bit kernels get used in embedded systems, which includes those
> > with only 8MB of RAM.  The upper 32 bits will never be anything other
> > than 0.
>
> Why do people equate embedded with small amounts of memory.
They don't. I believe Kumar said "which includes those that have 8mB" and n=
ot=20
"which all have 8mB" :)
 > I know=20
> of embedded systems which use 32-bit PowerPCs that have >4G of system
> memory.
>
> >> It seems clear that drivers dont handle the fact that "start"/"end"
> >> change an 32-bit vs 64-bit archs to begin with.  By making this even
> >> more config dependent seems to be asking for more trouble.
> >
> > You can't get a non-32 bit value on a 32 bit platform, so why should a
> > driver be expected to handle anything?
>
> I dont follow.  I would say that most drivers shouldn't care about
> the fact that they are on a 32-bit platform or 64-bit platform.  The
> point is that drivers have made assumptions about being on 32-bit
> platforms which breaks when a 32-bit platform supports a larger
> physical address space.
Some platforms are way too different from a 32 bit one to have a driver=20
support both... so in some cases this wouldn't be good.
>
> - kumar
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
=2D-hackmiester
Walk a mile in my shoes and you will be a mile away in a new pair of shoes.

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD/yYl3ApzN91C7BcRAoVVAJ97uhjh30nQ4hd9bQ90gJqiwsLEfgCeKSrg
bVfqEeJ09WhO6Y51WHEHb6o=3D
=3DVTUd
=2D----END PGP SIGNATURE-----

=2D----BEGIN GEEK CODE BLOCK-----
Version: Geek Code v3.1 (PHP)
GCS/CM/E/IT d-@ s: a- C++$ UBLS*++++$ P+ L+++$ E- W++$ !N-- !o+ K-- !w-- !O-
M++$ V-- PS@ PE@ Y--? PGP++ !t--- 5--? !X-- !R-- tv-- b+ DI++ D++ G+ e++++
h---- r+++ z++++
=2D-----END GEEK CODE BLOCK------

Quick contact info:
Work: hfuller@stpaulsmobile.net
Personal: hackmiester@hackmiester.com
Large files/spam: hackmiester@gmail.com
GTalk:hackmiester/AIM:hackmiester1337/Y!:hackm1ester/IRC:irc.7sinz.net/7sinz

--nextPart1394183.QXIXys2Hip
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEGIiV3ApzN91C7BcRAi7KAKCAE99s5a37ZO990XnL81gjYDptJQCg0nhG
qxI2TYKyabhjaAu/2ILYbSc=
=kXO/
-----END PGP SIGNATURE-----

--nextPart1394183.QXIXys2Hip--
