Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUBZPue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUBZPue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:50:34 -0500
Received: from chico.rediris.es ([130.206.1.3]:61835 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S261989AbUBZPua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:50:30 -0500
From: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-mm4
Date: Thu, 26 Feb 2004 16:50:14 +0100
User-Agent: KMail/1.5.4
References: <20040225185536.57b56716.akpm@osdl.org>
In-Reply-To: <20040225185536.57b56716.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ender@debian.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2WhPA1sxIB8ttYJ"
Message-Id: <200402261650.15596.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_2WhPA1sxIB8ttYJ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Jueves, 26 de Febrero de 2004 03:55, Andrew Morton escribi=F3:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3=
=2Dm
>m4/
>
> - Big knfsd update.  Mainly for nfsv4
>
> - DVB udpate
>
> - Various fixes

	Hello, Andrew, I jumped from rc1-mm1 to this and found that somebody final=
ly=20
touched ini9100 driver, but it needs further cleaning. It doesn't compile=20
properly, and give warnings.

	Attached patch fixes compilation of ini9100u driver and cleans several=20
unneeded definitions. It applies cleanly to 2.6.3-mm4 (I think).

	Could you please review, because although simple, I'm scared, I don't real=
ly=20
know if my patch is doing the Right Thing (tm)? Thanks. :-)

	Regards,


		Ender.
=2D --=20
What was that, honey? It was bad. It had no fire, no energy, no nothing.
 So tomorrow from 5 to 7 will you PLEASE act like you have more than a
 two word vocabulary. It must be green.
		-- DJ Ruby Rhod (The Fifth Element).
=2D --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.51.50
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPhW3Ws/EhA1iABsRAoqPAJ4m9/jMcJ9/W54qLwEhKn9uC9AKOACeOJ2u
wy7M+GgPS8dWP2nR0IoeBnw=3D
=3Dp/NV
=2D----END PGP SIGNATURE-----

--Boundary-00=_2WhPA1sxIB8ttYJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ini9100u-broken-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ini9100u-broken-patch"

--- drivers/scsi/ini9100u.c.orig	2004-02-26 14:12:32.000000000 +0100
+++ drivers/scsi/ini9100u.c	2004-02-26 14:13:27.000000000 +0100
@@ -180,14 +180,7 @@
 
 static char *setup_str = (char *) NULL;
 
-static irqreturn_t i91u_intr0(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr1(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr2(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr3(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr4(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr5(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr6(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr7(int irq, void *dev_id, struct pt_regs *);
+static struct Scsi_Host *hreg;
 
 static void i91u_panic(char *msg);
 
@@ -340,7 +333,6 @@
 int i91u_detect(Scsi_Host_Template * tpnt)
 {
 	HCS *pHCB;
-	struct Scsi_Host *hreg;
 	unsigned long i;	/* 01/14/98                     */
 	int ok = 0, iAdapters;
 	ULONG dBiosAdr;

--Boundary-00=_2WhPA1sxIB8ttYJ--

