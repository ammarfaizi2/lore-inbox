Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVCLEdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVCLEdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 23:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVCLEdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 23:33:41 -0500
Received: from meetpoint.leesburg-geeks.org ([66.63.28.250]:18703 "EHLO
	meetpoint.home") by vger.kernel.org with ESMTP id S261895AbVCLEd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 23:33:28 -0500
Date: Fri, 11 Mar 2005 23:33:33 -0500 (EST)
From: Ken Ryan <linuxryan@leesburg-geeks.org>
To: linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
Message-ID: <Pine.LNX.4.21.0503112259140.4924-100000@meetpoint.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  Fri Mar 11 2005 - 18:30:03 EST Bjorn Helgaas wrote:

> On Sat, 2005-03-12 at 09:43 +1100, Paul Mackerras wrote:
> > On PPC/PPC64 machines, the host bridges generally do not appear as PCI
> > devices either. *However*, the AGP spec requires a set of registers
> > in PCI config space for controlling the target (host) side of the AGP
> > bus. In other words you are required to have a PCI device to
> > represent the host side of the AGP bus, with a capability structure
> > in
> > its config space which contains the standard AGP registers.
> 
> I still don't quite understand this. If the host bridge is not a
> PCI device, what PCI device contains the AGP capability that controls
> the host bridge? I assume you're saying that you are required to
> have TWO PCI devices that have the AGP capability, one for the AGP
> device and one for the bridge.


Note that the PPC processor bus can connect to multiple
"north bridges" (or other PPCs) at the same time.  It's
not a point-to-point bus.  It sounds like the AGP bridge
in question sits directly on the processor bus, in which 
case there would not necessarily be any equivalent to the
PCI configuration registers for the bridge itself.

Does anyone know offhand what part number this AGP bridge is or
who makes it?

	ken


