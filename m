Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbUJXTOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbUJXTOy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 15:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbUJXTOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 15:14:54 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:33995 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261588AbUJXTOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 15:14:50 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.8.1] bad: scheduling while atomic! when loading aha152x driver
Date: Sun, 24 Oct 2004 21:14:58 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3147390.KkfthIUWL1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410242115.01067.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3147390.KkfthIUWL1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello list,

Loading the aha152x driver resulted in this output, and shortly after a sol=
id lock of the box happened.

Oct 24 21:08:13 faerun kernel: aha152x: BIOS test: passed, 1 controller(s) =
configured
Oct 24 21:08:13 faerun kernel: aha152x: resetting bus...
Oct 24 21:08:15 faerun kernel: aha152x3: vital data: rev=3D1, io=3D0x340 (0=
x340/0x340), irq=3D10, scsiid=3D7, reconnect=3Denabled, parity=3Denabled, s=
ynchronous=3Denabled, delay=3D1000, extended translation=3Ddisabled
Oct 24 21:08:16 faerun kernel: aha152x3: trying software interrupt, ok.
Oct 24 21:08:16 faerun kernel: scsi3 : Adaptec 152x SCSI driver; $Revision:=
 2.7 $
Oct 24 21:08:16 faerun kernel: (scsi-1:-1:-1) unexpected state (1)
Oct 24 21:08:30 faerun last message repeated 24 times
Oct 24 21:08:31 faerun kernel: (scsi3:0:0) cannot reuse command
Oct 24 21:08:31 faerun kernel: bad: scheduling while atomic!
Oct 24 21:08:31 faerun kernel:  [schedule+1114/1120] schedule+0x45a/0x460
Oct 24 21:08:31 faerun kernel:  [__down+137/256] __down+0x89/0x100
Oct 24 21:08:31 faerun kernel:  [default_wake_function+0/32] default_wake_f=
unction+0x0/0x20
Oct 24 21:08:31 faerun kernel:  [__mod_timer+208/384] __mod_timer+0xd0/0x180
Oct 24 21:08:31 faerun kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
Oct 24 21:08:31 faerun kernel:  [pg0+143508100/1070325760] .text.lock.aha15=
2x+0x19/0x35 [aha152x]
Oct 24 21:08:31 faerun kernel:  [pg0+143489568/1070325760] timer_expired+0x=
0/0xc0 [aha152x]
Oct 24 21:08:31 faerun kernel:  [pg0+143425216/1070325760] scsi_try_bus_dev=
ice_reset+0x40/0x80 [scsi_mod]
Oct 24 21:08:31 faerun kernel:  [pg0+143425818/1070325760] scsi_eh_bus_devi=
ce_reset+0x5a/0xe0 [scsi_mod]
Oct 24 21:08:31 faerun kernel:  [pg0+143427690/1070325760] scsi_eh_ready_de=
vs+0x2a/0x60 [scsi_mod]
Oct 24 21:08:31 faerun kernel:  [pg0+143428048/1070325760] scsi_unjam_host+=
0xb0/0xc0 [scsi_mod]
Oct 24 21:08:31 faerun kernel:  [pg0+143428262/1070325760] scsi_error_handl=
er+0xc6/0x100 [scsi_mod]
Oct 24 21:08:31 faerun kernel:  [pg0+143428064/1070325760] scsi_error_handl=
er+0x0/0x100 [scsi_mod]
Oct 24 21:08:31 faerun kernel:  [kernel_thread_helper+5/24] kernel_thread_h=
elper+0x5/0x18
Oct 24 21:08:31 faerun kernel: (scsi-1:-1:-1) unexpected state (1)
Oct 24 21:09:00 faerun last message repeated 73 times

Any pointers?

Thanks.

Jan

=2D-=20
Your nature demands love and your happiness depends on it.

--nextPart3147390.KkfthIUWL1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBe/81UQQOfidJUwQRAt16AJ4ue4UjlTm9yOPcPiFr3BZpr6UvqgCcDruT
JNNsekppc/YKSS/m0i4FNz8=
=QO0z
-----END PGP SIGNATURE-----

--nextPart3147390.KkfthIUWL1--
