Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUFVS2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUFVS2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUFVSUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:20:00 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:15689 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265045AbUFVRxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:53:47 -0400
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Question on using MSI in PCI driver
X-Message-Flag: Warning: May contain useful information
References: <C7AB9DA4D0B1F344BF2489FA165E5024057E4E7B@orsmsx404.amr.corp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 22 Jun 2004 10:49:32 -0700
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024057E4E7B@orsmsx404.amr.corp.intel.com> (Tom
 L. Nguyen's message of "Tue, 22 Jun 2004 08:24:02 -0700")
Message-ID: <52llifo53n.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 17:49:32.0694 (UTC) FILETIME=[4650C360:01C45881]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Tom> The PCI 3.0 specification has implementation notes that MMIO
    Tom> address space for a device's MSI-X structure should be
    Tom> isolated so that the software system can set different page
    Tom> for controlling accesses to the MSI-X structure. The
    Tom> implementation of MSI patch requires the PCI subsystem, not a
    Tom> device driver, to maintain full control of the MSI-X
    Tom> table/MSI-X PBA and MMIO address space of the MSI-X
    Tom> table/MSI-X PBA. A device driver is prohibited from
    Tom> requesting the MMIO address space of the MSI-X table/MSI-X
    Tom> PBA. Otherwise, the PCI subsystem will fail enabling MSI-X on
    Tom> its hardware device when it calls the function
    Tom> pci_enable_msi().

Thanks.  I guess for the time being I will have to split up my request
region calls.

Do you think the msi subsystem should use a different name for the
MSI-X memory region ("MSI-X iomap Failure" seems very strange to me).

 - Roland
