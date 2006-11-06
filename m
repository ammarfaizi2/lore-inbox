Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753309AbWKFQSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbWKFQSc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbWKFQSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:18:32 -0500
Received: from www.osadl.org ([213.239.205.134]:27794 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1753309AbWKFQSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:18:31 -0500
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required)
	[2.6.18-rc4-mm1]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Ingo Molnar <mingo@elte.hu>, len.brown@intel.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061103000631.GA23182@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
	 <1162417916.15900.271.camel@localhost.localdomain>
	 <20061102001838.GA911@rhlx01.hs-esslingen.de>
	 <1162452676.15900.287.camel@localhost.localdomain>
	 <1162455263.15900.320.camel@localhost.localdomain>
	 <1162488129.15900.396.camel@localhost.localdomain>
	 <20061102192812.GA11815@rhlx01.hs-esslingen.de>
	 <20061102203430.GA27729@rhlx01.hs-esslingen.de>
	 <20061103000631.GA23182@rhlx01.hs-esslingen.de>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 17:20:32 +0100
Message-Id: <1162830033.4715.201.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 01:06 +0100, Andreas Mohr wrote:
> ACPI: lapic on CPU 0 stops in C2[C2]

> How probable is it that the APIC timer got killed due to mis-programming
> in Linux versus VIA chipset design garbage probability? I.e. do you think
> there's a chance to fix C2 malfunction by going into the innards of
> VIA chipsets operation?
> How useful would it be to simply disable C2 operation (but not C1)
> in CONFIG_NO_HZ mode after's been determined to kill APIC timer?:

No, we better disable local apic timer in that case. What happens if you
boot your machine with ACPI disabled ?

	tglx


