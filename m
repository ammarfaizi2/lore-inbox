Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268306AbUJDSxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268306AbUJDSxh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUJDSxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:53:37 -0400
Received: from fmr12.intel.com ([134.134.136.15]:60097 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S268306AbUJDSxU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:53:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fw: 2.6.8-rc2-mm4 does not link (PPC)
Date: Mon, 4 Oct 2004 11:52:49 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07E02C29A52@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fw: 2.6.8-rc2-mm4 does not link (PPC)
Thread-Index: AcSoBZywprSMVPEYRamMG4MtRDs24wCLNhLQ
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Greg KH" <greg@kroah.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <sgala@apache.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Oct 2004 18:52:50.0669 (UTC) FILETIME=[590BC1D0:01C4AA43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 01, 2004 3:25 PM, Greg KH wrote:
> > It looks like a trivial error: a structure used in PCI architecture
> > independent code (quirks.c) gets defined (only) in i386 architecture
> > (raw_pci_ops). I'm not an expert and cannot help to define this
under
> > ppc arch:
> 
> > drivers/built-in.o(.text+0x350a): In function
`quirk_pcie_aspm_read':
> > : undefined reference to `raw_pci_ops'
> > drivers/built-in.o(.text+0x351e): In function
`quirk_pcie_aspm_read':
> > : undefined reference to `raw_pci_ops'
> > drivers/built-in.o(.text+0x3566): In function
`quirk_pcie_aspm_write':
> > : undefined reference to `raw_pci_ops'
> > drivers/built-in.o(.text+0x35a6): In function
`quirk_pcie_aspm_write':
> > : undefined reference to `raw_pci_ops'
> > make: *** [.tmp_vmlinux1] Error 1
> >
> > I sent a typo for rc2-mm2. Just to report that it never booted after
> > the typo was corrected. hard freeze.

> Dely, we need to move this quirk to i386 specific code.  Will we also
> have to do this for the x86-64 platform too?

> Care to send a patch to fix this?

We need to have the quirk for x86-64 platform too. I'll look into moving
the quirk to architecture specific code and send out a patch.  

Thanks,
Dely

