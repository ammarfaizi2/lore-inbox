Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVLVAbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVLVAbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 19:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVLVAbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 19:31:44 -0500
Received: from smtp05.auna.com ([62.81.186.15]:20109 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S964810AbVLVAbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 19:31:44 -0500
Date: Thu, 22 Dec 2005 01:34:32 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA SCSI device numbering - I'm confuzed! - Help!
Message-ID: <20051222013432.5785b9a4@werewolf.auna.net>
In-Reply-To: <43A9444C.8000009@perkel.com>
References: <43A901C8.4090706@perkel.com>
	<20051221093418.1e15e5f2@werewolf.auna.net>
	<43A9444C.8000009@perkel.com>
X-Mailer: Sylpheed-Claws 1.9.100cvs101 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_.zZnOseInr83ou1/OQtFSGp";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Thu, 22 Dec 2005 01:31:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_.zZnOseInr83ou1/OQtFSGp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi....

> >On Tue, 20 Dec 2005 23:18:32 -0800, Marc Perkel <marc@perkel.com> wrote:
> >
> > =20
> >
> >>OK - this really has me stumped. I have a asus A8N-SLI premium=20
> >>motherboard. It has 4 SATA ports on it. The ports are numbered 1 to 4.=
=20

Sure ? As I read in the boot log, you have 8 ports. Look harder ;).

> >>So somehow I asumed that port 1 would be /dev/sda ... port 4 would be=20
> >>/dev/sdd - but when I boot up the order is very different and doesn't=20
> >>make a lot of sense. How can a person predict what drives will get what=
=20
> >>device names. Sure would be handy to be able to know that.
> >>

I will cut the relevant parts of your boot log:

> libata version 1.12 loaded.
> sata_nv version 0.8

> ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low)=
 -> IRQ 217
> ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD400 irq 217
> ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD408 irq 217
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> ata1: dev 0 configured for UDMA/133
> scsi0 : sata_nv
> ata2: SATA link down (SStatus 0)
> scsi1 : sata_nv

First PCI device found has 2 ata ports, one has a drive, nothing in the oth=
er.
Note, speed is 133.

>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

Disk found at scsi0, ie, ata1.

> ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level, low)=
 -> IRQ 225
> ata3: SATA link up 1.5 Gbps (SStatus 113)
> scsi2 : sata_nv
> ata4: SATA link up 1.5 Gbps (SStatus 113)
> scsi3 : sata_nv

Next PCI device, with two more ata ports.

>   Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
> Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0

300Gb disk on scsi2 (ata3).

>   Vendor: ATA       Model: Maxtor 7L300S0    Rev: BANC
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
> Attached scsi disk sdc at scsi3, channel 0, id 0, lun 0

300Gb disk on scsi3 (ata4).

(BTW, why the hell the ata ports are numbered from 1 ?, just to be
different to everyone ? )

> ACPI: PCI Interrupt 0000:05:0a.0[A] -> Link [APC4] -> GSI 19 (level, low)=
 -> IRQ 233
> ata5: SATA max UDMA/100 cmd 0xFFFFC20000006080 ctl 0xFFFFC2000000608A bmd=
ma 0xFFFFC20000006000 irq 233
> ata6: SATA max UDMA/100 cmd 0xFFFFC200000060C0 ctl 0xFFFFC200000060CA bmd=
ma 0xFFFFC20000006008 irq 233
> ata7: SATA max UDMA/100 cmd 0xFFFFC20000006280 ctl 0xFFFFC2000000628A bmd=
ma 0xFFFFC20000006200 irq 233
> ata8: SATA max UDMA/100 cmd 0xFFFFC200000062C0 ctl 0xFFFFC200000062CA bmd=
ma 0xFFFFC20000006208 irq 233
> ata5: SATA link down (SStatus 0)
> scsi4 : sata_sil
> ata6: SATA link down (SStatus 0)
> scsi5 : sata_sil
> ata7: SATA link down (SStatus 0)
> scsi6 : sata_sil
> ata8: SATA link down (SStatus 0)
> scsi7 : sata_sil

One other PCI device, but this time with _4_ SATA ports.
And note again, this are just 100 MHz ports (this is not real speed, but a =
comparison
with traditional ATA).
And nothing hangs on them.

So you have
- one sata 'card', speed 133, with 2 ports, one disk on the first and nothi=
ng
  on the second
- one other similar card, with 2 ports, and one disk on each
- a third card, with 4 slower SATA ports (100), and nothing hung.

(when I say 'card', I mean 'pci device')

So be sure about the labeling on your board, cay you post the results
of

lspci
lspci -n
lspci -v

(All this supposing I _can_ read kernel messages... and understan them)

Take a look at this:

http://www.tomshardware.com/2005/03/23/asus_a8n/index.html

specially

http://www.tomshardware.com/2005/03/23/asus_a8n/page3.html

at the bottom of the page. You'll see your 8 sata ports.

Hope this helps.

Really curious chipset...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam5 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_.zZnOseInr83ou1/OQtFSGp
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDqfSYRlIHNEGnKMMRAjqTAJ0bv8sA1B70E7UkOAvg0Orej0WW0gCfRLHM
NOmdxPjkehUwSTG9x0MmtTs=
=lf1f
-----END PGP SIGNATURE-----

--Sig_.zZnOseInr83ou1/OQtFSGp--
