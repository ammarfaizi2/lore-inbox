Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTJCIOm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbTJCIOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:14:42 -0400
Received: from [204.97.230.36] ([204.97.230.36]:21008 "HELO gawab.com")
	by vger.kernel.org with SMTP id S263594AbTJCINw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:13:52 -0400
From: Rodolfo Boer <movez@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Badness in as_remove_dispatched_request
Date: Fri, 3 Oct 2003 10:13:34 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310031013.37366.movez@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello! This is my first try with the 2.6.0-test kernels and I get AMOUNTS of 
these warnings during boot-up on both test5 and test6 (this expecially is 
from test6):

Badness in as_remove_dispatched_request at drivers/block/as-iosched.c:1023
Call Trace:
 [<c01e0ef1>] as_remove_dispatched_request+0x71/0x100
 [<c01d9b17>] elv_remove_request+0x27/0x40
 [<c01e5974>] ide_end_request+0xf4/0x150
 [<c01f4ae7>] ide_dma_intr+0x97/0xc0
 [<c01e70ca>] ide_intr+0xea/0x190
 [<c01f4a50>] ide_dma_intr+0x0/0xc0
 [<c010b3aa>] handle_IRQ_event+0x3a/0x70
 [<c010b731>] do_IRQ+0x91/0x130
 [<c0105000>] rest_init+0x0/0x60
 [<c0109b48>] common_interrupt+0x18/0x20
 [<c0105000>] rest_init+0x0/0x60
 [<c0106e93>] default_idle+0x23/0x30
 [<c0106efc>] cpu_idle+0x2c/0x40
 [<c02d670c>] start_kernel+0x14c/0x160
 [<c02d6480>] unknown_bootoption+0x0/0x100

They are all the same. Otherwise the system *seems* to work fine, but I 
haven't tried much since I want to solve this. Maybe the problem is with my 
on-board hpt-372 disk controller (not in RAID configuration). If you need 
more info or my .config just ask.

- -- 
Move -- Proudly abusing Slackware 9.1.0 (pre)
        Linux 2.4.22
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/fS+xtqlBbhAvpboRAvk4AJ9nySo+qgPWi2q9x4cJaqmeVS6kpQCeJ4du
b12kg1IC6cj1lviyeXHojTg=
=r7Qt
-----END PGP SIGNATURE-----

