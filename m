Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUHXRWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUHXRWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 13:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUHXRWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 13:22:52 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:48138 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S268132AbUHXRWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 13:22:49 -0400
Date: Tue, 24 Aug 2004 12:22:45 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mastergoon@gmail.com
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Message-ID: <20040824172245.GJ1078@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20040819092654.27bb9adf.akpm@osdl.org> <200408230930.18659.bjorn.helgaas@hp.com> <20040823190131.GC1303@hygelac> <200408240926.42665.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408240926.42665.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 24 Aug 2004 17:22:47.0448 (UTC) FILETIME=[F989E980:01C489FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 09:26:42AM -0600, bjorn.helgaas@hp.com wrote:
> To be pedantically clear about this, looking at pci_dev->irq before
> calling pci_enable_device() is *guaranteed* to fail, regardless of
> what the BIOS does.  So nvidia users will have to use "pci=routeirq"
> until there's a new version of the nvidia driver.

ah, ok. thanks for clarifying.

> I'm assuming your patch makes the driver call pci_enable_device()
> before using either irq or BAR information.  That's the best way
> to future-proof the driver.

yes, that's exactly what we've done.

Thanks,
Terence

