Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbUAHMMa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUAHMMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:12:30 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:50445 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264340AbUAHMM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:12:29 -0500
Date: Thu, 8 Jan 2004 12:12:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Meadors <clubneon@hereintown.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: MegaRAID on AMD64 under 2.6.1
Message-ID: <20040108121227.B8987@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Meadors <clubneon@hereintown.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1073512887.8211.39.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1073512887.8211.39.camel@clubneon.priv.hereintown.net>; from clubneon@hereintown.net on Wed, Jan 07, 2004 at 05:01:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 05:01:28PM -0500, Chris Meadors wrote:
> I seem to recall some discussion reguarding the MegaRAID driver use on
> AMD64 machines with large amounts of RAM.  My machine only has 2 GB of
> RAM, and the driver was working fine under 2.6.0 (note I use Andi
> Kleen's x86_64 patch kit, on an otherwise stock kernel).  But with the
> release of 2.6.1-rc1 the driver does not load.  I have module support
> disabled and all needed drivers built into the kernel.  All my file
> systems (including root) are on logical drives provided by the RAID
> controller.  So the kernel panics when attempting to mount the root
> filesystem, if the driver doesn't load.
> 
> Looking through the 2.6.1-rc2 patch, it seems that the megaraid.[ch]
> files got some large amount of re-ordering.  So I can't easily spot what
> change might have effected the driver.
> 
> Here is the lspci output for my specific card:

Can you put a printk into megaraid_probe_one() whether that one actually
gets called?

Also lspci -n output would be very nice to have.

