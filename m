Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268252AbUHKVlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268252AbUHKVlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268245AbUHKVkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:40:22 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:27331 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268244AbUHKVhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:37:54 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Date: Wed, 11 Aug 2004 15:37:42 -0600
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com> <1092259920.5021.117.camel@dhcppc4>
In-Reply-To: <1092259920.5021.117.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408111537.42598.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 August 2004 3:32 pm, Len Brown wrote:
> I've never understood this floppy IRQ6 business.
> Apparently it requests IRQ6, but doesn't show up in /proc/interrupts
> 
> In any case, dropping a PCI interrupt on IRQ6 would surely break it
> b/c that would set that IRQ6 to level trigger.
> 
> Before this change, did LNKD get set to something other than IRQ6?

I don't think so.  Adrian originally posted[1] a 2.6.8-rc3-mm1 boot log
(this was before the change):

	ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
	ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
	ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6


[1]: http://groups.google.com/groups?dq=&hl=en&lr=&ie=UTF-8&c2coff=1&th=cfe35677cfe8e54b
