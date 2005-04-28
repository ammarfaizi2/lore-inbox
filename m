Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVD1F7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVD1F7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVD1F5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:57:54 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:58119 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262150AbVD1F50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:57:26 -0400
Date: Wed, 27 Apr 2005 22:56:55 -0700
From: Greg KH <gregkh@suse.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       tony.luck@intel.com, zwane@arm.linux.org.uk, hch@infradead.org
Subject: Re: Deferred handling of writes to /proc/irq/xx/smp_affinity
Message-ID: <20050428055655.GB11236@suse.de>
References: <20050427221538.A30702@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427221538.A30702@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 10:15:38PM -0700, Ashok Raj wrote:
> Hi Andrew and all
> 
> It is safe to re-program rte entries in ioapic only when an intr is pending. 
> Existing code does this incorrectly by reprogamming rte entries immediatly
> when a value is written to /proc/irq/xx/smp_affinity. IRQ_BALANCE code in 
> kernel does this right, but /proc/irq needs to be handled the same way so that 
> user mode irq_balancer wont lock up systems or loose interrupts in the race.
> 
> This is already fixed in ia64, introduced for i386 and x86_64.
> 
> since this touches 3 arch's managing in -mm for trial would be best to make
> sure nothing is broken, before considering for main line.

The pci/msi stuff looks fine with me, as long as you've tested it out (I
have no msi hardware...)

thanks,

greg k-h
