Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUEQTOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUEQTOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUEQTOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:14:05 -0400
Received: from mail.ccdaust.com.au ([203.29.88.42]:36395 "EHLO
	gateway.ccdaust.com.au") by vger.kernel.org with ESMTP
	id S262238AbUEQTOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:14:00 -0400
Message-ID: <40A90EE2.3040507@wasp.net.au>
Date: Mon, 17 May 2004 23:13:38 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: libata Promise driver regression 2.6.5->2.6.6
References: <A6974D8E5F98D511BB910002A50A6647615FB7A9@hdsmsx403.hd.intel.com> <1084820518.12349.347.camel@dhcppc4>
In-Reply-To: <1084820518.12349.347.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:

> LNKH would have hit the bug fixed in 2665.
> However, LNKH isn't enabled, so we don't hit that bug.
> 
> LNKC, OTOH, is already enabled on IRQ12; and both
> 2.6.5 and 2.6.6 will leave it there unless you explicity
> tell Linux to move IRQs in PIC mode with "acpi_irq_balance".
> 
> apples/apples comparison would be to boot your 2.6.5 kernel with
> "noapic".  I expect 2.6.5 will have the same issue with IRQ12
> in PIC mode.  Unusual for a BIOS to put PCI devices on IRQ12 like
> that...

Err.. yeah, I'm not quite sure why but a make oldconfig on my 2.6.5 config did not enable apic.
Rather than boot 2.6.5 noapic, I enabled apic on 2.6.6 and the dmesg compares perfectly to the 2.6.5 
one, right up until it tries to probe the 9th disk where it proceeds to dma timeout and then cease 
to listen to anything..

Regards,
Brad
