Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbTEOSje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264169AbTEOSje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:39:34 -0400
Received: from iucha.net ([209.98.146.184]:5741 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S264164AbTEOSjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:39:32 -0400
Date: Thu, 15 May 2003 13:52:21 -0500
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: USB Storage oops in 2.5.69-bk8
Message-ID: <20030515185221.GF20965@iucha.net>
Mail-Followup-To: linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I get the following oops in 2.5.69-bk8 when I try to mount a Compact
Flash card in a SanDisk adapter:

usb 2-1: USB disconnect, address 2
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 2-0:0: new USB device on port 1, assigned address 3
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Explorer] o=
n usb-00:02.3-1
usb 2-1: USB disconnect, address 3
drivers/usb/input/hid-core.c: can't resubmit intr, 00:02.3-1/input0, status=
 -19
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 2-0:0: new USB device on port 1, assigned address 4
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Explorer] o=
n usb-00:02.3-1
SCSI device sda: 31232 512-byte hdwr sectors (16 MB)
sda: Write Protect is off
sda: Mode Sense: 02 00 00 00
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
drivers/usb/core/hub.c: USB device not accepting new address (error=3D-22)
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id=
 0 lun 0
usb 5-2: USB disconnect, address 2
Unable to handle kernel paging request at virtual address 544150a8
 printing eip:
c02abc39
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02abc39>]    Not tainted
EFLAGS: 00010286
EIP is at scsi_eh_finish_cmd+0x19/0x60
eax: ef19d000   ebx: eef28080   ecx: eef22140   edx: 54415056
esi: eef21fa8   edi: eef21fb0   ebp: eef21fa8   esp: eef21f60
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_1 (pid: 118, threadinfo=3Deef20000 task=3Deef23340)
Stack: eef28080 eef28080 eef21fb0 c02ac418 eef28080 eef21fa8 00000000 00000=
000=20
       00000000 ef62f428 eef20000 00000282 eef21fa8 c02ac8d6 eef21fb0 eef21=
fa8=20
       eef21fa8 eef21fb0 eef21fa8 eef21fa8 eef28098 eef28098 ef62f400 eef21=
fd4=20
Call Trace:
 [<c02ac418>] scsi_eh_offline_sdevs+0x68/0x80
 [<c02ac8d6>] scsi_unjam_host+0xc6/0xd0
 [<c02ac9b1>] scsi_error_handler+0xd1/0x120
 [<c02ac8e0>] scsi_error_handler+0x0/0x120
 [<c0108abd>] kernel_thread_helper+0x5/0x18

Code: 0f b7 42 52 48 66 89 42 52 c7 43 24 00 00 00 00 66 c7 43 08=20

I cannot tell if it is a regression since I just got the CF and the
adapter.
=20
Thank you,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+w+HlNLPgdTuQ3+QRAjcWAKCVCEXKofSSB3caFPEMGbNvFXnWsgCffSMV
JwCpgORmEc3wYSVmfh8jAmA=
=xcrK
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
