Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVBBDqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVBBDqi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVBBDoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:44:06 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:24201 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262275AbVBBDmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:42:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=d4VB7Hizf0XS8A2dReVpIeOtGfruj1Hqr72wBjgCRLwAOX77ruURcJ2Mz5OE9LOVjyzGm5B9E2sUo3/lY0CrKLy8l1ZyCbikz3F2vZ1/cT0UwwWhRKOuv8mbMFf7hzE1vJDu150mEWvpPzOfnqorIT3OI2M/9SpVRmLxQrqzSB0=
Date: Tue, 1 Feb 2005 22:42:06 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Joseph Fannin <jfannin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Sean Neakums <sneakums@zork.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: 2.6.11-rc2-mm2
Message-ID: <20050202034205.GA27123@caphernaum.rivenstone.net>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joseph Fannin <jfannin@gmail.com>, Andrew Morton <akpm@osdl.org>,
	Sean Neakums <sneakums@zork.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20050129163117.1626d404.akpm@osdl.org> <1107155510.5905.2.camel@gaston> <20050131112106.GA3494@samarkand.rivenstone.net> <1107213513.5963.26.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <1107213513.5963.26.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2005 at 10:18:33AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2005-01-31 at 06:21 -0500, Joseph Fannin wrote:
>=20
> >     I'm getting a blank screen with radeonfb on two boxes here as
> > well. One is a beige g3, the other is i386; both have PCI Radeon 7000s
> > with radeonfb non-modular.=20
> >=20
> >     On the PC I could see the earliest kernel messages in VGA text
> > mode before radeonfb took over and the screen went blank -- no
> > penguin, and the logo is enabled.  Booting with radeonfb:off seemed to
> > work except for the module problem in -rc2-mm2:
> >=20
> >     On the ppc box I tried both -rc2-mm1 and -rc2-mm2.  Both hung and
> > then rebooted after 3 minutes, so it seems to be panicing somewhere.
> > I backed the massive-radeonfb patch out of -mm2 and radeonfb worked,
> > so I got as far as the module thing again.

>=20
> Hrm... indeed, there seem to be a problem, though I can't tell for sure
> what's up now, it just works on all the configs I had a chance to test
> on. Can you try to boot your G3 with serial console so you can see the
> panic message if any ?

    Okay, I managed to get this Oops message on ppc, when modprobing a
modular radeonfb. I got a similar backtrace on i386 too (lost it though).

radeonfb_pci_register BEGIN
PCI: Enabling device 0000:00:0e.0 (0086 -> 0087)
aper_base: 88000000 MC_FB_LOC to: 8bff8800, MC_AGP_LOC to: ffff9000
radeonfb (0000:00:0e.0): Found 32768k of DDR 64 bits wide videoram
radeonfb (0000:00:0e.0): mapped 16384k videoram
radeonfb: Found Open Firmware ROM Image
radeonfb: Retreived PLL infos from Open Firmware
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D183.00 Mhz, System=
=3D183.00 MHz
radeonfb: PLL min 12000 max 35000
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... found CRT display
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeon_probe_OF_head
head: ATY,RV100ad_A (letter: A, head_no: 0)
analyzing OF properties...
display-type: CRT
radeon_probe_OF_head
head: ATY,RV100ad_A (letter: A, head_no: 1)
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type CRT found
radeonfb: EDID probed
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C00F3DD8 LR: DD2AEF48 SP: D8C8BB50 REGS: d8c8baa0 TRAP: 0300    Not ta=
inted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000008, DSISR: 40000000
TASK =3D c040f1e0[4326] 'modprobe' THREAD: d8c8a000
Last syscall: 128
GPR00: DD2B1950 D8C8BB50 C040F1E0 D8C8BB90 00000000 00000000 D8C8BC2C DD480=
008
GPR08: FFFFFFFF 00000000 DD2B0000 C00F3DD8 24004482 1001E294 00000000 10001=
3C4
GPR16: 00000000 00000000 00000000 00000000 100013C4 00000000 C0320000 DD2B0=
000
GPR24: C0320000 D8C8BBD4 DD2B6470 DD2B647C D8C8BB90 DD2B6438 C08C1000 D8DBA=
000
NIP [c00f3dd8] fb_videomode_to_var+0x0/0x5c
LR [dd2aef48] display_to_var+0x2c/0xb4 [fbcon]
Call trace:
 [dd2b1950] fbcon_switch+0x17c/0x4d8 [fbcon]
 [c0124f20] redraw_screen+0x13c/0x1e8
 [c01288c0] take_over_console+0x400/0x518
 [dd2ae3e4] fbcon_takeover+0x98/0xfc [fbcon]
 [dd2b31cc] fbcon_fb_registered+0x68/0xc4 [fbcon]
 [dd2b3348] fbcon_event_notify+0x6c/0xd8 [fbcon]
 [c002bbc0] notifier_call_chain+0x40/0x68
 [c00f0ec0] register_framebuffer+0x180/0x198
 [dd32e834] radeonfb_pci_register+0x3bc/0x4f0 [radeonfb]
 [c00e9990] pci_device_probe_static+0x54/0x84
 [c00e99f8] __pci_device_probe+0x38/0x6c
 [c00e9a5c] pci_device_probe+0x30/0x5c
 [c0137464] driver_probe_device+0x60/0x9c
 [c01375d4] driver_attach+0x58/0xbc
 [c0137be4] bus_add_driver+0xb0/0x108

--=20
Joseph Fannin
jfannin@gmail.com

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCAEwNWv4KsgKfSVgRAuVhAJ45Rl1z6vj071+iofDq2+sYOV47WwCdHnLx
i4X5/wfgnksuejzu1M0pAzU=
=Hoer
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
