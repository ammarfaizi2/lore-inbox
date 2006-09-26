Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWIZPsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWIZPsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWIZPsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:48:15 -0400
Received: from mga03.intel.com ([143.182.124.21]:29604 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751528AbWIZPsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:48:13 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,221,1157353200"; 
   d="scan'208"; a="123180012:sNHT52280865"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 2.6.18] IA64: Add pci_fixup_video into IA64 kernel for embedded VGA
Date: Tue, 26 Sep 2006 08:48:53 -0700
User-Agent: KMail/1.9.4
Cc: eiichiro.oiwa.nm@hitachi.com, akpm@osdl.org, tony.luck@intel.com,
       greg@kroah.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <XNM1$9$0$4$$3$3$7$A$9002681U4518d9f9@hitachi.com> <200609260909.12876.bjorn.helgaas@hp.com>
In-Reply-To: <200609260909.12876.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609260848.53556.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 26, 2006 8:09 am, Bjorn Helgaas wrote:
> On Tuesday 26 September 2006 01:42, eiichiro.oiwa.nm@hitachi.com wrote:
> > To be compatible with Xorg's handling of PCI, we need pci_fixup_video
> > on IA64 platform like x86 platform. There are also machines, which
> > have VGA embedded into main board, among IA64 platform. Embedded VGA
> > generally don't have PCI ROM, and there are VGA ROM image in System
> > BIOS. Therefore, these machines need pci_fixup_video for the sysfs
> > rom. pci_fixup_video already exists in x86 Linux kernel. However since
> > this function doesn't exist in IA64 kernel, we could not run X server
> > on IA64 box has embedded-VGA.
> >
> > I tested pci_fixup_video on IA64 box has embedded-VGA. I confirmed we
> > can read VGA BIOS from the sysfs rom regardless of embedded-VGA.
>
> What other architectures will need this?  There's nothing ia64-specific
> in the patch below.  Can it be put somewhere more generic?

It could go into drivers/pci, but setting the flag implies that the ROM is 
at 0xc0000, so it does have some arch dependencies (though at least x86, 
x86_64 and ia64 have machines that do this).

Jesse
