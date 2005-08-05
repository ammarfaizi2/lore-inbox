Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262979AbVHERXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbVHERXG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbVHERWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:22:34 -0400
Received: from fmr18.intel.com ([134.134.136.17]:4487 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262979AbVHERUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:20:25 -0400
Subject: Re: [PATCH] 6700/6702PXH quirk
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, rajesh.shah@intel.com
In-Reply-To: <200508051112.04652.bjorn.helgaas@hp.com>
References: <1123259263.8917.9.camel@whizzy>
	 <200508051112.04652.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 10:20:07 -0700
Message-Id: <1123262407.8917.19.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 05 Aug 2005 17:20:08.0616 (UTC) FILETIME=[EDCB9280:01C599E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 11:12 -0600, Bjorn Helgaas wrote:
> On Friday 05 August 2005 10:27 am, Kristen Accardi wrote:
> > On the 6700/6702 PXH part, a MSI may get corrupted if an ACPI hotplug
> > driver and SHPC driver in MSI mode are used together.  This patch will
> > prevent MSI from being enabled for the SHPC.  
> 
> Can you outline the scenario that causes the corruption?  This patch
> feels like a band-aid over a deeper problem.

This is a workaround to a hardware problem.  If a MSI interrupt occurs
while the ACPI driver is doing a config read of the hotplug capabilities
register, the MSI interrupt will be corrupted, and the MSI interrupt
will never make it to the MCH.  This causes the hotplug device to not be
recognized.
