Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSKDR74>; Mon, 4 Nov 2002 12:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSKDR74>; Mon, 4 Nov 2002 12:59:56 -0500
Received: from fmr02.intel.com ([192.55.52.25]:30973 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262416AbSKDR74>; Mon, 4 Nov 2002 12:59:56 -0500
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF73@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Adam J. Richter'" <adam@yggdrasil.com>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: Patch: 2.5.45 PCI Fixups for PCI HotPlug
Date: Mon, 4 Nov 2002 10:06:28 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Greg KH wrote:
> >Hm, in looking at this, I know the majority of people who want
> >CONFIG_HOTPLUG probably do not run with CONFIG_PCI_HOTPLUG as the
> >hardware's still quite rare.  To force those people to keep 
> around all
> >of the PCI quirks functions and tables after init happens, is a bit
> >cruel.  I wonder if it's time to start having different subsystems
> >modify __devinit depending on their config variables.
> 
> 	Are there PCI bridge cards that use all of those?  For
> example, I thought that Triton was a series of Intel motherboard
> chipsets for 586 processors.  Perhaps you only need to keep a
> few of those routines.
> 
> 	Jung-Ik: perhaps you could to an lspci and an "lspci -n" on
> your machine when the bridge card is plugged in, which should provide
> enough information to determine which routines you really need to
> keep.

That sounds a quick fix for now but Greg's __pci_devinit seems to be the
right solution.

thanks,
J.I.
