Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262946AbUKRTlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbUKRTlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbUKRT3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:29:24 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:19849 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261152AbUKRTZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:25:18 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1717
Date: Thu, 18 Nov 2004 20:25:16 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1396223.vIcUCgtN7i";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411182025.21664.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1396223.vIcUCgtN7i
Content-Type: multipart/mixed;
  boundary="Boundary-01=_dcPnBH8S+MOoFUA"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_dcPnBH8S+MOoFUA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello list,

Using kernel 2.6.10-rc2, I unplugged a USB Flash drive from my USB port whi=
le=20
it was still being written to. This resulted in a complete and total lock o=
f=20
the USB subsystem, trying to unload the modules made rmmod freeze...

In the end Alt-SysRQ came to the rescue allowing me a clean unmount still...

Syslog with everything after unplug attached.

Jan

=2D-=20
Never reveal your best argument.

--Boundary-01=_dcPnBH8S+MOoFUA
Content-Type: text/plain;
  charset="us-ascii";
  name="syslog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="syslog"

Nov 18 20:12:52 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:12:52 precious kernel: end_request: I/O error, dev sda, sector 20=
0900
Nov 18 20:12:52 precious kernel: Buffer I/O error on device sda, logical bl=
ock 200900
Nov 18 20:12:52 precious kernel: lost page write due to I/O error on sda
Nov 18 20:12:52 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:12:52 precious kernel: end_request: I/O error, dev sda, sector 20=
0901
Nov 18 20:12:52 precious kernel: Buffer I/O error on device sda, logical bl=
ock 200901
Nov 18 20:12:52 precious kernel: lost page write due to I/O error on sda
Nov 18 20:12:52 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:12:52 precious kernel: end_request: I/O error, dev sda, sector 20=
0902
Nov 18 20:12:52 precious kernel: Buffer I/O error on device sda, logical bl=
ock 200902
Nov 18 20:12:52 precious kernel: lost page write due to I/O error on sda
Nov 18 20:12:52 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:12:52 precious kernel: end_request: I/O error, dev sda, sector 20=
0903
Nov 18 20:12:52 precious kernel: Buffer I/O error on device sda, logical bl=
ock 200903
Nov 18 20:12:52 precious kernel: lost page write due to I/O error on sda
Nov 18 20:12:52 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 20=
0904
Nov 18 20:13:01 precious kernel: Buffer I/O error on device sda, logical bl=
ock 200904
Nov 18 20:13:01 precious kernel: lost page write due to I/O error on sda
Nov 18 20:13:01 precious kernel: 4>end_request: I/O error, dev sda, sector =
215276
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5277
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5278
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5279
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5280
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5281
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5282
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5283
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5284
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5285
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5286
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5287
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5288
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5289
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5290
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5291
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5292
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5293
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5294
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5295
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5296
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5297
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5298
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5299
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5300
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5301
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5302
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5303
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5304
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5305
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 21=
5306
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 504
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 398
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 399
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 400
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 401
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 402
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 403
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 404
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 405
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 406
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 407
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 408
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 409
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 410
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 411
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 412
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 413
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 414
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 415
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 416
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 417
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 418
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 419
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 420
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 421
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 422
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 423
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 424
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 425
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 426
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 427
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 428
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 429
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 430
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 431
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 432
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 433
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 434
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 435
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 436
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 437
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 438
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 439
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 440
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 441
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 442
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 443
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 444
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 445
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 446
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 447
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 448
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 449
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 450
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 451
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 452
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 453
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 454
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 455
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 456
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 457
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 458
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 459
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 460
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 461
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 462
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 463
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 464
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 465
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 384
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 385
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 150
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 151
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 152
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 153
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 154
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 155
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 156
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 157
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 158
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 159
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 160
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 161
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 162
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 163
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 164
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 165
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 166
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 167
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 168
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 169
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 170
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 171
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 172
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 173
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 174
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 175
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 176
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 177
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 178
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 179
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 180
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 181
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 182
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 183
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 184
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 185
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 186
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 187
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 188
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 189
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 190
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 191
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 192
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 193
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 194
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 195
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 196
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 197
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 198
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 199
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 200
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 201
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 202
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 203
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 204
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 205
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 206
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 207
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 208
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 209
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 210
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 211
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 212
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 213
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 214
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 215
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 216
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 217
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 136
Nov 18 20:13:01 precious kernel: SCSI error : <2 0 0 0> return code =3D 0x7=
0000
Nov 18 20:13:01 precious kernel: end_request: I/O error, dev sda, sector 137
Nov 18 20:13:01 precious kernel: scsi2 (0:0): rejecting I/O to device being=
 removed
Nov 18 20:13:01 precious kernel:  target2:0:0: Illegal state transition <NU=
LL>->cancel
Nov 18 20:13:01 precious kernel: Badness in scsi_device_set_state at driver=
s/scsi/scsi_lib.c:1717
Nov 18 20:13:01 precious kernel:  [pg0+550150217/1069249536] scsi_device_se=
t_state+0xc9/0x130 [scsi_mod]
Nov 18 20:13:01 precious kernel:  [pg0+550129384/1069249536] scsi_device_ca=
ncel+0x28/0x126 [scsi_mod]
Nov 18 20:13:01 precious kernel:  [pg0+550129744/1069249536] scsi_device_ca=
ncel_cb+0x0/0x20 [scsi_mod]
Nov 18 20:13:01 precious kernel:  [device_for_each_child+61/112] device_for=
_each_child+0x3d/0x70
Nov 18 20:13:01 precious kernel:  [pg0+550129825/1069249536] scsi_host_canc=
el+0x31/0xc0 [scsi_mod]
Nov 18 20:13:01 precious kernel:  [pg0+550129744/1069249536] scsi_device_ca=
ncel_cb+0x0/0x20 [scsi_mod]
Nov 18 20:13:01 precious kernel:  [kobject_put+31/48] kobject_put+0x1f/0x30
Nov 18 20:13:01 precious kernel:  [kobject_put+31/48] kobject_put+0x1f/0x30
Nov 18 20:13:01 precious kernel:  [kobject_release+0/16] kobject_release+0x=
0/0x10
Nov 18 20:13:01 precious kernel:  [pg0+550159998/1069249536] scsi_remove_de=
vice+0x7e/0xb0 [scsi_mod]
Nov 18 20:13:01 precious kernel:  [pg0+550130001/1069249536] scsi_remove_ho=
st+0x21/0x70 [scsi_mod]
Nov 18 20:13:01 precious kernel:  [pg0+552615539/1069249536] storage_discon=
nect+0x83/0x9b [usb_storage]
Nov 18 20:13:01 precious kernel:  [pg0+550900022/1069249536] usb_unbind_int=
erface+0x86/0x90 [usbcore]
Nov 18 20:13:01 precious kernel:  [device_release_driver+134/144] device_re=
lease_driver+0x86/0x90
Nov 18 20:13:01 precious kernel:  [bus_remove_device+100/176] bus_remove_de=
vice+0x64/0xb0
Nov 18 20:13:01 precious kernel:  [device_del+93/160] device_del+0x5d/0xa0
Nov 18 20:13:01 precious kernel:  [pg0+550930040/1069249536] usb_disable_de=
vice+0xb8/0x100 [usbcore]
Nov 18 20:13:01 precious kernel:  [pg0+550909654/1069249536] usb_disconnect=
+0xa6/0x150 [usbcore]
Nov 18 20:13:01 precious kernel:  [pg0+550914567/1069249536] hub_port_conne=
ct_change+0x3c7/0x400 [usbcore]
Nov 18 20:13:01 precious kernel:  [pg0+550904663/1069249536] clear_port_fea=
ture+0x57/0x60 [usbcore]
Nov 18 20:13:01 precious kernel:  [pg0+550915249/1069249536] hub_events+0x2=
71/0x3c0 [usbcore]
Nov 18 20:13:01 precious kernel:  [pg0+550915637/1069249536] hub_thread+0x3=
5/0x120 [usbcore]
Nov 18 20:13:01 precious kernel:  [autoremove_wake_function+0/96] autoremov=
e_wake_function+0x0/0x60
Nov 18 20:13:01 precious kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x=
14
Nov 18 20:13:01 precious kernel:  [autoremove_wake_function+0/96] autoremov=
e_wake_function+0x0/0x60
Nov 18 20:13:01 precious kernel:  [pg0+550915584/1069249536] hub_thread+0x0=
/0x120 [usbcore]
Nov 18 20:13:01 precious kernel:  [kernel_thread_helper+5/24] kernel_thread=
_helper+0x5/0x18
Nov 18 20:13:02 precious kernel: Unable to handle kernel NULL pointer deref=
erence at virtual address 00000031
Nov 18 20:13:02 precious kernel:  printing eip:
Nov 18 20:13:02 precious kernel: e10ebf1a
Nov 18 20:13:02 precious kernel: *pde =3D 00000000
Nov 18 20:13:02 precious kernel: Oops: 0000 [#1]
Nov 18 20:13:02 precious kernel: PREEMPT=20
Nov 18 20:13:02 precious kernel: Modules linked in: arc4 ieee80211_crypt_we=
p crc32 ipw2100 ieee80211 ieee80211_crypt sd_mod usb_storage rfcomm l2cap b=
luetooth nsc_ircc irda crc_ccitt video thermal fan button processor ac batt=
ery yenta_socket pcmcia_core b44 mii snd_intel8x0m 8250_pci 8250 serial_cor=
e snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer s=
nd soundcore snd_page_alloc ehci_hcd usbhid uhci_hcd usbcore intel_agp agpg=
art ipt_state iptable_nat iptable_filter ip_tables nls_iso8859_1 nls_cp850 =
vfat fat acerhk ip_conntrack_irc ip_conntrack pcspkr psmouse sg scsi_mod cp=
ufreq_powersave cpufreq_userspace speedstep_centrino freq_table
Nov 18 20:13:02 precious kernel: CPU:    0
Nov 18 20:13:02 precious kernel: EIP:    0060:[pg0+550129434/1069249536]   =
 Not tainted VLI
Nov 18 20:13:02 precious kernel: EFLAGS: 00010002   (2.6.10-rc2)=20
Nov 18 20:13:02 precious kernel: EIP is at scsi_device_cancel+0x5a/0x126 [s=
csi_mod]
Nov 18 20:13:02 precious kernel: eax: 00000001   ebx: df907e9c   ecx: c038c=
390   edx: df9494fc
Nov 18 20:13:02 precious kernel: esi: df9494ec   edi: dfdc5de4   ebp: 00000=
286   esp: dfdc5ddc
Nov 18 20:13:02 precious kernel: ds: 007b   es: 007b   ss: 0068
Nov 18 20:13:02 precious kernel: Process khubd (pid: 1759, threadinfo=3Ddfd=
c4000 task=3Ddec2aae0)
Nov 18 20:13:02 precious kernel: Stack: df907e80 00000003 dfdc5de4 dfdc5de4=
 df908004 d9f214cc c03cf4a8 e10ec050=20
Nov 18 20:13:02 precious kernel:        c02af88d df907e80 00000000 d9f21400=
 d9f21400 e134fbe0 df1915c0 e10ec0a1=20
Nov 18 20:13:02 precious kernel:        d9f214b4 dfdc5e7c e10ec050 c025027f=
 d9943dc0 d9943c00 d9943d84 c025027f=20
Nov 18 20:13:02 precious kernel: Call Trace:
Nov 18 20:13:02 precious kernel:  [pg0+550129744/1069249536] scsi_device_ca=
ncel_cb+0x0/0x20 [scsi_mod]
Nov 18 20:13:02 precious kernel:  [device_for_each_child+61/112] device_for=
_each_child+0x3d/0x70
Nov 18 20:13:02 precious kernel:  [pg0+550129825/1069249536] scsi_host_canc=
el+0x31/0xc0 [scsi_mod]
Nov 18 20:13:02 precious kernel:  [pg0+550129744/1069249536] scsi_device_ca=
ncel_cb+0x0/0x20 [scsi_mod]
Nov 18 20:13:02 precious kernel:  [kobject_put+31/48] kobject_put+0x1f/0x30
Nov 18 20:13:02 precious kernel:  [kobject_put+31/48] kobject_put+0x1f/0x30
Nov 18 20:13:02 precious kernel:  [kobject_release+0/16] kobject_release+0x=
0/0x10
Nov 18 20:13:02 precious kernel:  [pg0+550159998/1069249536] scsi_remove_de=
vice+0x7e/0xb0 [scsi_mod]
Nov 18 20:13:02 precious kernel:  [pg0+550130001/1069249536] scsi_remove_ho=
st+0x21/0x70 [scsi_mod]
Nov 18 20:13:02 precious kernel:  [pg0+552615539/1069249536] storage_discon=
nect+0x83/0x9b [usb_storage]
Nov 18 20:13:02 precious kernel:  [pg0+550900022/1069249536] usb_unbind_int=
erface+0x86/0x90 [usbcore]
Nov 18 20:13:02 precious kernel:  [device_release_driver+134/144] device_re=
lease_driver+0x86/0x90
Nov 18 20:13:02 precious kernel:  [bus_remove_device+100/176] bus_remove_de=
vice+0x64/0xb0
Nov 18 20:13:02 precious kernel:  [device_del+93/160] device_del+0x5d/0xa0
Nov 18 20:13:02 precious dhclient: DHCPACK from 192.168.1.1
Nov 18 20:13:02 precious kernel:  [pg0+550930040/1069249536] usb_disable_de=
vice+0xb8/0x100 [usbcore]
Nov 18 20:13:02 precious kernel:  [pg0+550909654/1069249536] usb_disconnect=
+0xa6/0x150 [usbcore]
Nov 18 20:13:02 precious kernel:  [pg0+550914567/1069249536] hub_port_conne=
ct_change+0x3c7/0x400 [usbcore]
Nov 18 20:13:02 precious kernel:  [pg0+550904663/1069249536] clear_port_fea=
ture+0x57/0x60 [usbcore]
Nov 18 20:13:02 precious kernel:  [pg0+550915249/1069249536] hub_events+0x2=
71/0x3c0 [usbcore]
Nov 18 20:13:02 precious kernel:  [pg0+550915637/1069249536] hub_thread+0x3=
5/0x120 [usbcore]
Nov 18 20:13:02 precious kernel:  [autoremove_wake_function+0/96] autoremov=
e_wake_function+0x0/0x60
Nov 18 20:13:02 precious kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x=
14
Nov 18 20:13:02 precious kernel:  [autoremove_wake_function+0/96] autoremov=
e_wake_function+0x0/0x60
Nov 18 20:13:02 precious kernel:  [pg0+550915584/1069249536] hub_thread+0x0=
/0x120 [usbcore]
Nov 18 20:13:02 precious kernel:  [kernel_thread_helper+5/24] kernel_thread=
_helper+0x5/0x18
Nov 18 20:13:02 precious kernel: Code: ff 21 e0 ff 40 14 8b 53 1c 8d 72 f0 =
8b 46 10 0f 18 00 90 83 c3 1c 39 da 74 38 8d b4 26 00 00 00 00 8b 86 b8 00 =
00 00 85 c0 74 16 <83> 78 30 ff 74 10 89 34 24 e8 28 1d 00 00 85 c0 0f 85 a=
0 00 00=20
Nov 18 20:13:02 precious kernel:  <6>note: khubd[1759] exited with preempt_=
count 1
Nov 18 20:13:02 precious dhclient: bound to 192.168.1.100 -- renewal in 432=
00 seconds.
Nov 18 20:13:04 precious kernel: scsi2 (0:0): rejecting I/O to dead device
Nov 18 20:13:04 precious kernel: printk: 4625 messages suppressed.
Nov 18 20:13:04 precious kernel: Buffer I/O error on device sda, logical bl=
ock 64
Nov 18 20:13:04 precious kernel: lost page write due to I/O error on sda
--Boundary-01=_dcPnBH8S+MOoFUA--

--nextPart1396223.vIcUCgtN7i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBnPchUQQOfidJUwQRAp57AJ9nfIRIgZu1M8pZuPXz9gwzJQFynwCcDtIf
7hI1/WypsvzuJHb9IY4h6UQ=
=+4NC
-----END PGP SIGNATURE-----

--nextPart1396223.vIcUCgtN7i--
