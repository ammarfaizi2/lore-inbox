Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUH3X05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUH3X05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 19:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUH3X05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 19:26:57 -0400
Received: from hostmaster.org ([212.186.110.32]:40333 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S265275AbUH3X0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 19:26:53 -0400
Subject: hald hangs on 2.6.8.1/SMP with 6in1 CardReader
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-P2Cm5XtWnSGSqOmuwKzL"
Date: Tue, 31 Aug 2004 01:26:51 +0200
Message-Id: <1093908411.3669.26.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-P2Cm5XtWnSGSqOmuwKzL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

after a while running my system load goes up by 3 apparently caused by
hald (http://www.freedesktop.org/software/hal/) locking up together with
[scsi_eh_1] and [usb-storage].

The activity LED of my USB 6in1 card reader flashes nervously and I
obtained the following task state using magic SysRQ:

hald          D 0000268216b1cdba     0  7996   3415                     (NO=
TLB)
000001002a31fc78 0000000000000006 0000007300000000 000001000509c4f0
       000000000000244d 000001003fe402b0 000001000509c808 ffffffff80279860
       000001003ffdcd90 ffffffff802d7d6d
Call Trace:<ffffffff80279860>{scsi_done+0} <ffffffff802d7d6d>{.text.lock.sc=
siglue+5}
       <ffffffff8038f74a>{wait_for_completion+154} <ffffffff8012e370>{defau=
lt_wake_function+0}
       <ffffffff8012e370>{default_wake_function+0} <ffffffff8027d8e3>{scsi_=
wait_req+99}
       <ffffffff8026d979>{ide_diag_taskfile+201} <ffffffff80170c50>{invalid=
ate_bh_lru+0}
       <ffffffff8027aa50>{ioctl_internal_command+112} <ffffffff8027b1ef>{sc=
si_ioctl+751}
       <ffffffff8028e8d5>{sd_media_changed+69} <ffffffff80176459>{check_dis=
k_change+41}
       <ffffffff8028e527>{sd_open+215} <ffffffff80176839>{do_open+281}
       <ffffffff801761c7>{bdget+263} <ffffffff80176cdf>{blkdev_open+47}
       <ffffffff8016dac6>{dentry_open+246} <ffffffff8016dc1e>{filp_open+62}
       <ffffffff80182c86>{sys_poll+806} <ffffffff8017bb55>{getname+149}
       <ffffffff80181f30>{__pollwait+0} <ffffffff8016de7c>{sys_open+76}
       <ffffffff8010e562>{system_call+126}

Anyone else seeing this problem?

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

To vote in an election does not mean to have a choice!



--=-P2Cm5XtWnSGSqOmuwKzL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQEVAwUAQTO3u2D1OYqW/8uJAQJqVgf/cecSJBc2Y6BUE6jlG82tGxstVKL80oRV
G6EPrf/gwxcnUOQhPwxY5hiThPaGWg8PY5OeglhFpl9bNXDPWyIViGUKYtk1K84Z
fT5xIwdW90uoqjhCJTYYvqmCjn1PcpVsktbNWsKQur/346WTMXMB/Ln87YvFNHaA
GVu++MkK5AyVe7C04NMPu4yrPxlUBUkGfRA4ieFEMa3a/x0rogB2piHRRqRjpqAY
X4m8Acp9vRVFEAl8pviWz3JKY+2RL9TApMMVHOeEBIlEx/NzottDzYPZd9QUSghj
5qvcgYPrm2hXIBkZwzJ1jMgKNtKDKOxVU15DDlA6iamZ50vdHsKmjw==
=uUYg
-----END PGP SIGNATURE-----

--=-P2Cm5XtWnSGSqOmuwKzL--

