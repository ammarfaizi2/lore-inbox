Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUCaWUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUCaWUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:20:35 -0500
Received: from fmr10.intel.com ([192.55.52.30]:40381 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262170AbUCaWU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:20:27 -0500
Subject: Re: ACPI SCI IOAPIC bug (Re: Fixes for nforce2 hard lockup, apic,
	io-apic, udma133 covered)
From: Len Brown <len.brown@intel.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com, kernel@kolivas.org, Ian Kumlien <pomac@vapor.com>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F0C10@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F0C10@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080771580.31359.32.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2004 17:19:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-18 at 12:43, Maciej W. Rozycki wrote:

>  Note that if changing an I/O APIC input was indeed needed, the
> replace_pin_at_irq() function could be used.

Why is it that all IRQs get their name from the
IOAPIC pin number, but the timer connected to
pin 2 is called IRQ0 instead of IRQ2?

Are there other exceptions to this rule,
or is all the code for re-naming IRQs & pins
effectively just for the timer?

I wonder if we should't be moving to at least a build option which
deletes support for multiple pins at an IRQ, and deletes
suport for non-identity pin->IRQ mapping.

>  I still wonder why these arrangements are made so late in a boot --
> after 
> all, ACPI IRQ configuration is table-driven and does not require any 
> specific hardware initialization to work.  So it could be done at the 
> stage MP-table parsing happens, couldn't it?

While the ACPI table parsing is very early, the _PRT parsing
can happen only after the ACPI interpreter is up, because
the _PRT's are encoded in AML.

thanks,
-Len


