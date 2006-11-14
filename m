Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966398AbWKNVsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966398AbWKNVsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966397AbWKNVsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:48:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:31138 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S966392AbWKNVsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:48:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=rhDYKddtE2Ty3qdJ9FZQV6uIhuTt0dkOs3ASEE5QKUC4j0XLZxNjA/VELU0ri63Gephd5XcP1vOzsBWEmmosiPhiCk1VLHBYONODyIuz7gx85P9f+w7pF0WwVaL8/NVMJyg8BVwqcxlVoQ43AetNq4Pr/ab1RM1JfTZi/jxk0Kw=
From: Christian Hoffmann <chrmhoffmann@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Tue, 14 Nov 2006 22:47:49 +0100
User-Agent: KMail/1.9.5
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611140008.55059.rjw@sisk.pl>
In-Reply-To: <200611140008.55059.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1990370.NSl1Nzi9yF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611142247.55137.chrmhoffmann@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1990370.NSl1Nzi9yF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 14 November 2006 00:08, Rafael J. Wysocki wrote:
> On Monday, 13 November 2006 23:08, Christian Hoffmann wrote:
> > > -----Original Message-----
> > > From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> > > Sent: Monday, November 13, 2006 3:06 PM
> > > To: Christian Hoffmann
> > > Cc: Pavel Machek; Benjamin Herrenschmidt; Andrew Morton;
> > > Solomon Peachy; linux-fbdev-devel@lists.sourceforge.net; LKML
> > > Subject: Re: Fwd: [Suspend-devel] resume not working on acer
> > > ferrari 4005 with radeonfb enabled
> > >
> > > On Monday, 13 November 2006 11:51, Christian Hoffmann wrote:
> > > > > -----Original Message-----
> > > > > From: Pavel Machek [mailto:pavel@ucw.cz]
> > > > > Sent: Sunday, November 12, 2006 1:14 PM
> > > > > To: Benjamin Herrenschmidt
> > > > > Cc: Christian Hoffmann; Andrew Morton; Solomon Peachy; Rafael J.
> > > > > Wysocki; linux-fbdev-devel@lists.sourceforge.net; LKML;
> > > > > Christian@ogre.sisk.pl; Hoffmann@albercik.sisk.pl
> > > > > Subject: Re: Fwd: [Suspend-devel] resume not working on
> > >
> > > acer ferrari
> > >
> > > > > 4005 with radeonfb enabled
> > > > >
> > > > > Hi!
> > > > >
> > > > > > > Then the radeonfb doesn't kick in at all (guess some
> > >
> > > pci ids are
> > >
> > > > > > > added in that patch).
> > > > > > >
> > > > > > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > > > > >
> > > > > > In that case (vesafb), when does the screen come back
> > > > >
> > > > > precisely ? Do
> > > > >
> > > > > > you get console mode back and then X ? Or it only comes
> > >
> > > back when
> > >
> > > > > > going back to X ? Do you have some userland-type vbetool
> > > > >
> > > > > thingy that
> > > > >
> > > > > > bring it back ?
> > > > >
> > > > > He's using s3_bios+s3_mode, so kernel does some BIOS
> > >
> > > calls to reinit
> > >
> > > > > the video. It should come out in text mode, too.
> > > > >
> > > > > Christian, can you unload radeonfb before suspend/reload it after
> > > > > resume?
> > > >
> > > > Will it work if radeonfb is compiled as module? I think I
> > >
> > > had problems
> > >
> > > > with that, but I'll try again.
> > > >
> > > > > Next possibility is setting up serial console and adding some
> > > > > printks to radeon...
> > > >
> > > > Unfortunatly, the laptop doesn't have serial port. I tried to get a
> > > > USB device (pocketpc) read the USB serial, but I only partially
> > > > succeeded. I can pass console=3DttyUSB0 to the kernel and
> > >
> > > load the ipaq
> > >
> > > > serial console driver as it oopses. I am able to echo strings to
> > > > /dev/ttyUSB0  and read them on the ipaq, but I am not able to
> > > > "deviate" the kernel messages to that port. Any hints on how to do
> > > > that would be very appreciated, I didn't find anything
> > >
> > > usefull on the
> > >
> > > > web. (I tried with setconsole /dev/ttyUSB0 but it gives error msg
> > > > about device busy or something)
> > >
> > > Would it be practicable to use netconsole on your box?  If
> > > so, it should work.
> >
> > I tried netconsole, and it somehow works, but when suspending it says in
> > an "infinite" loop:
> >
> > unregister_netdevice: waiting for eth2 to become free. Usage count =3D 1
>
> Hm.  Is your kernel compiled with CONFIG_DISABLE_CONSOLE_SUSPEND set?
>
> Rafael

I tried that patch, but the last message I see over netconsole (using tg3) =
is:
Suspending console(s)
and then nothing. Nothing on resume at all :(

Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume=20
(radeon_pm.c) didn't help: I don't see them. But I am not a kernel programm=
er=20
at all, so I might do something wrong or in the wrong place.

Chris

--nextPart1990370.NSl1Nzi9yF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARVo5itonrF4PGGDNAQKcXQ//exYPS3r5nq/TEH1x12dE18o7SUTttMGD
F+zGUWOAHWqE9FEC8TCqbIiav5xCos7Dn6sI4DvPEKTZnkYYiKiTZOxOq6pj1Ath
VMNwHoaXqljwUAxGPBRrtQJ/+S2hFVt57C5eCfwpdPawqqfkcw1xDkuoocl8aPdg
6hGpnv+EV0NOpFG6X+GVnbdHoUbWqMIJBwR/lLo0+ntDRsiQRZILFB6/NGCJXMvC
rc1P/0KgpkCzPJYfuqkmGs/Z8bRiPq+a8fqiNX8WOYUg0o6YokQ2rBNl5NBWxgxY
PIXGUZJV6i5wVdTdjqi3AgmT0/6DR8pTaDzE5PdUmEdcrJ8Hh3m8U1OFSgpM+LkE
z7YZ8qd45FtRv6SdDt+XFpMjGgLVUuBFVvXDBdDWrwrEQOH+Y84GEgQiz4U/VkM6
6fcMQtaZpj8rrs9HA1KWtFUf33B2UROYqhjECdVvLVw7hlgW3BRDpyp8mIBYa88d
Yo+oTWLIBh+1sr8aUt3/iXJiKlBXwZaxdjHiDXRLzmL1EupEgMHTmruDIzW1kDl5
DZIzDNfYyfeKmC/YIP+/Wu5Q3ykq2Y27FgEaT7uObafCuOeZM7MUOO/wPl7Ro2vb
mknm2kh1DeT8HxffwzH7Paa6e4MM+F526WyngVmK4HrDRPF+ojYlbDbx62FVIhnI
ZWNeXtCQEog=
=THAM
-----END PGP SIGNATURE-----

--nextPart1990370.NSl1Nzi9yF--
