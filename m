Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312409AbSDNS1x>; Sun, 14 Apr 2002 14:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312412AbSDNS1x>; Sun, 14 Apr 2002 14:27:53 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:21643 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S312409AbSDNS1w>; Sun, 14 Apr 2002 14:27:52 -0400
Date: Sun, 14 Apr 2002 11:27:36 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-pre3 full compile - warnings
Message-ID: <2425212891.1018783655@[10.10.2.3]>
In-Reply-To: <1605.1018774441@ocs3.intra.ocs.com.au>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Although everything compiled, it did not link because of missing symbols.
> 
> arch/i386/kernel/pci-pc.o: In function `pci_conf1_read':
> arch/i386/kernel/pci-pc.o(.text+0xa3): undefined reference to
> `mp_bus_id_to_local' arch/i386/kernel/pci-pc.o: In function
> `pci_conf1_write':
> arch/i386/kernel/pci-pc.o(.text+0x2c3): undefined reference to
> `mp_bus_id_to_local' arch/i386/kernel/pci-pc.o: In function
> `pci_fixup_i450nx':
> arch/i386/kernel/pci-pc.o(.text+0x1c01): undefined reference to
> `quad_local_to_mp_bus_id' arch/i386/kernel/pci-pc.o(.text+0x1c28):
> undefined reference to `quad_local_to_mp_bus_id'
> arch/i386/kernel/pci-pc.o: In function `pcibios_init':
> arch/i386/kernel/pci-pc.o(.text.init+0xbd): undefined reference to
> `quad_local_to_mp_bus_id' drivers/video/neofb.o: In function
> `neofb_setup':

Looks like someone screwed up arch/i386/kernel/mpparse.c 
between pre2 and pre3 - at a glance, it looked like someone
took an old version of the file without my changes to support
multi-quad PCI on NUMA-Q, and hacked it forward without changing
it properly ... 

Martin.

