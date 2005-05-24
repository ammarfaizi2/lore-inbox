Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVEXRiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVEXRiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVEXRiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:38:00 -0400
Received: from fmr23.intel.com ([143.183.121.15]:49608 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261799AbVEXRhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:37:48 -0400
Date: Tue, 24 May 2005 10:37:25 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@suse.de>,
       len.brown@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, acpi-devel@lists.sourceforge.net,
       gregkh@suse.de
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Message-ID: <20050524103724.A22049@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de> <20050523175706.A12032@unix-os.sc.intel.com> <20050524120527.GB15326@wotan.suse.de> <20050524185856.A7639@jurassic.park.msu.ru> <20050524084533.A20567@unix-os.sc.intel.com> <20050524205855.A8367@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050524205855.A8367@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, May 24, 2005 at 08:58:55PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 08:58:55PM +0400, Ivan Kokshaysky wrote:
> On Tue, May 24, 2005 at 08:45:36AM -0700, Rajesh Shah wrote:
> > The concern here isn't just increasing the size of pci_bus. The
> > resource pointers in pci_bus point to resource structures in the
> > corresponding pci_dev structure for p2p bridges. If we want to
> > maintain this scheme, we'd have to increase the number of resources
> > in the pci_dev structure too, which increases it for every single
> > pci device in the system.
> 
> No. The pci_bus resource pointers are just pointers to _some_ resources
> and generally aren't tied to particular pci device. For example, the
> root pci buses often don't even have corresponding bus->self structure,
> and bus resources are pointers to global io[mem,port]_resource.

For the transparent p2p bridge problem you mentioned, wouldn't you
be dealing with p2p bridges, and therefore expect the pci_bus
resource pointers to point to the corresponding pci_dev resources?
Or are you proposing to decouple pci_bus resource pointers from 
pci_dev completely? From quick code inspection, that seems to be
not too much trouble to increase from 4 then.

Rajesh

