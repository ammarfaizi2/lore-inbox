Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbVKDGnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbVKDGnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 01:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbVKDGnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 01:43:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:10952 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161086AbVKDGnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 01:43:52 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131029686.18848.48.camel@localhost.localdomain>
References: <1131029686.18848.48.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 17:43:05 +1100
Message-Id: <1131086585.4680.235.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 14:54 +0000, Alan Cox wrote:
> Core Features Fixed
> - Per drive tuning
> - Filter quirk lists
> - Single channel support
> 
> And To Add
> - Specify PCI bus speed

Please, do the above such a way that we can have an arch hook for the
bus speed. It's actually not uncommon to have several busses with
different speeds in a machine. In addition, I've seen IDE drivers
calculating based on the bus speed while the HW apparently used a clock
source that didn't necessarily had to be ... PciClk ... Oh well...

> - HPA
> - IRQ mask

Why do we need the above at all ? It always looked to me like a gross
hack but then, I don't fully understand what the problem was on those
old x86 that needed it :)

> AEC62xx
> ATIIXP
> CMD64x
> CY82C693
> IT8172
> NS87415
> OPTI621
> PDC202xx
> SGI IOC4
> SIS5513
> SL82C105
> SLC90E66
> TRM290
> PCMCIA (needs hotplug merge first)

Add ppc/pmac.c but its up to me to do it :)

Ben.


