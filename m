Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312418AbSDNTEz>; Sun, 14 Apr 2002 15:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312419AbSDNTEy>; Sun, 14 Apr 2002 15:04:54 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:29706 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312418AbSDNTEx>;
	Sun, 14 Apr 2002 15:04:53 -0400
Date: Sun, 14 Apr 2002 11:04:33 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-pre3 full compile - warnings
Message-ID: <20020414180433.GB18238@kroah.com>
In-Reply-To: <1605.1018774441@ocs3.intra.ocs.com.au> <2425212891.1018783655@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 17 Mar 2002 15:53:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 11:27:36AM -0700, Martin J. Bligh wrote:
> > Although everything compiled, it did not link because of missing symbols.
> > 
> > arch/i386/kernel/pci-pc.o: In function `pci_conf1_read':
> > arch/i386/kernel/pci-pc.o(.text+0xa3): undefined reference to
> > `mp_bus_id_to_local' arch/i386/kernel/pci-pc.o: In function
> > `pci_conf1_write':
> > arch/i386/kernel/pci-pc.o(.text+0x2c3): undefined reference to
> > `mp_bus_id_to_local' arch/i386/kernel/pci-pc.o: In function
> > `pci_fixup_i450nx':
> > arch/i386/kernel/pci-pc.o(.text+0x1c01): undefined reference to
> > `quad_local_to_mp_bus_id' arch/i386/kernel/pci-pc.o(.text+0x1c28):
> > undefined reference to `quad_local_to_mp_bus_id'
> > arch/i386/kernel/pci-pc.o: In function `pcibios_init':
> > arch/i386/kernel/pci-pc.o(.text.init+0xbd): undefined reference to
> > `quad_local_to_mp_bus_id' drivers/video/neofb.o: In function
> > `neofb_setup':
> 
> Looks like someone screwed up arch/i386/kernel/mpparse.c 
> between pre2 and pre3 - at a glance, it looked like someone
> took an old version of the file without my changes to support
> multi-quad PCI on NUMA-Q, and hacked it forward without changing
> it properly ... 

In looking at the changesets, it seems that the offending party is the
ACPI group.  I'd go complain to them :)

greg k-h
