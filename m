Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbVDARVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVDARVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbVDARVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:21:50 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:40347 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S262818AbVDARV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:21:28 -0500
Date: Fri, 1 Apr 2005 19:21:27 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.x (x=4|10|11) doesn't detect my scsi devices on my aic7880 scsi
	interface
Message-ID: <20050401172125.GC751@vanheusden.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sat Apr  2 18:53:46 CEST 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.8i
From: folkert@vanheusden.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have a dual pentium-II with on-board adaptec aic7880 controller.
2.4.x runs nicely, but 2.6 no longer.
The details.

lspci:
0000:00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
0000:00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
0000:00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
0000:00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
0000:00:06.0 SCSI storage controller: Adaptec AIC-7880U
0000:00:09.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
0000:00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
0000:00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)
scsi controller:
0000:00:06.0 0100: 9004:8078

On 2.4.26 things boot-up this way:
PCI: Setting latency timer of device 00:06.0 to 64
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

  Vendor: RICOH     Model: MP6200S           Rev: 2.20
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:6): 5.813MB/s transfers (5.813MHz, offset 15)
  Vendor: IBM       Model: DCAS-34330        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
 /dev/scsi/host0/bus0/target6/lun0: p1 p2

but 2.6.x comes with this:
message buffer busy, unable to abort    <--- only for device 0 and 6

devices offlined - not ready after recover  <--- for each id it probes
(had to copy it manually as the system won't come up)

acpi is disabled because the bios is too old

that interface is on the same irq with some other devices: 19:      10858      11757   IO-APIC-level  aic7xxx, usb-uhci, eth0


Folkert van Heusden

Auto te koop! Zie: http://www.vanheusden.com/daihatsu.php
Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCTYMVMBkOjB8o2K4RAsK7AJ92niXLRpRzgLLL9vWCPVYykY1MhwCeKhn/
vLeVxIrNVnFL/Dd2nwSeCZo=
=wuFn
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
