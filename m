Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVKFSWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVKFSWD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 13:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVKFSWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 13:22:02 -0500
Received: from pop.gmx.net ([213.165.64.20]:16531 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750965AbVKFSWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 13:22:00 -0500
X-Authenticated: #3439220
From: Martin Maurer <martinmaurer@gmx.at>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: kernel status, "Elitegroup K7S5A" SOLVED
Date: Sun, 6 Nov 2005 19:22:12 +0100
User-Agent: KMail/1.8.2
References: <mailman.1125954121.30702.linux-kernel2news@redhat.com> <20050907211350.18c07fa9.zaitcev@redhat.com>
In-Reply-To: <20050907211350.18c07fa9.zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net,
       Axel =?iso-8859-1?q?Str=FCbing?= <axel.struebing@freenet.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4968448.VXx1eV3iBS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511061922.16296.martinmaurer@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4968448.VXx1eV3iBS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I recently got an E-Mail from Axel Str=FCbing who had the same problem and=
=20
solved it (together with some kernel developpers).
He pointed me to their discussion at=20
http://www.spinics.net/lists/usb/msg00694.html which included a solution to=
=20
this problem.

citing http://www.spinics.net/lists/usb/msg00725.html :
=2D-----------------------------------------------------------
> test this by editing the source code for 2.6.7.  In the file=20
> drivers/usb/storage/transport.c, locate the subroutine=20
> usb_stor_Bulk_max_lun() and comment out the two lines that call=20
> usb_stor_clear_halt().
=2D-----------------------------------------------------------

this solved my problem too. I tried a case where i copied all mp3 files of =
my=20
mp3 player, formatted it, copied all files back, unmounted, replugged,=20
mounted again and did a diff on all files and it was successful.
Therefore it looks like this mp3 player works without problems again.
(i tested with a vanilla kernel 2.6.14).

greetings
Martin Maurer

On Thursday, 8. September 2005 06:13, you wrote:
> On Mon, 5 Sep 2005 13:55:46 -0700, Andrew Morton <akpm@osdl.org> wrote:
> > Re: Elitegroup K7S5A + usb_storage problem
> > [linux-usb-devel] Fw: Re: Elitegroup K7S5A + usb_storage problem
>
> This appears to be stuck. It has to have someone with a lot of patience
> to play with the device.
>
> Martin collected me a good USB trace from Windows, but I was unable
> to figure out what we do differently. The device accepts writes,
> everything looks fine, but if unplugged and plugged back, it returns
> old data. All commands appear basically the same.
>
> The device, BTW, is called "Fun" and "Stick". Has nothing to do with
> memory sticks, of course. Stupid DNT. Anyway, a European Linux hacker
> has to get his hands on one of these before any progress can be made:
>=20
> http://www.dnt.de/index.php?dir=3Ddetails&pid=3D53038&cat=3Dmp3-128&m_id=
=3Dmp3-128&
>h_curr=3D
>
> -- Pete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--nextPart4968448.VXx1eV3iBS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDbknYXHsqb5Up6wURAiSbAJ4oldIB1jUNPyilJexB7luLNZdsqQCfd7X1
sBo40245VVElkVIMQHanbQA=
=SLHO
-----END PGP SIGNATURE-----

--nextPart4968448.VXx1eV3iBS--
