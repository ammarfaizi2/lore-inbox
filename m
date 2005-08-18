Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVHRNaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVHRNaw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 09:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVHRNaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 09:30:52 -0400
Received: from [81.2.110.250] ([81.2.110.250]:64174 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932224AbVHRNav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 09:30:51 -0400
Subject: Re: [PATCH,RFC] quirks for VIA VT8237 southbridge
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200508181436.54880.annabellesgarden@yahoo.de>
References: <200508131710.38569.annabellesgarden@yahoo.de>
	 <200508160949.10607.bjorn.helgaas@hp.com>
	 <1124212816.20707.5.camel@localhost.localdomain>
	 <200508181436.54880.annabellesgarden@yahoo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Aug 2005 14:57:57 +0100
Message-Id: <1124373477.16072.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-18 at 14:36 +0200, Karsten Wiese wrote:
> Solutions: either calculate correct new_irq (= PIN-Number & 0x0F)
>  or don't apply likely wrong value.
> 
> Following diff takes the 2nd way.
> 
> Well, VT8237 ignores the wrong new_irq in IOAPIC-Mode,
> but its irritating to see dmesg print out nonsense then. 

The docs and my poking around with a later board seem to imply you need
to set the IRQ value > 15 to get it to the IO-APIC. The data sheet
doesn't seem clear if you need to set it all up by hand or if ACPI does
it.

