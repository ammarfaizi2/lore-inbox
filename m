Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUJAWaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUJAWaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUJAW1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:27:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:40898 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266352AbUJAWZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:25:52 -0400
Date: Fri, 1 Oct 2004 15:25:17 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, dely.l.sy@intel.com
Cc: sgala@apache.org, linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.8-rc2-mm4 does not link (PPC)
Message-ID: <20041001222517.GB4464@kroah.com>
References: <20041001010818.6a6e2fca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001010818.6a6e2fca.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like a trivial error: a structure used in PCI architecture
> independent code (quirks.c) gets defined (only) in i386 architecture
> (raw_pci_ops). I'm not an expert and cannot help to define this under
> ppc arch:
> 
> drivers/built-in.o(.text+0x350a): In function `quirk_pcie_aspm_read':
> : undefined reference to `raw_pci_ops'
> drivers/built-in.o(.text+0x351e): In function `quirk_pcie_aspm_read':
> : undefined reference to `raw_pci_ops'
> drivers/built-in.o(.text+0x3566): In function `quirk_pcie_aspm_write':
> : undefined reference to `raw_pci_ops'
> drivers/built-in.o(.text+0x35a6): In function `quirk_pcie_aspm_write':
> : undefined reference to `raw_pci_ops'
> make: *** [.tmp_vmlinux1] Error 1
> 
> I sent a typo for rc2-mm2. Just to report that it never booted after
> the typo was corrected. hard freeze.

Dely, we need to move this quirk to i386 specific code.  Will we also
have to do this for the x86-64 platform too?

Care to send a patch to fix this?

thanks,

greg k-h
