Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947223AbWKKNm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947223AbWKKNm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 08:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947226AbWKKNm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 08:42:59 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:39315 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1947223AbWKKNm6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 08:42:58 -0500
Date: Sat, 11 Nov 2006 08:45:51 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Christian.Hoffmann@wallstreetsystems.com,
       LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl,
       Hoffmann@albercik.sisk.pl
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005	with radeonfb enabled
Message-ID: <20061111134551.GA9947@shaftnet.org>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Christian.Hoffmann@wallstreetsystems.com,
	LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl,
	Hoffmann@albercik.sisk.pl
References: <200611110031.16173.rjw@sisk.pl> <1163209746.4982.203.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <1163209746.4982.203.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Sat, 11 Nov 2006 08:45:51 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2006 at 12:49:06PM +1100, Benjamin Herrenschmidt wrote:
> There are many possible reasons for that. The most likely is that the
> BIOS isn't bringing the chip back on resume, causing radeonfb to
> crash when trying to access it.

I have the same laptop, and it also crashes for me on resume when=20
radeonfb is loaded.  However, it also crashes on a resume when radeonfb=20
*isn't* loaded, so I hardly considered that a regression.  :)

> On Thu, Nov 09, 2006 at 07:50:17PM +0100, Christian Hoffmann wrote:
> > when I have radeonfb enabled, my laptop (X700 ati mobility) doesnt resu=
me
> > anymore. Screen stays black and nothing works anymore, no capslock ligh=
t, no
> > ctrl alt sysreq b etc. I tried all kind of things vbetool, passing
> > acpi_sleep=3Ds3_bios,s3_mode to the kernel. Nothing seems to work.

=2E..but it used to work?  Now that's interesting; this is the first=20
report I've heard of a suspend-to-RAM (and subsequent resumes) working=20
on that machine.

> > You can see dmesg output and lspci -vv output here=20
> >  http://christianhoffmann.de/temp/radeon.log
> >  http://christianhoffmann.de/temp/lspci.log

Can you send the *full* bootup log, including the command lines you=20
used?

I noticed that you have the 'radeon' drm module loading too; that may be=20
causing problems.  Are you running X when you try to suspend/resume?

Also, since you're using a Ferarri 4000, are you using the stock 3A23=20
BIOS/DSDT, or are you using the patched DSDT from http://acpi.sf.net?

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFFVdQPPuLgii2759ARAuQsAJ9uiN4Nv2eumng9JGfioAk10jqYeACfTlNg
78KNbDJlL+aVriUynUKBLqg=
=Efxv
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
