Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWGITZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWGITZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWGITZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:25:31 -0400
Received: from pool-71-254-66-150.ronkva.east.verizon.net ([71.254.66.150]:44740
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161062AbWGITZb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:25:31 -0400
Message-Id: <200607091924.k69JOuaw004252@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Roman Zippel <zippel@linux-m68k.org>, john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1
In-Reply-To: Your message of "Sun, 09 Jul 2006 02:11:06 PDT."
             <20060709021106.9310d4d1.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060709021106.9310d4d1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152473096_3401P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Jul 2006 15:24:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152473096_3401P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Jul 2006 02:11:06 PDT, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/

Congrats to all the maintainers I've hassled the last few -mm's (in particular,
Alan Cox, Roman Zippel, and John Stultz) - this one came up basically OK..

1) The timer issues with booting with 'vga=794' causing slow console output
and confusing the error correcting seem resolved - the problem section of
early userspace is back to the 2-3 seconds it used to be, rather than 2-3 mins.

2) libata is now setting the speeds sanely for both IDE devices:

[    7.808637] libata version 2.00 loaded.
[    7.808888] ata_piix 0000:00:1f.1: version 2.00ac5
[    7.808908] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[    7.810374] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[    7.810910] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[    7.811767] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[    7.811855] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
[    7.812510] scsi0 : ata_piix
[    7.964218] ata1.00: ATA-6, max UDMA/100, 117210240 sectors: LBA 
[    7.964790] ata1.00: ata1: dev 0 multi count 8
[    8.116060] ata1.01: ATAPI, max UDMA/33
[    8.121104] ata1.00: configured for UDMA/100
[    8.272621] ata1.01: configured for UDMA/33
[    8.273139]   Vendor: ATA       Model: FUJITSU MHV2060A  Rev: 0000
[    8.274258]   Type:   Direct-Access                      ANSI SCSI revision:05
[    8.277954]   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
[    8.279074]   Type:   CD-ROM                             ANSI SCSI revision:05

(Alan - I *did* have to apply the piix_pata_ops to ich_pata_ops one-liner,
that didn't seem to be in -rc1-mm1).

--==_Exmh_1152473096_3401P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEsVgIcC3lWbTT17ARAp5XAJ9/easa6YIy1T8Xm4N4X2Pg2CrvLgCg1vAf
NPbxcbSS/mU66KexMHvNbdA=
=0ApM
-----END PGP SIGNATURE-----

--==_Exmh_1152473096_3401P--
