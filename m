Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbUKRTIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbUKRTIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUKRTGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:06:16 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:55169 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262886AbUKRTCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:02:23 -0500
Date: Thu, 18 Nov 2004 19:50:32 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kernel-stuff@comcast.net, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: X86_64: Many Lost ticks
Message-ID: <20041118185032.GO17532@wotan.suse.de>
References: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net> <1100797816.6019.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100797816.6019.24.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 05:10:17PM +0000, Alan Cox wrote:
> On Iau, 2004-11-18 at 17:02, kernel-stuff@comcast.net wrote:
> > I tried all the newer kernels including -ac. All have the same problem.
> > 
> > Andi -  On a side note, your change  "NVidia ACPI timer override" present in 2.6.9-ac8 breaks on my laptop - I get some NMI errors ("Do you have a unusual power management setup?") and DMA timeouts - happens regularly.
> 
> Ok ACPI timer override probably goes back into the broken bucket and out
> of -ac in -ac11 then.

The timer override should be fine (I have confirmation from Nvidia
about this). The only thing that you can take out if you're conservative
is the change to not disable the IOAPIC by default when Nvidia 
is detected (in check_ioapic()) 

-Andi

