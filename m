Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUBKFZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 00:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUBKFZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 00:25:47 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:44158 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263475AbUBKFZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 00:25:37 -0500
From: tabris <tabris@tabris.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: console/gpm mouse breakage 2.6.3-rc1-mm1
Date: Tue, 10 Feb 2004 23:50:54 -0500
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200402100605.25115.tabris@tabris.net> <20040210201102.GB261@ucw.cz>
In-Reply-To: <20040210201102.GB261@ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uSbKAiz7t+mAKRy"
Message-Id: <200402110024.00792.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_uSbKAiz7t+mAKRy
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 10 February 2004 3:11 pm, Vojtech Pavlik wrote:
> On Tue, Feb 10, 2004 at 06:05:19AM -0500, tabris wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > 	just went to 2.6.3 this morning due to frustrations with my PDC20265
> > causing lockups... hoping that 2.6 solves this problem...
> >
> > 	and now i'm having trouble where gpm doesn't work right... cilcks don't
> > register as a click event. Yes, it works fine in X (using GPM in repeat=
er
> > mode, -R raw. the old hack I used to allow X to use both mice, as well =
as
> > eliminating the gpm crashes every couple times I switched btwn X and
> > console mode.)
> >
> > instead I get characters echoed to my terminal
> > left click: Q
> > right click: W
> > middle click: E (plus some control character... i haven't tried a captu=
re
> > and hexdump yet)
> >
> > 	also, my PS/2 mouse (MS IMPS/2) no longer works. from any /dev node I'=
ve
> > tried.
>
> This is very interesting. Can you post your /proc/bus/input/devices and
> dmesg?

ok. updated... i rebuilt it, and made psmouse a module. mouse now is workin=
g=20
with gpm. (tracking feels funny tho)

also, it does NOT have the issue with the odd console echo. but my=20
USB/wireless mouse still has that problem.

=2D --=20
Sharks are as tough as those football fans who take their shirts off
during games in Chicago in January, only more intelligent.
		-- Dave Barry, "Sex and the Single Amoeba: What Every
		   Teen Should Know"
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKbS31U5ZaPMbKQcRAh/4AJ4thxf+ccp60OsGcwtJq0NomoNvKgCeM0Wv
rg9bl/9F71NnIYqvX09tkJk=3D
=3DHQHn
=2D----END PGP SIGNATURE-----

--Boundary-00=_uSbKAiz7t+mAKRy
Content-Type: application/x-zerosize;
  name="devices"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="devices"

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd 
B: EV=120003 
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe 
B: LED=7 

I: Bus=0003 Vendor=046d Product=c504 Version=1310
N: Name="Logitech USB Receiver"
P: Phys=usb-0000:00:11.2-1/input0
H: Handlers=kbd 
B: EV=12000b 
B: KEY=10000 7 ff800000 7ff febeffdf ffefffff ffffffff fffffffe 
B: ABS=100 0 
B: LED=fc1f 

I: Bus=0003 Vendor=046d Product=c504 Version=1310
N: Name="Logitech USB Receiver"
P: Phys=usb-0000:00:11.2-1/input1
H: Handlers=kbd mouse0 
B: EV=12000f 
B: KEY=ffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 0 0 1878 d800d100 1e0000 0 0 0 
B: REL=30f 
B: ABS=100 0 
B: LED=fc00 

I: Bus=0011 Vendor=0002 Product=0005 Version=0000
N: Name="ImPS/2 Generic Wheel Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse1 
B: EV=7 
B: KEY=70000 0 0 0 0 0 0 0 0 
B: REL=103 


--Boundary-00=_uSbKAiz7t+mAKRy--

