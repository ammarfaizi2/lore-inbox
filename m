Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275534AbTHMUup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275535AbTHMUup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:50:45 -0400
Received: from [207.188.30.29] ([207.188.30.29]:11194 "EHLO mpenc1.prognet.com")
	by vger.kernel.org with ESMTP id S275534AbTHMUuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:50:39 -0400
Date: Wed, 13 Aug 2003 13:50:37 -0700
From: Tom Marshall <tommy@home.tig-grr.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with PCMCIA (Texas Instruments PCI1410)
Message-ID: <20030813205037.GA11977@home.tig-grr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have not been able to get PCMCIA support working in my TI-PCI1410 based
system using the 2.6.0-test3 kernel.  It works with 2.4.21, although I have
to do a "cardctl eject; cardctl insert" after the APM suspend/restore cycle=
.=20
The main chipset is i830m and the laptop is a Dell C400, if that matters.

In 2.6.0-test3, the syslog shows these messages when inserting my Orinoco
card:

  Aug 10 15:55:33 venture cardmgr[312]: socket 0: Anonymous Memory
  Aug 10 15:55:33 venture cardmgr[312]: executing: 'modprobe memory_cs'
  Aug 10 15:55:33 venture cardmgr[312]: + FATAL: Module memory_cs not found.
  Aug 10 15:55:33 venture cardmgr[312]: modprobe exited with status 1
  Aug 10 15:55:33 venture cardmgr[312]: module /lib/modules/2.6.0-test3/pcm=
cia/memory_cs.o not available
  Aug 10 15:55:33 venture cardmgr[312]: bind 'memory_cs' to socket 0 failed=
 : Invalid argument

Here's the (hopefully) relevant lspci output:

  00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 04)
  ...
  00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
  ...
  02:01.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Control=
ler (rev 02)

This is from another laptop that works fine with both kernels:

  00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge =
(rev 03)
  00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (r=
ev 03)
  00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
  00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
  ...

I can provide more detailed information on request.

Please cc: me on replies.

--=20
The intelligence of any discussion diminishes with the square of the
number of participants.
        -- Adam Walinsky

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj86pJ0ACgkQFMm9uvwPXW4mHwCfbb6eRnlknj9QEeMobkHnxaZa
1noAnRTcC9EEXy/jtBY4ohdrZcDutSS/
=RGSp
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
