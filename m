Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317667AbSFRXJe>; Tue, 18 Jun 2002 19:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317668AbSFRXJd>; Tue, 18 Jun 2002 19:09:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:19438 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317667AbSFRXJb>; Tue, 18 Jun 2002 19:09:31 -0400
Date: Wed, 19 Jun 2002 01:09:25 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: jt@hpl.hp.com
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22 broke kernel modular Pcmcia ?
In-Reply-To: <20020618150206.A7868@bougret.hpl.hp.com>
Message-ID: <Pine.NEB.4.44.0206190107180.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Jean Tourrilhes wrote:

> 	Hi,

Hi Jean,

> 	I had a quick look in the archive and didn't find a report of
> this problem :
> --------------------------------
> Starting PCMCIA services: /lib/modules/2.5.22/kernel/drivers/pcmcia/pcmcia_core.o: unresolved symbol pci_bus_type
> --------------------------------
> 	Sorry if it's a duplicate...

the mail below with a patch was sent a few hours ago.

> 	Jean

cu
Adrian



Date: Tue, 18 Jun 2002 18:01:24 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linus Torvalds <torvalds@transmeta.com>, mochel@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] export pci_bus_type to modules.

Hi,

The attached patch (against the BK head, which wasn't yet updated to
2.5.22 btw) exports the pci_bus_type symbol to modules, needed by
(at least) the recent changes in pcmcia/cardbus.c.

Stelian.

===== drivers/pci/pci-driver.c 1.14 vs edited =====
--- 1.14/drivers/pci/pci-driver.c	Sun Jun  9 01:07:49 2002
+++ edited/drivers/pci/pci-driver.c	Tue Jun 18 17:53:41 2002
@@ -210,3 +210,4 @@
 EXPORT_SYMBOL(pci_register_driver);
 EXPORT_SYMBOL(pci_unregister_driver);
 EXPORT_SYMBOL(pci_dev_driver);
+EXPORT_SYMBOL(pci_bus_type);

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com


