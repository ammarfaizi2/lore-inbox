Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266385AbUAVSfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266332AbUAVSfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:35:39 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:1411 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S266395AbUAVSf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:35:28 -0500
Date: Fri, 23 Jan 2004 07:38:13 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH: Export console functions for use by Software Suspend	nice
 display
In-reply-to: <20040122082438.GV21151@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074796577.12771.81.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-f63NAanTw/MOnCbE/QTW";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074757083.1943.37.camel@laptop-linux>
 <20040122082438.GV21151@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f63NAanTw/MOnCbE/QTW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

I'm not sure that write is what I want. At the very least, it will make
the code harder to read and maintain. Here's a small portion of what I'm
currently doing:

/* Print version */
posn[0] =3D (unsigned char) (0);
posn[1] =3D (unsigned char) (video_num_lines);
putconsxy(suspend_console, posn);
cond_console_print(swsusp_version, strlen(swsusp_version));
=20
/* Print header */
posn[0] =3D (unsigned char) ((video_num_columns - 29) / 2);
posn[1] =3D (unsigned char) ((video_num_lines / 3) -4);
putconsxy(suspend_console, posn);
=20
The output looks something like this:
-----


              S U S P E N D    T O    D I S K


        Writing caches...
        [--------        120/640MB             ]







2.0-rc4
-----

Bootsplash is also supported, so there's an even nicer version :>

Regards,

Nigel

On Thu, 2004-01-22 at 21:24, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Thu, Jan 22, 2004 at 09:12:00PM +1300, Nigel Cunningham wrote:
> > Hi.
> >=20
> > Here's a second patch; this exports gotoxy, reset_terminal, hide_cursor=
,
> > getconsxy and putconsxy for use in Software Suspend's nice display.
>=20
> Why don't you open /dev/console on rootfs and use write(2)?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-f63NAanTw/MOnCbE/QTW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAEBggVfpQGcyBBWkRAmOKAKCD+u8lJAa07Vj5gDIsgpu1DDQ88ACgkBIH
5YEhVwA9N1ItE46evdNyCzo=
=jeS4
-----END PGP SIGNATURE-----

--=-f63NAanTw/MOnCbE/QTW--

