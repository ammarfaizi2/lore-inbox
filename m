Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTLEKGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 05:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTLEKGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 05:06:40 -0500
Received: from komoseva.globalnet.hr ([213.149.32.250]:20485 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id S263528AbTLEKGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 05:06:38 -0500
Date: Fri, 5 Dec 2003 09:56:17 +0100
From: Vid Strpic <vms@bofhlet.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: "Rahsheen Porter Sr." <microrahsheen@comcast.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: HPT366 ate my IDE controllers
Message-ID: <20031205085617.GD3042@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	Gene Heskett <gene.heskett@verizon.net>,
	"Rahsheen Porter Sr." <microrahsheen@comcast.net>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test11
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Sep 18 2003 13:09:52)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2003 at 10:51:40PM -0500, Gene Heskett wrote:
> On Thursday 04 December 2003 21:15, Rahsheen Porter Sr. wrote:
> >So my root partition, which resides on /dev/hde1 with 2.4.20,
> > becomes /dev/hda1. And my extra partitions that were on /dev/hdg
> > are on /dev/hdc. This wouldn't be a problem accept that what was on
> > /dev/hda and hdc are now gone.
> >What would cause the kernel to totally ignore the built in
> > controllers?
> I'd bet a small amount that there is something in the bios you've set=20
> that is making that decision for you.  Probably a boot offboard=20
> controllers first or some such.

It's CONFIG_BLK_DEV_OFFBOARD, in the kernel.  But the behavior I noticed
is, with that kernel option, system assigns hda for the first disk on
the second controller (Promise here, not HPT, but that shouldn't matter
at all), and the drives on the motherboard controller get hde and so on.

Is OP sure that kernel really doesn't see the drives at all?  And
ofcourse if turning off CONFIG_BLK_DEV_OFFBOARD in the kernel fixes the
problem...

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.0-test11 #2 Wed Nov 26 23:12:44 CET 2003 i686
 09:52:17 up 7 days, 23:54,  1 user,  load average: 0.75, 0.75, 0.68

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/0Egxq1AzG0/iPGMRAmEZAKC9ZkPx4ZkP9AuXCUYEfI7pFrM7mQCgopc9
GaY5V7KIdFTbj6WtR8QIdHc=
=L1OA
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
