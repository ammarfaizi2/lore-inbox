Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSHBCa7>; Thu, 1 Aug 2002 22:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSHBCa7>; Thu, 1 Aug 2002 22:30:59 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:4032 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S317945AbSHBCa6>; Thu, 1 Aug 2002 22:30:58 -0400
Date: Thu, 01 Aug 2002 22:29:33 -0400
From: Nick Orlov <nick.orlov@mail.ru>
Subject: Re: [PATCH] pdc20265 problem.
In-reply-to: <20020802014728.GA796@nikolas.hn.org>
To: lkml <linux-kernel@vger.kernel.org>
Mail-followup-to: lkml <linux-kernel@vger.kernel.org>
Message-id: <20020802022933.GA1242@nikolas.hn.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_s4tXb6iuHF57NJdU+vQjzA)"
User-Agent: Mutt/1.4i
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
 <20020802014728.GA796@nikolas.hn.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_s4tXb6iuHF57NJdU+vQjzA)
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline

On Thu, Aug 01, 2002 at 09:47:28PM -0400, Nick Orlov wrote:
> 
> > <marcelo@plucky.distro.conectiva> (02/07/19 1.646)
> > 	Fix wrong #ifdef in ide-pci.c: Was causing problems with FastTrak
> 
> Because of this fix my Promise 20265 became ide0 instead of ide2.
> Is there any reason to mark pdc20265 as ON_BOARD controller?
> 
> Anyway, attached patch fix it for me :)
> 

Sorry, wrong diff format. Rediffed and attached.

-- 
With best wishes,
	Nick Orlov.


--Boundary_(ID_s4tXb6iuHF57NJdU+vQjzA)
Content-type: text/plain; charset=koi8-r; NAME=pdc20265.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=pdc20265.patch

--- linux/drivers/ide/ide-pci.c.orig	2002-08-01 21:41:29.000000000 -0400
+++ linux/drivers/ide/ide-pci.c	2002-08-01 21:10:27.000000000 -0400
@@ -405,7 +405,7 @@
 #ifndef CONFIG_PDC202XX_FORCE
         {DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	16 },
         {DEVID_PDC20262,"PDC20262",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
-        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	48 },
+        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
         {DEVID_PDC20267,"PDC20267",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
 #else /* !CONFIG_PDC202XX_FORCE */
 	{DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}}, 	OFF_BOARD,	16 },

--Boundary_(ID_s4tXb6iuHF57NJdU+vQjzA)--
