Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVCVBLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVCVBLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVCVBK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:10:27 -0500
Received: from fmr20.intel.com ([134.134.136.19]:51387 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262258AbVCVBHJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:07:09 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/Patch 0/12] ACPI based root bridge hot-add
Date: Mon, 21 Mar 2005 17:06:47 -0800
Message-ID: <468F3FDA28AA87429AD807992E22D07E04A3DDC9@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/Patch 0/12] ACPI based root bridge hot-add
Thread-Index: AcUuQIGV+3nfat58RryRsFcW1r2mwgAN19BA
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Shah, Rajesh" <rajesh.shah@intel.com>, "Greg KH" <gregkh@suse.de>
Cc: <linux-pci@atrey.karlin.mff.cuni.cz>, <linux-kernel@vger.kernel.org>,
       <pcihpd-discuss@lists.sourceforge.net>, <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 22 Mar 2005 01:06:48.0880 (UTC) FILETIME=[6CA90B00:01C52E7B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 21, 2005 10:05 AM, Rajesh Shah wrote:
> On Fri, Mar 18, 2005 at 09:13:32PM -0800, Greg KH wrote:
> > 	- Does this break the i386 acpiphp functionality?

> Dely Sy had tested hotplug with an earlier version of my patches
> (with minor differences from the current series) on i386 and it
> worked fine. She probably hasn't tested the latest one. Dely,
> could you check that please? 

I tested an earlier version of this patch on my i386 system with
PCI Express hot-plug slots.  The i386 acpiphp functionality worked
fine - i.e. I was able to do hot-plug of single- & multi-function 
cards.  

I'll check this new patch on my system.

> > 	- Have you tested other pci hotplug systems with this patch
> > 	  series?  Like pci express hotplug, standard pci hotplug,
> > 	  cardbus, etc?

> No, because I the one system I have access to isn't doing any
> hot-plug. I'm working on fixing that but was also hoping to hear
> from others who surely have access to more machines than I do.

PCI Express hot-plug has been tried (see above).  The original 
acpiphp driver won't detect hot-pluggable slots that locate on the
p2p bridge (PCI Express to PCI/PCI-X bridge) behind another p2p 
bridge (root port).  Therefore, the acpiphp can't be used for
standard PCI hot-plug in my system.

Thanks,
Dely
