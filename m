Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbSKRPtX>; Mon, 18 Nov 2002 10:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSKRPtX>; Mon, 18 Nov 2002 10:49:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17670 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262800AbSKRPtX>;
	Mon, 18 Nov 2002 10:49:23 -0500
Message-ID: <3DD90D88.9020205@pobox.com>
Date: Mon, 18 Nov 2002 10:55:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: Vergoz Michael <mvergoz@sysdoor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c patch for kernel 2.4.19
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain> <3DD8AD5D.9010803@pobox.com> <3DD8CC44.9060104@domdv.de>
In-Reply-To: <028901c28ead$10dfbd20$76405b51@romain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:

> Jeff,
> just as a hint: I do have a SiS based UP test system around that
> misbehaves with IO-APIC enabled.
> See
> http://www.msi.com.tw/program/products/slim_pc/slm/pro_slm_detail.php?UID=134&MODEL=MS-6232 
>
>  for more system details.
>  From the back of my head: with IO-APIC enabled and 3 RTL8139 (one on
> board, the other two PCI) the NICs get assigned IRQs 17 and 18 but don't
> seem to receive any interrupt at all. Without IO-APIC all three NICs
> share IRQ 11 and do work. Further details on request (very low priority
> problem for me). Oh, nearly forgot: kernel is 2.4.20rc1.


That's not going to be fixed by Michael's patch...  Any IOAPIC-related 
problems cannot be fixed at the driver level, but must be fixed by a 
BIOS update (or possibly an IOAPIC code fix).  Sometimes vendors do not 
bother do even wire the IOAPIC when it is a uniprocessor board :(

	Jeff



