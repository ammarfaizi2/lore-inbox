Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUBRDPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUBRDPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:15:05 -0500
Received: from main.gmane.org ([80.91.224.249]:52944 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262128AbUBRDO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:14:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
Date: Tue, 17 Feb 2004 11:14:34 -0800
Message-ID: <m24qtpikmd.fsf@tnuctip.rychter.com>
References: <402A4B52.1080800@centrum.cz> <402A7765.FD5A7F9E@users.sourceforge.net>
 <m265e9oyrs.fsf@tnuctip.rychter.com>
 <402F877C.C9B693C1@users.sourceforge.net>
 <m2k72n9pth.fsf@tnuctip.rychter.com>
 <40322094.83061A32@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1053host186.starwoodbroadband.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
Cancel-Lock: sha1:FPBksRpGDb0HdEBXLairfXrZek8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Jari" =3D=3D Jari Ruusu <jariruusu@users.sourceforge.net> writes:
 Jari> Jan Rychter wrote:
 > "Jari" =3D=3D Jari Ruusu <jariruusu@users.sourceforge.net>:
 Jari> File backed loops have hard to fix re-entry problem: GFP_NOFS
 Jari> memory allocations that cause dirty pages to written out to file
 Jari> backed loop, will have to re-enter the file system anyway to
 Jari> complete the write. This causes deadlocks. Same deadlocks are
 Jari> there in mainline loop+cryptoloop combo.
 >>
 >> I have used cryptoapi (as modules) for the last 2 years (or so) now,
 >> without encountering any problems whatsoever. I therefore beg to
 >> differ: if the same deadlocks are there, then for some reason they
 >> are not triggered on my machine. Two years versus an hour, that's a
 >> rather significant difference in terms of reliability.

 Jari> Do you mind doing a a quick grep:

 Jari> cd /path/to/your/kernel/source grep "Jari Ruusu"
 Jari> drivers/block/loop.c

 Jari> If you see my name there, your kerneli.org cryptoapi enabled
 Jari> kernel is running same loop code I wrote years ago. Those
 Jari> loop-jari-something patches that you find on the net, are just
 Jari> copies of old loop-AES code.

No, it is not running this code. The code that works well for me is the
external cryptoapi (as modules) with last update in Feb 2002.

Ok, now after spending some more time googling around and reading
documentation, I'm confused. It also seems I'm not the only one (see
http://www.linuxquestions.org/questions/archive/4/2004/01/3/136754).

How do you get a file-backed encrypted filesystem to work under Linux
2.4.24?

From=20what I understand, there are three options:

  1) cryptoapi-as-modules, which is what I'm using now and what has
     worked reliably (although perhaps not too fast),
  2) in-kernel cryptoapi, which seems to be missing cryptoloop support,
     so how do you actually use it? And what about the i586-optimized
     AES patches?
  3) Jari Ruusu's loop-AES, which from what I understood won't work on
     file-backed loops because of deadlock issues.

Now, I would be all happy with option (1) which I have been using,
except I started caring about speed a little. Also, it bothers me a
little bit that the cryptoapi project seems to have died, as I wasn't
able to find any up-to-date pages or documents about it.

So, what is the preferred way?

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAMmggLth4/7/QhDoRAqjoAJ4/e6EZY1Qpv9fHfJCxTB7C7gmuKACg1HVn
ZGoXQCeW5Td/NbW5YyjLfWU=
=3Nk4
-----END PGP SIGNATURE-----
--=-=-=--

