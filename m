Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVF2Q3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVF2Q3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVF2Q3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:29:10 -0400
Received: from colo.lackof.org ([198.49.126.79]:31420 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261564AbVF2Q3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:29:01 -0400
Date: Wed, 29 Jun 2005 10:33:10 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       rajesh.shah@intel.com
Subject: Re: [PATCH] acpi bridge hotadd: ACPI based root bridge hot-add
Message-ID: <20050629163310.GA4753@colo.lackof.org>
References: <11199367713428@kroah.com> <11199367721003@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11199367721003@kroah.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 10:32:52PM -0700, Greg KH wrote:
> [PATCH] acpi bridge hotadd: ACPI based root bridge hot-add
> 
> When you hot-plug a (root) bridge hierarchy, it may have p2p bridges and
> devices attached to it that have not been configured by firmware.  In this
> case, we need to configure the devices before starting them.  This patch
> separates device start from device scan so that we can introduce the
> configuration step in the middle.

PA-RISC must have been doing this before somehow.
All PARISC boxen with PAT PDC firmware (A500/N- and L-Class) 
have to deal with unconfigured PCI Bus devices at boot time.
But I also have to confess I know PCI-PCI Bridge support is broken
on those boxes for the past year... /o\
(system will hard fail/crash if a PCI-PCI Bridge is installed)
Normal add-on PCI cards get configured properly AFAICT. 

"Card-mode" Dino boxen also have to deal with unconfigured PCI devices.
Just PCI-PCI bridges are never below a card-mode Dino.
(Alternative is "built-in" dino - firmware initializes everything
in this case including PCI-PCI Bridges.)


> Also, I have no way of testing the changes I made to the parisc files, so this
> needs review by those folks.  Sorry for the massive cross-post, this touches
> files in many different places.

That's fine...I'll clean it up when I get into ottawa in July and have
reliable bandwidth. Thanks for the heads up.

grant
