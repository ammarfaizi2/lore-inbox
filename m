Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbUKLTjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbUKLTjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUKLTjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:39:07 -0500
Received: from mms2.broadcom.com ([63.70.210.59]:64518 "EHLO mms2.broadcom.com")
	by vger.kernel.org with ESMTP id S262528AbUKLTgc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:36:32 -0500
X-Server-Uuid: 011F2A72-58F1-4BCE-832F-B0D661E896E8
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] pci-mmconfig fix for 2.6.9
Date: Fri, 12 Nov 2004 11:23:06 -0800
Message-ID: <B1508D50A0692F42B217C22C02D84972020F3C9C@NT-IRVA-0741.brcm.ad.broadcom.com>
Thread-Topic: [PATCH] pci-mmconfig fix for 2.6.9
Thread-Index: AcTI5oPRYpJCJDHjRjWtyCKDJbcJQAABQL9g
From: "Michael Chan" <mchan@broadcom.com>
To: "Grant Grundler" <grundler@parisc-linux.org>
cc: "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
X-WSS-ID: 6D8BD0D01PO7381915-587-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004, 11:35:47 -0700, Grant Grundler wrote:

> Michael,
> Thanks for digging that up.
> I think Andi was looking for references to the PCI-E spec.
> I found such a statement in "PCI Express(TM) Base 
> Specification Revision 1.0a".
> 

Hi Grant,

I think it is well documented that config cycles are non-posted in PCI,
PCIX, and PCI Express specs as you pointed out. The only ambiguity is
whether the mmconfig memory cycle from the CPU to the chipset is posted
or not. The Implementation Note in the MMCONFIG ECN from pcisig (link
below) allows the mmconfig write cycle to be posted, meaning mmconfig
write cycle can complete before the real config write cycle completes.
That's why we needed confirmations from chipset engineers.

Michael

http://www.pcisig.com/specifications/pciexpress/specifications/specifica
tions

