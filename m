Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVFZTRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVFZTRo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFZTRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:17:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261575AbVFZTRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:17:40 -0400
Date: Sun, 26 Jun 2005 12:17:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: greg@kroah.com, rajesh.shah@intel.com, linux-kernel@vger.kernel.org
Subject: Re: ACPI-based PCI resources: PCMCIA bugfix, but resources missing
 in trees
Message-Id: <20050626121710.44c1df8d.akpm@osdl.org>
In-Reply-To: <20050626140411.GA8597@dominikbrodowski.de>
References: <20050626040329.3849cf68.akpm@osdl.org>
	<20050626140411.GA8597@dominikbrodowski.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski <linux@dominikbrodowski.net> wrote:
>
> On Sun, Jun 26, 2005 at 04:03:29AM -0700, Andrew Morton wrote:
>  > - Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
>  >   the recent PCI breakage sorted out.
> 
>  pci-yenta-cardbus-fix.patch and the following patch should solve the
>  initialization time trouble. However, the ACPI-based PCI resource handling
>  is badly broken, IMHO:
> 
>  - many resources of devices don't show up in the resource trees (
>    /proc/iomem and /proc/ioports) any longer. This means that PCMCIA, but
>    also possibly other subsystems (ISA, PnP, ...) do not know which resources
>    it cannot use.

Is this a recent regression?  Is it only in -mm?

IOW: can you identify the bad patch?  Or the bad patcher ;)

>  - verify_root_windows() should fail if there are no iomem _or_ ioport
>    resources, not only if there are no iomem _and_ ioport resources.

This too.
