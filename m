Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262222AbSJNXlX>; Mon, 14 Oct 2002 19:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262234AbSJNXlX>; Mon, 14 Oct 2002 19:41:23 -0400
Received: from 137-123-ADSL.red.retevision.es ([80.224.123.137]:46531 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S262222AbSJNXlW>; Mon, 14 Oct 2002 19:41:22 -0400
Date: Tue, 15 Oct 2002 01:54:41 +0200
From: Javier Marcet <jmarcet@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Gerd Knorr <kraxel@bytesex.org>, vdr@linuxtv.org, linux-dvb@linuxtv.org
Subject: bttv and DVB cards hardware incompaibility only in late linux
Message-ID: <20021014235441.GA12048@jerry.marcet.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
a few weeks ago I reported a problem I was having with a bttv TV card.
I also sent a cc to Gerd Knorr, bttv's author. However I got no response
at all, but from one guy who said everything worked on his system.

I have been trying to find where was the actual problem. What I found is
quite odd.

First let me say that besides the kernel you'll see in the logs I've
tried with a few different version, up to some 2.4.18, and of course
with nearly everything disabled, like APIC, ACPI or PnP. The results
were the same.

Briefly: on this PC I use a Hauppauge DVB card - a Siemens clone,
revision 1.3 -, an Adaptec 2940U2W, a SBLive! and a 3C905C network card.
All that works like a charm.
I also used to have a bttv card there, but I got many problems trying to
use it on that crowded PCI. I know that a few months ago it had worked,
and it also did on Windows (does now? I don't have a copy installed
anymore) on Windows.

I get lot's a IRQ sync errors in the syslog, and can't get any image from
the bttv card.

What I first tried is of course using the bttv without loading the DVB
drivers, since they could clash. This didn't work. I began moving the
cards on the PCI slots, removing some and trying again. Until I found
one combination which did work.
Without the DVB card _plugged_, I can use the bttv with no problems,
having everything else installed and being used. Yet, the moment I plug
in again the DVB board, the bttv does not work anymore.
This would make more sense if the clash was only between the drivers,
specially taking into account that both boards are from Hauppauge and
both worked at the same time on the system under a different OS.

There is one more oddity I noticed seeing the logs I attach, and it's
that with the DVB card out, the bttv board is recognized as a 'WinTV GO'
by lspci, but with the DVB in it is _unrecognized_.

This last thing just killed me. If anyone can point me to what I might
do to try to solve this thing, I'll appreciate it. I am confident it is
not a hardware incompatibility for the reasons I gave above. Also, even
if I did have to unload one's drivers to use the other's, there must be
some way to have both co-habiting on the same PCI bus.


--=20
Javier Marcet <jmarcet@pobox.com>
Saint Louis University, Madrid Campus

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iEYEARECAAYFAj2rWUEACgkQx/ptJkB7frwuxwCeNleTQVxpU5JP4qs+IGuMnwHF
ossAnRx8h0PmeEsAsAygch3At00WrVDX
=ILvC
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
