Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbVLEUX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVLEUX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVLEUX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:23:59 -0500
Received: from mout2.freenet.de ([194.97.50.155]:19910 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1751441AbVLEUX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:23:58 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Jiri Benc <jbenc@suse.cz>
Subject: Re: Broadcom 43xx first results
Date: Mon, 5 Dec 2005 21:23:42 +0100
User-Agent: KMail/1.8.3
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz>
In-Reply-To: <20051205190038.04b7b7c1@griffin.suse.cz>
Cc: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200512052123.42357.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart3505332.8KX3vdio57";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3505332.8KX3vdio57
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 05 December 2005 19:00, you wrote:
> On Sun, 04 Dec 2005 19:50:08 +0100, mbuesch@freenet.de wrote:
> > The team is in the progress of writing a SoftwareMAC layer,
> > which is needed for the bcm device. The SoftMAC is still very
> > incomplete. So do not expect to do any fancy stuff like WPA
> > or something line that with it.
>=20
> Why yet another attempt to write 802.11 stack? Sure, the one currently
> in the kernel is unusable and everybody knows about it. But why not to
> improve code opensourced by Devicescape some time ago instead of
> inventing the wheel again and again? Yes, I know that code is not
> perfect and needs a lot of work, but it is the best piece of code we
> have available now. And it _does_ support WPA and such - in fact, it is
> nearly complete.

This is __not__ "yet another stack". It is an _extension_.
It is all about management frames, which the in-kernel code
does not manage.

We want a working device. The driver is in a state where it
is more or less usable. What is missing, is code to handle
management.
We tried the code from the RTL driver, but it is total crap.
We dropped it again. We thought about using yet another out of
kernel ieee80211 stack, but we began to write an extension
to the in-kernel code. If that was right or wrong, well, that's
the question.

If you _really_ think we should have used $EXTERNAL_STACK,
go and patch the driver to work with it. I would really like
to see it working. It is easy to change the used 80211 stack,
as it is only a task of replacing TX and RX function calls
(and a few parameter settings to the ieee struct on init).

PS: I forgot to mention in the announcement, that the driver has
problems with OFDM (that are all 802.11g) rates. So use 802.11b
rates. 11MBit works fine.

=2D-=20
Greetings Michael.

--nextPart3505332.8KX3vdio57
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDlKHOlb09HEdWDKgRAusHAKCo/UiGD0uml9kBufhMV/ihfbz/NwCfcaJO
brDR+BsW08FI8T6H4BWVeFE=
=H+BS
-----END PGP SIGNATURE-----

--nextPart3505332.8KX3vdio57--
