Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267836AbUHPRyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267836AbUHPRyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUHPRyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:54:16 -0400
Received: from fmr11.intel.com ([192.55.52.31]:10969 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S267832AbUHPRxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:53:20 -0400
Subject: Re: eth*: transmit timed out since .27 (was: linux-2.4.27 released)
From: Len Brown <len.brown@intel.com>
To: Oliver Feiler <kiza@gmx.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C3236@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C3236@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092678734.23057.18.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Aug 2004 13:52:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver,
I'm glad that turning off "pci=noacpi" fixed your system.
I don't know why the legacy irqrouter didn't work, but
as ACPI works, I'm not going to worry about it;-)

I expect the "acpi=off" experiment would behave the same as
"pci=noacpi", but it looks like in your experiment you
mis-spelled that parameter as apci=off, so instead it was the
same as the default ACPI-enabled case.

Re: lots of interrupts on the same IRQ.
There are boot params to balance out the IRQs in PIC mode,
but what you want to do on this system is enable the IOAPIC
in your kernel config.  The existence of the MADT in your
ACPI tables suggests you may have one.  An IOAPIC will bring
additional interrupt pins to bear, usually allowing
the PCI interrupts to use IRQs > 16 where they may
not have to share so much.

cheers,
-Len


