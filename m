Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUGRLsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUGRLsM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 07:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUGRLsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 07:48:12 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:48981 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S263804AbUGRLsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 07:48:08 -0400
Message-ID: <40FA6377.8000206@chello.no>
Date: Sun, 18 Jul 2004 13:48:07 +0200
From: Jens Olav Nygaard <jens_olav.nygaard@chello.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040714
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8-rc2
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org> <1090149153.3198.3.camel@paragon.slim> <20040718113552.GA23190@middle.of.nowhere>
In-Reply-To: <20040718113552.GA23190@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jurgen Kramer <gtm.kramer@inter.nl.net>

>>Just gave it a try. My EHCI controller is still failing (Asus P4C800-E
>>i875p) as in the 2.6.7-mm series.
>>
>><snip>
>>ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
>>ehci_hcd 0000:00:1d.7: EHCI Host Controller
>>ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
>>ehci_hcd 0000:00:1d.7: can't reset
>>ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
>>ehci_hcd: probe of 0000:00:1d.7 failed with error -95
>>USB Universal Host Controller Interface driver v2.2
>><snip>

This is also what I see (on my Asus P4P800) more or less:

ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
ehci_hcd 0000:00:1d.7: can't reset
ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
ehci_hcd: probe of 0000:00:1d.7 failed with error -95

The funny thing is, it has happened with various kernel snapshots
(right term for the 2.6.7-bk??-patches?) but not all.
I thought I had one (2.6.7-bk17) which didn't give this response,
but now it does, and I suspect the problem is really something else.
(Some automatic irq assignment to usb-hardware?)

I'm not into kernel source hacking so I can't really say much more.

Jurriaan:

> That is most probably something in your bios. My Epox 4PCA3+ (also i875
> chipset) says:

Then it's in mine also.

J.O.


PS. uname -a gives this:
Linux bombadil 2.6.8-rc2 #1 SMP Sun Jul 18 09:08:22 CEST 2004 i686 unknown
and I compiled the kernel with gcc 3.4.0.
