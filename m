Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUF0D1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUF0D1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 23:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUF0D1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 23:27:24 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:64391 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S267249AbUF0D04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 23:26:56 -0400
Date: Sat, 26 Jun 2004 20:26:48 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Matt Sexton <sexton@mc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DRAM and PCI devices at same physical address
Message-ID: <20040626202648.B29650@home.com>
References: <1088198580.29697.62.camel@dhcp_client-120-140>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1088198580.29697.62.camel@dhcp_client-120-140>; from sexton@mc.com on Fri, Jun 25, 2004 at 05:23:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 05:23:00PM -0400, Matt Sexton wrote:
> I have a dual Xeon system with the Lindenhurst (E7710) chip set and 1 GB
> of memory.  In order to reserve a very large block of memory for a
> (user-space) device driver I am writing, I pass "mem=XX" to the kernel
> at boot time.  Unfortunately, /proc/pci shows two devices now appearing
> in the reserved upper memory range.  

<snip>
 
> The devices always appear right after the limit I specify on the kernel
> boot line.  If I specify "mem=512M", then the first device appears at
> 0x20000000.  If I specify nothing, then it appears at 0x40000000.  All
> other PCI devices show up at addresses of 0xDD000000 and above.
> 
> Is there any way to prevent these devices from showing up in the
> physical address range of my reserved memory?

You could try using reserve_bootmem() to reserve your driver memory.

> Should they be appearing there at all?  Does Linux make any guarantees
> when there is more physical memory than specified by "mem=" ?

Depends on the arch, I don't know what ia32 does.
 
-Matt
