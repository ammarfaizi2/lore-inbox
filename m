Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272487AbTHEHQM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 03:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272481AbTHEHQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 03:16:11 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:51412
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S272487AbTHEHQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 03:16:02 -0400
Subject: Re: Badness in device_release at drivers/base/core.c:84
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <1352160000.1060025773@aslan.btc.adaptec.com>
References: <20030801182207.GA3759@blazebox.homeip.net>
	 <20030801144455.450d8e52.akpm@osdl.org>
	 <20030803015510.GB4696@blazebox.homeip.net>
	 <20030802190737.3c41d4d8.akpm@osdl.org>
	 <20030803214755.GA1010@blazebox.homeip.net>
	 <20030803145211.29eb5e7c.akpm@osdl.org>
	 <20030803222313.GA1090@blazebox.homeip.net>
	 <20030803223115.GA1132@blazebox.homeip.net>
	 <20030804093035.A24860@beaverton.ibm.com>
	 <1060021614.889.6.camel@blaze.homeip.net>
	 <1352160000.1060025773@aslan.btc.adaptec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sXoOMQCLJnTRdv84vNv7"
Message-Id: <1060067889.7118.7.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (Slackware Linux)
Date: Tue, 05 Aug 2003 03:18:09 -0400
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.21.0.0; VDF: 6.21.0.4; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sXoOMQCLJnTRdv84vNv7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-08-04 at 15:36, Justin T. Gibbs wrote:
> > Patrick,
> >=20
> > I enabled CONFIG_SCSI_LOGGING=3Dy in kernel then i used
> > scsi_mod.scsi_logging_level=3D0x140 and scsi_mod.max_scsi_luns=3D1 when
> > booting the kernel from lilo.I can see some debug information scroll on
> > the screen and i did see ID0 LUN0 get probed even the correct transfer
> > rate for the SCSI disk is set.I forgot but isn't there a key sequence
> > when pressed it will stop the screen output like pause/break key?
>=20
> You might be able to get useful information without using a serial
> console if you turn off your CDROM drives so they don't add extra output,
> but your best bet is to use a serial console.
>=20
> --
> Justin
>=20
>=20

Hi Justin,

This time with both plextor cdroms removed i get this in console:

scsi scan: INQUIRY to host 0 chanel 0 id0 lun 0
scsi scan: 1st INQUIRY failed with code 0x10000

and this repeats for all 15 id's on the cards with same 0x10000 code.

When using aic7xxx_old driver i get this in dmesg:

(scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 1/10/0
(scsi0) Wide Channel, SCSI ID=3D7, 32/255 SCBs
(scsi0) Downloading sequencer code... 398 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.6/5.2.0
       <Adaptec AHA-294X Ultra2 SCSI host adapter>
scsi scan: INQUIRY to host 0 channel 0 id 0 lun 0
scsi scan: 1st INQUIRY successful with code 0x0
  Vendor:           Model:                   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi scan: Sequential scan of host 0 channel 0 id 0
scsi scan: INQUIRY to host 0 channel 0 id 1 lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0
id 1 lun 0
scsi scan: 1st INQUIRY failed with code 0x6030000
scsi scan: INQUIRY to host 0 channel 0 id 2 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 3 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 4 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 5 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 6 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 8 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 9 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 10 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 11 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 12 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 13 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 14 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
scsi scan: INQUIRY to host 0 channel 0 id 15 lun 0
scsi scan: 1st INQUIRY failed with code 0x30000
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

Once i get null modem serial cable i will try to get more info from
serial console.

Regards,

Paul

--=-sXoOMQCLJnTRdv84vNv7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/L1owIymMQsXoRDARArgSAJ9MR1onWlEr9B50KH7cMAvsS6wbmACgibRA
KiNdNA+moh/dCFI4z2XTi7M=
=6vWH
-----END PGP SIGNATURE-----

--=-sXoOMQCLJnTRdv84vNv7--

