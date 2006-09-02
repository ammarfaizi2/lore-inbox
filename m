Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWIBTas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWIBTas (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 15:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWIBTas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 15:30:48 -0400
Received: from mxsf11.cluster1.charter.net ([209.225.28.211]:43164 "EHLO
	mxsf11.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751387AbWIBTar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 15:30:47 -0400
X-IronPort-AV: i="4.08,203,1154923200"; 
   d="scan'208"; a="848961999:sNHT22761864"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17657.56290.549931.187652@smtp.charter.net>
Date: Sat, 2 Sep 2006 15:30:42 -0400
From: "John Stoffel" <john@stoffel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org,
       jeff@garzik.org, alan@redhat.com
Subject: Re: 2.6.18-rc4-mm1 ATA oops on HPT302 controller
In-Reply-To: <1157151612.6271.338.camel@localhost.localdomain>
References: <17648.47873.675155.821074@stoffel.org>
	<1157151612.6271.338.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> Ar Sad, 2006-08-26 am 17:20 -0400, ysgrifennodd John Stoffel:
>> irq 16: nobody cared (try booting with the "irqpoll" option)
>> [<c013e3e4>] __report_bad_irq+0x24/0x90
>> [<c013e668>] note_interrupt+0x218/0x250
>> [<c013d8f3>] handle_IRQ_event+0x33/0x70

Alan> Looks like ACPI routing problems

Hmmm, so maybe there's something in the -mm patches which is screwing
up things?  I'll try 2.6.18-rc5-mm1 then with my regular .config and
see what happens.

>> [<c013ef9a>] handle_fasteoi_irq+0xca/0xe0
>> [<c013eed0>] handle_fasteoi_irq+0x0/0xe0

Alan> The fact it's a 440GX also suggests the IRQ stuff is likely to
Alan> be first bet

I thought the 440GX was a well understood chip, though old now
obviously.  :]   I'll run some more tests and see what happens under
-mm kernels with the old IDE drivers.

John

-- 
VGER BF report: H 0.400265
