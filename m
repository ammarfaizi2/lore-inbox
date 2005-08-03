Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVHCBAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVHCBAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 21:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVHCBAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 21:00:25 -0400
Received: from fmr18.intel.com ([134.134.136.17]:10980 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261808AbVHCBAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 21:00:23 -0400
Subject: Re: [PATCH] PNPACPI: fix types when decoding ACPI resources
	[resend]
From: Shaohua Li <shaohua.li@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200508020955.54844.bjorn.helgaas@hp.com>
References: <200508020955.54844.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 09:01:01 +0800
Message-Id: <1123030861.2937.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 09:55 -0600, Bjorn Helgaas wrote:
> Any objections to the patch below?  I posted it last Wednesday,
> but haven't heard anything.  Once we have this fix, 8250_pnp
> should have sufficient functionality that we can get rid of
> 8250_acpi.
> 
> 
> 
> Use types that match the ACPI resource structures.  Previously
> the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
> which corrupts the value.
> 
> This is one of the things that prevents 8250_pnp from working
> on HP ia64 boxes.  After 8250_pnp works, we will be able to
> remove 8250_acpi.c.
We might always use 'unsigned long'. Did you have plan to remove other
legacy acpi drivers?

Thanks,
Shaohua

