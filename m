Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbUKBQ2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUKBQ2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 11:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUKBQ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 11:28:48 -0500
Received: from smtp.parbin.co.uk ([213.162.111.160]:18561 "EHLO
	mail.parbin.co.uk") by vger.kernel.org with ESMTP id S261956AbUKBQ21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:28:27 -0500
Subject: Re: PCI->APIC IRQ transform -> 267 ?
From: Robert Clark <lkml@ratty.org.uk>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1099199311.18178.4.camel@d845pe>
References: <1098958286.6342.63.camel@localhost>
	 <1099199311.18178.4.camel@d845pe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099412905.13207.441.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Tue, 02 Nov 2004 16:28:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 05:08, Len Brown wrote:

> On Thu, 2004-10-28 at 06:11, Robert Clark wrote:

> > I'm getting this with 2.4.27 (SMP):
> > 
> > PCI: Using IRQ router PIIX [8086/25a1] at 00:1f.0
> ...
> > PCI->APIC IRQ transform: (B3,I4,P0) -> 267
> 
> this is from pcibios_fixup_irqs() which is called only when ACPI is
> disabled.  Let me know if you still have trouble with a kernel built
> with CONFIG_ACPI=y.  Also, it would be good to know if other versions of
> the kernel are known to work, or if they all fail on this box.

  Thanks - that sheds some light on things. I've had some success with
2.6.8 and thought it was a problem with the 2.4 series, but I've now
recompiled 2.4.27 with CONFIG_ACPI and it does work.

  Am I right in thinking that without CONFIG_ACPI, 2.4.27 simply trusts
the BIOS to set up ACPI? If so, I should talk to Supermicro as it sounds
like it might be a BIOS problem.

	Thanks,

		Robert
