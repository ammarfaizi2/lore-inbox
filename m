Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030851AbWI0VGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030851AbWI0VGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030833AbWI0VGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:06:08 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:64943 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030851AbWI0VGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:06:07 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.18 Nasty Lockup
Date: Thu, 28 Sep 2006 00:06:00 +0300
User-Agent: KMail/1.9.4
Cc: john stultz <johnstul@us.ibm.com>, Greg Schafer <gschafer@zip.com.au>,
       linux-kernel@vger.kernel.org
References: <20060926123640.GA7826@tigers.local> <1159384500.29040.3.camel@localhost> <20060927205531.GB36261@muc.de>
In-Reply-To: <20060927205531.GB36261@muc.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8672332.cP83zKcFR8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609280006.03500.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8672332.cP83zKcFR8
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

27 Eyl 2006 =C3=87ar 23:55 tarihinde, Andi Kleen =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> > Ok. Good to hear you have a workaround. Now to sort out why your TSCs
> > are becoming un-synced. From the dmesg you sent me privately, I noticed
>
> On Intel it seems to happen when people overclock their systems.

This sytem is not overlocked, its a pure 2 x Intel Xeon 3GHz with HT.

> > that while you have 4 cpus, the following message only shows up once:
> >
> > ACPI: Processor [CPU1] (supports 8 throttling states)
> >
> > Does disabling cpufreq change anything?
>
> Throttling has nothing to do with cpufreq
> (at least not until you use the broken P4 throttling cpufreq
> driver, which nobody should). It is normally only used when
> the CPU overheats.

None of them is used on this system also

buildfarm ~ # lsmod
Module                  Size  Used by
i2c_i801                7372  0
i2c_core               19968  1 i2c_i801
serio_raw               7012  0
e752x_edac             11364  0
edac_mc                21424  1 e752x_edac
i6300esb                7096  0
tg3                    98116  0
sd_mod                 18432  4
uhci_hcd               21900  0
ehci_hcd               29896  0
usbcore               115652  5 uhci_hcd,ehci_hcd
ata_piix               13864  2
libata                 93172  1 ata_piix
scsi_mod              127304  2 sd_mod,libata

Also if needed, you can find .config at=20
http://cekirdek.pardus.org.tr/~caglar/config.2.6.18

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart8672332.cP83zKcFR8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFGue7y7E6i0LKo6YRAr4LAJ0axdPFXuX5oT05fUX+sRRJYCDOAQCgicdj
2lVguO9fXgT6ilfjK3OrHW4=
=MELr
-----END PGP SIGNATURE-----

--nextPart8672332.cP83zKcFR8--
