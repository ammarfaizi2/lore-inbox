Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUATU1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUATU1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:27:22 -0500
Received: from quake.mweb.co.za ([196.2.45.85]:39102 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id S265776AbUATU1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:27:12 -0500
Date: Tue, 20 Jan 2004 22:27:09 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrew Morton <akpm@osdl.org>
Cc: linux@brodo.de, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: limit-timer_pm-printk-storms.patch
Message-Id: <20040120222709.5e011cd8.bonganilinux@mweb.co.za>
In-Reply-To: <20040120115751.5e4441bc.akpm@osdl.org>
References: <20040120212514.43e31237.bonganilinux@mweb.co.za>
	<20040120115751.5e4441bc.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__20_Jan_2004_22_27_09_+0200_R4cOWtUGOWzcs314"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__20_Jan_2004_22_27_09_+0200_R4cOWtUGOWzcs314
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2004 11:57:51 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Bongani Hlope <bonganilinux@mweb.co.za> wrote:
> >
> > This patch has been inspired by the limit-IO-error-printk-storms patch. On my PII when I enable 
> > CONFIG_X86_PM_TIMER this gets called a lot of times, I guess my VIA chipset is too broken to play with this.
> > 
> > <example>
> > ...
> > Jan 19 04:21:46 bongani kernel: bad pmtmr read: (15567390, 15567423, 15567393)
> > Jan 19 04:21:46 bongani kernel: bad pmtmr read: (1746710, 1746719, 1746713)
> > Jan 19 04:21:47 bongani kernel: bad pmtmr read: (2239982, 2239999, 2239986)
> 
> Does the PM timer actually do the right thing once these printk's are
> suppressed?
> 

No this is just to reduce the noise, my /var/log/messages file is about 33M in size

> If not, it would be better to recover somehow - presumably by blacklisting
> this machine or by falling back to a different time source.  Possible?

I think it is better to blacklist for know because according to the comment on that function
it is suppose to e workaround for some broken chipsets.

 
[root@bongani bongani]# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 02)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 07)
00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)

>From dmesg

ACPI: RSDP (v000 VIA691                                    ) @ 0x000f5f70
ACPI: RSDT (v001 AWARD  AWRDACPI 0x30302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 AWARD  AWRDACPI 0x30302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: DSDT (v001  AWARD AWRDACPI 0x00001000 MSFT 0x0100000a) @ 0x00000000

--Signature=_Tue__20_Jan_2004_22_27_09_+0200_R4cOWtUGOWzcs314
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADY8y+pvEqv8+FEMRArjoAJwPcwx08cdI4jBycFeWPlQbvHjD0gCgkONT
RNgxAMEhR3bkuzSB27PUe4M=
=3Fma
-----END PGP SIGNATURE-----

--Signature=_Tue__20_Jan_2004_22_27_09_+0200_R4cOWtUGOWzcs314--
