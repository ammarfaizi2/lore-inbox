Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310366AbSCKSOC>; Mon, 11 Mar 2002 13:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310333AbSCKSNy>; Mon, 11 Mar 2002 13:13:54 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:28938 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S310331AbSCKSNp>; Mon, 11 Mar 2002 13:13:45 -0500
Date: Mon, 11 Mar 2002 19:04:33 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jay Estabrook <Jay.Estabrook@compaq.com>
Cc: Kurt Garloff <garloff@suse.de>, Jochen Friedrich <jochen@scram.de>,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Subject: Re: Busmaster DMA broken in 2.4.18 on Alpha
Message-ID: <20020311190433.A16552@jurassic.park.msu.ru>
In-Reply-To: <Pine.NEB.4.33.0203111049580.1675-100000@www2.scram.de> <20020311124511.J2346@nbkurt.etpnet.phys.tue.nl> <20020311171058.A9038@jurassic.park.msu.ru> <20020311100200.A1181@linux04.mro.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020311100200.A1181@linux04.mro.cpqcorp.net>; from Jay.Estabrook@compaq.com on Mon, Mar 11, 2002 at 10:02:00AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 10:02:00AM -0500, Jay Estabrook wrote:
> There are ISA cards, regardless of what ISA bus machine they are
> plugged into, that are able to generate only something less than
> 32-bits worth of address.

Indeed, I missed that.

> Since ISA devices don't have pci_dev structures, there's (currently)
> no way to pass an ISA device-dependent DMA mask to the IOMMU routines.
> Perhaps there needs to be an addition to the API that would allow
> for this (pci_set_isa_device_dma_mask()) ???

Yes, it would be nice to have something like this.

Another workaround also seems to be possible - for ISA devices
use mask other than 0x00ffffff _only_ if we don't have working
IOMMU. This doesn't help to get older Miatas work with such
type of ISA cards though...

Ivan.
