Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966258AbWKNVAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966258AbWKNVAv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966351AbWKNVAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:00:51 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:50629 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S966258AbWKNVAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:00:51 -0500
Date: Tue, 14 Nov 2006 22:00:49 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061114210049.GB15440@rhlx01.hs-esslingen.de>
References: <EB12A50964762B4D8111D55B764A8454E0DC9D@scsmsx413.amr.corp.intel.com> <20061114203016.GA15440@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114203016.GA15440@rhlx01.hs-esslingen.de>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 14, 2006 at 09:30:17PM +0100, Andreas Mohr wrote:
> There's also some register description about APIC timer,
> maybe I'll gather something about my C2 headaches from there.

OK, offset 0x8C Host Bus Power Management Control has
(VT8235, but 8237 is same I think):
bit 0 Internal Clock Stop During Suspend (default 0)
bit 1 Internal Clock Stop During C3 (default 0) [internal PCI clock]
bit 2 Internal Clock Stop for PCI Idle (default 0)
[stop PCI clock when PCKRUN# high]

This wouldn't have anything whatsoever to do with my ACPI ""C2""
BIOS headaches, I assume??

Probably my BIOS has some of those bits tweaked to 1,
need to fiddle with pciutils a bit...

Somehow I'm getting the impression that we should have been
rewarding the BIOS with indifference all the time already in Linux,
given how *very useful* those chipset registers are...
Argh.

Burn ACPI, EFI, Real Mode, ..., let's go back to basics. :-P

Andreas Mohr
