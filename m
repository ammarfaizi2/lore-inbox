Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbTDGUIz (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbTDGUIz (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:08:55 -0400
Received: from chaos.ao.net ([205.244.242.21]:46765 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id S263616AbTDGUIy (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 16:08:54 -0400
Date: Mon, 7 Apr 2003 16:20:25 -0400
From: Dan Merillat <dmerillat@sequiam.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7 IDE compilation problems (and previous kernels)
Message-ID: <20030407202024.GH1712@chaos.ao.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Bayes-Status: No, probability=0.000
X-Bayes-Debug: , kernel:0.010, kernel:0.010, micalg:0.010, 4i:0.010, Apr:0.010, non-zero:0.010, Debian-1:0.010, e38:0.010, pgp-signature:0.010, pgp-signature:0.010, Apr:0.010, -----END:0.010, pgp-sha1:0.010, exited:0.010, --Dan:0.010
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

DMA is required for a successful compile:  (After make clean/make dep)

drivers/ide/idedriver.o(.text+0x28c): In function `init_dma_generic':
: undefined reference to `ide_setup_dma'
drivers/ide/idedriver.o(.text+0x12e36): In function
`ide_hwif_setup_dma':
: undefined reference to `ide_setup_dma'
make: *** [vmlinux] Error 1
Command exited with non-zero status 2
65.30user 3.04system 1:08.42elapsed 99%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (134929major+160438minor)pagefaults 0swaps

I know non-DMA IDE is rare, but a compile failure shouldn't be the
result.

--Dan


--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD8DBQE+kd2IkycScExRgsgRApV5AKCWWVI36+W7j7SI24ofit6ZqnZndACeIfom
xYdDJSOvBjBWzSaqModcdcM=
=e38/
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--
