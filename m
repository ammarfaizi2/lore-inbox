Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbVHKVmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVHKVmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVHKVmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:42:18 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:49637 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750950AbVHKVmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:42:17 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 15:42:07 -0600
User-Agent: KMail/1.8.1
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
References: <200508111424.43150.bjorn.helgaas@hp.com> <200508111445.41428.bjorn.helgaas@hp.com> <42FBBB6F.1030306@pobox.com>
In-Reply-To: <42FBBB6F.1030306@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111542.07851.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 August 2005 2:56 pm, Jeff Garzik wrote:
> Bjorn Helgaas wrote:
> > On Thursday 11 August 2005 2:36 pm, Jeff Garzik wrote:
> >>Bjorn Helgaas wrote:
> >>> config IDE_GENERIC
> >>> 	tristate "generic/default IDE chipset support"
> >>>+	depends on !IA64
> >>
> >>hmmmmmmmmm.  Are you POSITIVE that the legacy IDE ports are never enabled?
> >>
> >>In modern Intel chipsets, this still occurs with e.g. combined mode.
> > 
> > I don't know about combined mode.  If the legacy IDE ports are
> > enabled, shouldn't they be described via ACPI, and hence usable
> > via the ide_pnp - PNPACPI - ACPI path?
> 
> No idea...  that's more for platform IA64 people to answer :/

OK, well, I assert that failure to describe an IDE device that
uses legacy ports would be an ACPI defect.

Tony, others, does this change give you any heartburn?  On
the 460GX and 870 boxes I have, IDE is a PCI device.

(I have been told that the SGI ia64 simulator depends on
IDE_GENERIC.  But it really should make the IDE device
appear in PCI (or describe it via ACPI)).
