Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbSKMMCx>; Wed, 13 Nov 2002 07:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267189AbSKMMCx>; Wed, 13 Nov 2002 07:02:53 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:22535 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267188AbSKMMCw>; Wed, 13 Nov 2002 07:02:52 -0500
Date: Wed, 13 Nov 2002 15:07:16 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: William Lee Irwin III <wli@holomorphy.com>, Greg KH <greg@kroah.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com, mochel@osdl.org
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021113150716.B1245@jurassic.park.msu.ru>
References: <20021112213906.GW23425@holomorphy.com> <177250000.1037141189@flay> <20021112215305.GZ23425@holomorphy.com> <179150000.1037145229@flay> <20021112225937.GA23425@holomorphy.com> <20021112235824.GG22031@holomorphy.com> <20021113000435.GE32274@kroah.com> <20021113001246.GC23425@holomorphy.com> <20021113002032.GF32274@kroah.com> <20021113002855.GD23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021113002855.GD23425@holomorphy.com>; from wli@holomorphy.com on Tue, Nov 12, 2002 at 04:28:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 04:28:55PM -0800, William Lee Irwin III wrote:
> On Tue, Nov 12, 2002 at 04:20:32PM -0800, Greg KH wrote:
> > Ok, then also please fix up drivers/pci/probe.c::pci_setup_device() to
> > set a unique slot_name up for the pci_dev, if you have multiple
> > domains/segments.
> > thanks,
> > greg k-h
> 
> Okay, tihs just needs the introduction of something that can produce
> a number out of ->sysdata (or whatever):

Please use existing pci_controller_num(struct pci_dev *pdev).
It does exactly that you want.

Ivan.
