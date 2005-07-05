Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVGEPjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVGEPjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 11:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVGEPjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:39:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:40929 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261897AbVGEP2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:28:04 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: federico <xaero@inwind.it>
Subject: Re: setkeycodes (KDSETKEYCODE: Invalid argument)
Date: Tue, 5 Jul 2005 17:27:58 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <42C9AD67.5050808@inwind.it>
In-Reply-To: <42C9AD67.5050808@inwind.it>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1716176.PSc3pctM0L";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507051728.01581.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1716176.PSc3pctM0L
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 July 2005 23:43, federico wrote:
> hi all,
>
> i have a problem: i got a white Apple usb keyboard, but this keyboard
> doesn't have PrintScr nor SysRq.
> i read in Documentation/sysrq.txt how to change the SYSRQ scancode.
> i launched showkey and acknowledged that R_Alt+F13 is 100,183 =3D> 64b7.
> i ran
>
>  # setkeycodes 64b7 84
> KDSETKEYCODE: No such device
> failed to set scancode b7 to keycode 84
>
> i'm on a gentoo-vanilla 2.6.13_rc1 with kbd-1.12-r5. (or on
> 2.6.11-gentoo-r9 which produces the same result)
>
> here's some relevant output from strace:
>
> open("/dev/tty", O_RDWR) =3D 3
> ioctl(3, KDGKBTYPE, 0xbffdfcb7) =3D 0
> ioctl(3, KDSETKEYCODE, 0xbffdfd20) =3D -1 ENODEV (No such device)
> dup(2) =3D 4
> fcntl64(4, F_GETFL) =3D 0x8001 (flags O_WRONLY|O_LARGEFILE)
> close(4) =3D 0
> ...
> write(2, "KDSETKEYCODE: No such device\n", 29KDSETKEYCODE: No such device
> ) =3D 29
> ...
> write(2, "failed to set scancode 64b7 to k"..., 42failed to set scancode
> 64b7 to
> keycode 84
> ) =3D 42

Does setkeycode work with current kernels? When I try to set a keycode, I=20
always get following error:

dominik@box # LANG=3D"C" setkeycodes e03e 84
KDSETKEYCODE: Invalid argument
failed to set scancode be to keycode 84

but my dmesg output tells me, that this should be ok:
atkbd.c: Unknown key released (translated set 2, code 0xbe on isa0060/serio=
0).
atkbd.c: Use 'setkeycodes e03e <keycode>' to make it known.

so, is the output from atkbd.c wrong, or does setkeycodes work in the wrong=
=20
way?

cheers,
dominik

--nextPart1716176.PSc3pctM0L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iQCVAwUAQsqnAQvcoSHvsHMnAQIz1AQArWpkYxUXw9T5Qt9DTS2YAlIk9dxh2h8k
FVKPW9gUsWrcGTtS2/QdBvoACuJsbZd5agS5UmqElT4oh2mDSwkMxrXZcwdBnSlR
EDfVqb3uAbjGG63ZIdfzwpsyLSzVNUvWCWAEQrEbhPacvzgNi/uRNwLSPMa5/ISX
o2S//u7wAxU=
=P/ys
-----END PGP SIGNATURE-----

--nextPart1716176.PSc3pctM0L--
