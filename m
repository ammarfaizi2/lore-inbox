Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSHXAZI>; Fri, 23 Aug 2002 20:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSHXAZI>; Fri, 23 Aug 2002 20:25:08 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:35058 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S314514AbSHXAZH>; Fri, 23 Aug 2002 20:25:07 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDD3@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'jamesclv@us.ibm.com'" <jamesclv@us.ibm.com>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.5.31 Summit NUMA patch with dynamic IRQ balancing
Date: Fri, 23 Aug 2002 17:29:10 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: James Cleverdon [mailto:jamesclv@us.ibm.com] 
> > This should be moved to acpi.h
> 
> Will be, once I'm sure this is the right way to go.  As 
> mentioned earlier, I'm 
> having ACPI problems that seem to imply ACPI isn't building 
> the full IRQ 
> table.  In 2.4 we could let MPS do this.  Maybe 2.5 will need 
> to revert to 
> that behavior.

What happens when you use the FULL ACPI support? I suspect that you really
do want the interpreter, in order to evaluate _PRTs properly.

ISTR that the reason you are thinking that ACPI only is programming some of
the ioapic entries is because whatever is printing them is looking at the
mp_irqs array. Which is MPS specific. So ACPI doesn't bother filling it all
in. :)

Is that a bug? Should ACPI fill it in completely, or maybe not at all? Don't
know. But it is strictly unnecessary.

Regards -- Andy
