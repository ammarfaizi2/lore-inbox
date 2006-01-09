Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWAISZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWAISZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWAISZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:25:27 -0500
Received: from cantor2.suse.de ([195.135.220.15]:6379 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964911AbWAISZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:25:26 -0500
To: Stan Gammons <s_gammons@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64 bit kernel
References: <1136780835.6695.37.camel@falklands.home.pc>
From: Andi Kleen <ak@suse.de>
Date: 09 Jan 2006 19:25:21 +0100
In-Reply-To: <1136780835.6695.37.camel@falklands.home.pc>
Message-ID: <p738xtpxnqm.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stan Gammons <s_gammons@charter.net> writes:

First you get the price of the day for meaningless subjects. Gratulations.

> I was wondering if anyone can tell me if the following is a 64 bit
> kernel problem or if it's a BIOS problem.
> 
> I have a Gigabyte K8NSC-939 with an AMD64 3200+ (Venice) CPU version F7
> BIOS. When I first got this board, I put a single 512 Mb PC2700 DIMM in
> it from an older Celeron board I had. 32 bit Suse 10.0 and 32 bit FC4
> loaded fine. When I tried the 64 bit version of either, I kept getting
> DMA errors on boot like the HD or controller was bad. After some
> searching I found others with similar problems and they had to use
> "noapic nolapic" kernel boot options to install and boot the OS. That
> worked for me too and I was able to install the OS.

That's usually an ACPI problem. Put full boot log of the failure
and acpidmp output into bugzilla.kernel.org

The difference between 32bit and 64bit distro is that the later
use the APIC by default so they are more sensitive to ACPI issues.

> 
> After I upgraded the memory and put 2 512Mb PC3200 DIMMS in the board. I
> tried a 64 bit install again. This time I no longer had to use the
> "noapic nolapic" options. With a single DIMM, BIOS (during boot)
> reported "single channel" memory. With 2 DIMMS, BIOS (during boot)
> reports "dual channel" memory. My question though is does the 64 bit
> kernel require "dual channel" memory or is this a BIOS problem?  

That sounds weird. Most likely a BIOS problem of some sort.

Dual or single channel memory shouldn't make a difference to the kernel.
 
-Andi
