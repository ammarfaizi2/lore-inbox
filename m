Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTATQYU>; Mon, 20 Jan 2003 11:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTATQYU>; Mon, 20 Jan 2003 11:24:20 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:2320 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266175AbTATQYT>; Mon, 20 Jan 2003 11:24:19 -0500
Date: Mon, 20 Jan 2003 16:33:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: propagating failures down to pci_module_init()
Message-ID: <20030120163321.A32585@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030120155435.GA29238@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030120155435.GA29238@codemonkey.org.uk>; from davej@codemonkey.org.uk on Mon, Jan 20, 2003 at 03:54:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 03:54:35PM +0000, Dave Jones wrote:
> I've got a wierd situation with a certain chipset for agpgart.
> There are a few cases where I want to be able to use the existing
> pci_driver api to detect the right PCI device, and call
> the relevant .probe routine. No problem there.
> 
> The problem is that in these cases, I want to be able to read
> a certain register in that device, and if a bit is 0, bail out
> of the .probe function with -ENODEV, and make the loading of
> the module fail.
> 
> The problem is that the ENODEV in my .probe routine doesn't
> propagate back down as far as pci_module_init().
> 
> Ideas ?

Just use pci_register_driver.

