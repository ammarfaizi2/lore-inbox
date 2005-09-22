Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVIVDfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVIVDfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 23:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVIVDfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 23:35:22 -0400
Received: from h80ad24c8.async.vt.edu ([128.173.36.200]:49076 "EHLO
	h80ad24c8.async.vt.edu") by vger.kernel.org with ESMTP
	id S1030202AbVIVDfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 23:35:22 -0400
Message-Id: <200509220335.j8M3ZGEJ004230@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org
Subject: 2.5.14-rc1-mm1.5 - keyboard wierdness
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127360115_2825P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Sep 2005 23:35:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127360115_2825P
Content-Type: text/plain; charset=us-ascii

I've had this happen twice now, running Andrew's "not quite -mm2" patch.

Symptoms: After about 20-30 minutes uptime, a running gkrellm shows system mode
suddenly shoot up to 99-100%, and the keyboard dies.  Oddly enough, a USB mouse
continued working, and the X server was still quite responsive (I was able to
close Firefox by opening a menu with the mouse and selecting 'quit', for
example).

alt-sysrq-foo still worked, but ctl-alt-N to switch virtual consoles didn't.
sysrq-t produced a trace with nothing obviously odd - klogd, syslog, and the
disk were all working.

Nothing interesting in the syslog - no oops, bug, etc..

Another odd data point (I didn't notice if this part happened the first time):
gkrellm reported that link ppp0 had inbound packets on the modem port of a
Xircom ethernet/modem combo card.  At the rate of 3.5M/second - a neat trick
for a 56K modem.  When I unplugged the RJ-11, gkrellm *kept* reporting the
inbound traffic.  When I ejected the card, *then* the ppp0 (and the alleged
inbound packets) stopped - but still sitting at 99% system and no keyboard.

This ring any bells?  Any suggestions for instrumentation to help debug this?

--==_Exmh_1127360115_2825P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMiZzcC3lWbTT17ARAhwEAJ9Eon+lRBsi+40imt6PQ8UE6Q7ztQCeP3+q
d5h+Dw9zlLMQjGiH+NMY41I=
=B7EI
-----END PGP SIGNATURE-----

--==_Exmh_1127360115_2825P--
