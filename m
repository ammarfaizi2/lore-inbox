Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbUDUWBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUDUWBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 18:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUDUWBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 18:01:00 -0400
Received: from fmr10.intel.com ([192.55.52.30]:52706 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S261817AbUDUWA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 18:00:57 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	 for idle=C1halt, 2.6.5
From: Len Brown <len.brown@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, Allen Martin <AMartin@nvidia.com>
In-Reply-To: <m3k70gx2k3.fsf@averell.firstfloor.org>
References: <1KkKQ-2v9-9@gated-at.bofh.it> <1Kqdx-6E1-5@gated-at.bofh.it>
	 <1KH4I-3W9-11@gated-at.bofh.it> <1LgOQ-7px-3@gated-at.bofh.it>
	 <1LlEY-36q-11@gated-at.bofh.it>  <m3k70gx2k3.fsf@averell.firstfloor.org>
Content-Type: text/plain
Organization: 
Message-Id: <1082584816.16333.113.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Apr 2004 18:00:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 19:07, Andi Kleen wrote:
> Len Brown <len.brown@intel.com> writes:
> 
> > While I don't want to get into the business of maintaining
> > a dmi_scan entry for every system with this issue, I think
> > it might be a good idea to add a couple of example entries
> > for high volume systems for which there is no BIOS fix available.
> 
> Or do a generic fix: check for the PCI-ID of the Nforce2 and when
> it is true and the timer is wrong just correct it. That's ugly,
> but it's probably the best solution for such a common issue
> (and the IO-APIC code is already filled with workarounds anyways)

IMO the fact that the IOAPIC code is full of workarounds is a reason NOT
to add another one.

> One problem is that this likely must happen before the PCI quirks
> run. In the x86-64 code I have special "early PCI scanning" code 
> for this that could be copied. I don't have a Nforce2, but when
> someone is willing to test I can do a patch for this.

If this issue had no other fix, I'd agree that the complexity is worth
it.  But a BIOS upgrade fixes this -- so I think dmi-scan simplicity
is the way to go.

-Len


