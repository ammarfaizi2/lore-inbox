Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbTIJCSx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 22:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTIJCSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 22:18:53 -0400
Received: from [128.173.37.191] ([128.173.37.191]:13440 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264530AbTIJCSu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 22:18:50 -0400
Message-Id: <200309100218.h8A2IXYu006681@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Lockups when booting with CardBus NIC inserted 
In-Reply-To: Your message of "Tue, 09 Sep 2003 21:18:01 +0200."
             <1063135080.1228.10.camel@teapot.felipe-alfaro.com> 
From: Valdis.Kletnieks@vt.edu
References: <1063135080.1228.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1442610960P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Sep 2003 22:18:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1442610960P
Content-Type: text/plain; charset=us-ascii

On Tue, 09 Sep 2003 21:18:01 +0200, Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>  said:
> Hi,
> 
> I tried jumping from 2.6.0-test4-mm6 to 2.6.0-test4-bk9. However, with
> 2.6.0-test4-bk9, I have noticed that I can no longer boot if my CardBus
> NIC is inserted into one of the CardBus sockets. Doing so causes the
> kernel to lock up hard when checking the cardbus socket. The kernel is
> able to boot if the card is not inserted into the slot.

Seeing the same thing here on a Dell Latitude C840.

.  -test4-mm6 was OK, -test5-mm1 was NOT

The card in question is a Xircom 10/100Ethernet/56K modem card.

Under -test4-mm6, it does:

Sep  9 09:41:18 turing-police kernel: Console: switching to colour frame buffer device 160x64
Sep  9 09:41:18 turing-police kernel: PCI: Enabling device 0000:02:01.0 (0000 -> 0002)
Sep  9 09:41:18 turing-police kernel: Yenta: CardBus bridge found at 0000:02:01.0 [1028:00d5]
Sep  9 09:41:18 turing-police kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Sep  9 09:41:18 turing-police kernel: Yenta: Routing CardBus interrupts to PCI
Sep  9 09:41:18 turing-police kernel: Yenta: ISA IRQ list 00b8, PCI irq9
Sep  9 09:41:18 turing-police kernel: Socket status: 30000006
Sep  9 09:41:18 turing-police kernel: PCI: Enabling device 0000:02:01.1 (0000 -> 0002)
Sep  9 09:41:18 turing-police kernel: Yenta: CardBus bridge found at 0000:02:01.1 [1028:00d5]
Sep  9 09:41:18 turing-police kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Sep  9 09:41:18 turing-police kernel: Yenta: Routing CardBus interrupts to PCI
Sep  9 09:41:18 turing-police kernel: Yenta: ISA IRQ list 00b8, PCI irq9
Sep  9 09:41:18 turing-police kernel: Socket status: 30000006


Under -test5-mm1 it says "Socket status: 30000020" after the *first* one (02:01.0)
and locks up hard, not even a SysRq.  Is it perhaps upset about the fact it's
a multifunction card?

--==_Exmh_-1442610960P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Xon4cC3lWbTT17ARAspSAKDAJ2DbyOCn2o1f3jy1c8780F3TXQCghWH7
8Y3RoL6sPs/4ovuidPGnD4M=
=gQTK
-----END PGP SIGNATURE-----

--==_Exmh_-1442610960P--
