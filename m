Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVAPNDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVAPNDK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVAPNDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:03:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.191]:27624 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262495AbVAPNDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:03:00 -0500
Date: Sun, 16 Jan 2005 14:02:50 +0100
From: Nils Radtke <lkml@Think-Future.de>
To: Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: Re: ethX interface rx errors AND RE: Promise module (old) broken
Reply-To: Nils Radtke <lkml@Think-Future.de>
Mail-Followup-To: Nils Radtke <lkml@Think-Future.de>,
	Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
X-Url: http://www.Think-Future.de
X-Editor: Vi it! http://www.vim.org
X-Bkp: p2mi
X-GnuPG-Key: gpg --keyserver search.keyserver.net --recv-keys 06232116
User-Agent: Mutt/1.5.6+20040907i
Message-Id: <20050116130254.6FFF744142@service.i-think-future.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:35131867b06e6a502cee335cb348919d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


  Hi,=20

 a month and a half ago, I asked about a solution for the bad performance=
=20
 of 8139too _and_ 3c509 cards.
Another email was about the bad performance of the PROMISE20565
controller and making hard disks go mad (and me, too).

Thx to Nick Warne, Bernd Eckenfels (both about RX errors), Bartlomiej
Zolnierkiewicz, Alan Pope (both about PROMISE20565) for answers and suggest=
ions.

Both topics have more or less been solved (at least they are handled in a w=
ay
the system runs stably again), see below, read on:

The main (ethx RX errors) problem has not been solved yet. Still, there are=
=20
RX errors.

But: they amount of RX errors has dramatically decreased!


What did I do?

1) plug the cards into different pci-slots. Mainly, I swapped all of the
plugged PCI cards one card slot above. Previously, the cards were
plugged in PCI slot 4 and 5, so they are now at 3 and for. I did this as
on the Asus P3BF mainboard slots 4 and 5 share interrupts with each
other. Slot 5 also shares IRQ with USB. Moreover, I cared about not to
let share interrupts between the slot the NICs and the PROMISE20565
cards are plugged. The PROMISE20565 controller card driver is also
something special and causing trouble on itself. More on that below.
The problem was the same with one 8139too and one 3c509 cards plugged.
Now, there are only two 8139too cards in the system, again.

2) switch to kernel 2.6.10=20
Thats what took me some convincing with myself as 2.6.8-2.6.9 had caused
some serious issues with the beloved PROMISE20565 driver..
Hey, who dares wins! (sometimes)=20
With 2.6.10 (and the PCI slots swapped) the RX errors are much less AND=20
the PROMISE20565 controller works (almost) out of the box.=20
The controller driver previously made me beleive a brandnew WD 120GB HDD=20
be defective.=20
But it isn't. It's the driver making the HDD shaking.=20
Or better, has been. Now, the HDD is running fast (as it wasn't before)=20
and w/o disk drive seek errors all the time, causing the kernel to=20
read-only mount the disk. That was nasty. Better now.
(PROMISE20565 controller card is on a different PCI slot as well, now)


  Thanks for all your suggestions and answers!


    With kind regards,


      Nils Radtke


--=20
A+
* N.Radtke@                 * University of Stuttgart *    icq / lc   *
*      www.Think-Future.de  *    dep.comp.science     * 9336272/92045 *
:x                            UTM 32 0515651 5394088                 :)
   You just wait, I'll sin till I blow up!   -- Dylan Thomas=20
  =20
  =20

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Nils Radtke

iD8DBQFB6mX6X3r3ggYjIRYRAineAJ9L1/CWQxsWwbljD0G7YchWwhchSwCeOfEY
CwFKs5MScRfdy64gj1l1vjA=
=E95d
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
