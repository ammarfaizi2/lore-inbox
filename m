Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272462AbRIFMDy>; Thu, 6 Sep 2001 08:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272464AbRIFMDd>; Thu, 6 Sep 2001 08:03:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64013 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272462AbRIFMD3>; Thu, 6 Sep 2001 08:03:29 -0400
Subject: Re: PNPBIOS: warning: >= 16 resources, overflow?
To: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 6 Sep 2001 13:07:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <slrn9pedo0.3eu.kraxel@bytesex.org> from "Gerd Knorr" at Sep 06, 2001 08:42:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15exwY-0007xb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> lspnp (comes with pcmcia-cs) would be more intresting.  The pnpbios code
> fills a "struct pci_dev" for each device reported by the pnpbios, and it
> looks like your portable has one device with alot ressources, so the
> ressources array in struct pci_dev can't hold them all.  There is a
> #define in include/linux/pci.h for the array size ...

For the motherboard memory/io ranges it might be worth teaching the
pnp bios parser to actually reserve the regions as it scans them ?
