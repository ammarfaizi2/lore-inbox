Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWBGLDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWBGLDd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWBGLDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:03:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8671 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965012AbWBGLDc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:03:32 -0500
Subject: Re: libATA  PATA status report, new patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060207084347.54CD01430C@rhn.tartu-labor>
References: <20060207084347.54CD01430C@rhn.tartu-labor>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Feb 2006 11:05:34 +0000
Message-Id: <1139310335.18391.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-07 at 10:43 +0200, Meelis Roos wrote:
> Tried in Qemu with virtual PIIX3. Compiled in PIIX, OLDPIIX, MPIIX and
> Generic. Enabled PATA support for libata in libata.h. Disabled
> everything in ATA/IDE Kconfig menu.
> 
> ata1: PATA max PIO4 cmd 0x1F0 ctl 0x3F6 bmdma 0x0 irq 15
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:

Very strange trace indeed. I'll take a look at this. At least since it
came from Qemu I should be able to "build" a suitable PC to match yours.

Original Intel PIIX devices are handled by "OLDPIIX" (0x8086, 0x1230).
The later ones by ata_piix. The only oddity I see is that you have no
PCI bus mastering address base assigned (bmdma)

Alan


