Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbUCZAuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUCZAuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:50:20 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:52237
	"EHLO muru.com") by vger.kernel.org with ESMTP id S263876AbUCZArP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:47:15 -0500
Date: Thu, 25 Mar 2004 16:47:16 -0800
From: Tony Lindgren <tony@atomide.com>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel-request@lists.sourceforge.net,
       patches@x86-64.org, Andi Kleen <ak@suse.de>, pavel@ucw.cz,
       ccheney@debian.org
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Message-ID: <20040326004715.GL7967@atomide.com>
References: <20040325033434.GB8139@atomide.com> <1080260113.757.67.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080260113.757.67.camel@dhcppc4>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Len Brown <len.brown@intel.com> [040325 16:15]:
> 
> I think we need to tread carefully in this area.
> Ignoring the result of _CRS means that we really don't
> know if the IRQ is programmed or not.  We could attach
> a device to the wrong IRQ and not know it.
> Unclear if that risk is a better policy than pretending
> we confirmed that the IRQ was successfully programmed
> when it may not have been.

Yeah, that's what I thought too.

> perhaps you can attach this patch to 1581 and we can work there
> to come up with a "disabled links patch" that makes sense
> for all systems.  We might find that we need only a small
> VIA-specific tweak to an otherwise robust policy.

OK, I've attached it there. While waiting for the generic fix, I've also
posted the patch to my amd64 page for m6805 and m6807 owners who might
the patch handy:

http://www.muru.com/linux/amd64/

> If your dmesg and acpidmp are different from 2090, it would
> be good to attach them also.

No, looks the same.

Regards,

Tony

