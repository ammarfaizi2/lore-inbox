Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261817AbTCTTTS>; Thu, 20 Mar 2003 14:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbTCTTTS>; Thu, 20 Mar 2003 14:19:18 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261817AbTCTTTP>;
	Thu, 20 Mar 2003 14:19:15 -0500
Date: Thu, 20 Mar 2003 11:30:31 -0800
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Jes Sorensen <jes@wildopensource.com>, Jeff Garzik <garzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixup warning for acenic
Message-ID: <20030320193031.GC3315@kroah.com>
References: <14240000.1048146629@[10.10.2.4]> <m365qenioq.fsf@trained-monkey.org> <20030320160440.A14435@infradead.org> <9590000.1048176717@[10.10.2.4]> <20030320192020.GB3315@kroah.com> <413920000.1048187623@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413920000.1048187623@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 11:13:43AM -0800, Martin J. Bligh wrote:
> >> > 2.4.9 of course has the newstyle pci interface! And actual hotplug
> >> > PCI support also is in all today singnificant 2.4.9 forks (RH..).
> >> > 
> >> > There's even some shim to emulate the pci_driver style interface on
> >> > 2.2.
> >> > 
> >> > Anyway, this table has another use, it's used by userland ools like
> >> > installers for selecting the right driver for a given pci device.  So
> >> > even if it seems unused from kernelspace it has a use.
> >> 
> >> Are they kmem diving? Or parsing source code? 
> > 
> > They are looking at the modules.pcimap files which are generated from
> > depmod, which pull it from the object files.
> 
> Hmmm ... so we're going to get a compiler warning for every hotpluggable
> driver? or is this just an error in the way acenic does it?

The fact that acenic doesn't reference the structure, like other pci
drivers do, is the reason why the warning is there.  Once it switches to
use the "new"[1] pci api, the warning will go away.

thanks,

greg k-h

[1] What, isn't it like 2 years old now?
