Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbTAUPnd>; Tue, 21 Jan 2003 10:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbTAUPnd>; Tue, 21 Jan 2003 10:43:33 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:55556 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S266564AbTAUPnc>; Tue, 21 Jan 2003 10:43:32 -0500
Date: Tue, 21 Jan 2003 18:52:22 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: mmoneta@optonline.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Problem] PCI resource conflicts in recent 2.4 kernels - second try
Message-ID: <20030121185222.A1359@jurassic.park.msu.ru>
References: <1042989167.7294.31.camel@optonline.net> <1043154817.25168.4.camel@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1043154817.25168.4.camel@optonline.net>; from mace@monetafamily.org on Tue, Jan 21, 2003 at 08:13:38AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 08:13:38AM -0500, Mace Moneta wrote:
> > 00:06.0 PCI bridge: Toshiba America Info Systems: Unknown device 0605 (rev 04)
> > (prog-if 00 [Normal decode])

Yet another broken bridge...
Does this patch help?

Ivan.

--- linux/drivers/pci/quirks.c.orig	Tue Jan 21 18:45:55 2003
+++ linux/drivers/pci/quirks.c	Tue Jan 21 18:43:13 2003
@@ -586,6 +586,7 @@ static struct pci_fixup pci_fixups[] __i
 	 * instead of 0x01.
 	 */
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_TOSHIBA,	0x605,				quirk_transparent_bridge },
 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master },
 
