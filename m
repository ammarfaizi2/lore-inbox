Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWI0Lrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWI0Lrp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWI0Lrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:47:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:189 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750929AbWI0Lro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:47:44 -0400
Subject: Re: [PATCH 2.6.18] IA64: Add pci_fixup_video into IA64 kernel for
	embedded VGA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: eiichiro.oiwa.nm@hitachi.com
Cc: Jesse Barnes <jesse.barnes@intel.com>, akpm@osdl.org, tony.luck@intel.com,
       greg@kroah.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002684U451a5f21@hitachi.com>
References: <XNM1$9$0$4$$3$3$7$A$9002684U451a5f21@hitachi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Sep 2006 13:12:15 +0100
Message-Id: <1159359135.11049.341.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-27 am 20:23 +0900, ysgrifennodd
eiichiro.oiwa.nm@hitachi.com:
> I moved pci_fixup_video to generic location (driver/pci/quirks.c).
> I tested generic fixup_video on x86, x86_64 and IA64, and confirmed
> we can read Video BIOS from the sysfs rom with embedded VGA.

Lots of embedded systems don't have a PCI bios in the usual sense, and
cannot run the x86 code in the ROM firmware either. That doesn't appear
to be a big problem when setting PCI_ROM_SHADOW but those platforms may
not all be able to access the shadow rom if one exists.

Can you fix the comment in drivers/pci/rom.c to reflect the changes.

Otherwise looks good.

Alan



