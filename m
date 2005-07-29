Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVG2W3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVG2W3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVG2W0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:26:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262902AbVG2WZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:25:02 -0400
Date: Fri, 29 Jul 2005 15:26:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jason.d.gaston@intel.com, mj@ucw.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
Message-Id: <20050729152648.2c2fe390.akpm@osdl.org>
In-Reply-To: <42EAABD1.8050903@pobox.com>
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410>
	<42EAABD1.8050903@pobox.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> [speaking to the audience]  I wouldn't mind if someone did a pass 
> through pci_ids.h and removed all the constants that are not being used. 
>   If constants are not being used, it's IMHO more appropriate to store 
> that info in pci.ids.

It looks like Greg is planning on nuking pci.ids.


>From owner-linux-pci@atrey.karlin.mff.cuni.cz Sat Jul 16 21:07:30 2005
Date: Sun, 17 Jul 2005 04:22:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: mj@ucw.cz
Subject: PCI: remove CONFIG_PCI_NAMES
Message-ID: <20050717022220.GC3613@stusta.de>

This patch removes CONFIG_PCI_NAMES.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/feature-removal-schedule.txt |    9 
 MAINTAINERS                                |    7 
 arch/alpha/kernel/sys_marvel.c             |    5 
 arch/ppc64/kernel/eeh.c                    |   31 
 arch/ppc64/kernel/iSeries_VpdInfo.c        |    5 
 arch/ppc64/kernel/pci.c                    |    1 
 drivers/char/drm/drmP.h                    |    4 
 drivers/infiniband/hw/mthca/mthca_main.c   |    8 
 drivers/infiniband/hw/mthca/mthca_reset.c  |    8 
 drivers/net/irda/vlsi_ir.h                 |    6 
 drivers/pci/Kconfig                        |   17 
 drivers/pci/Makefile                       |   18 
 drivers/pci/gen-devlist.c                  |  132 
 drivers/pci/names.c                        |  137 
 drivers/pci/pci.ids                        |10180 -----------------------------
 drivers/pci/probe.c                        |    2 
 drivers/pci/proc.c                         |   12 
 drivers/usb/core/hcd-pci.c                 |    4 
 drivers/video/nvidia/nvidia.c              |    4 
 drivers/video/riva/fbdev.c                 |    4 
 include/linux/pci.h                        |   14 
 21 files changed, 32 insertions(+), 10576 deletions(-)

