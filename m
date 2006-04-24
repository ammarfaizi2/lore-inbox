Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWDXS7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWDXS7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWDXS7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:59:16 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:35858 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751093AbWDXS7Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:59:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060424114105.113eecac@localhost.localdomain>
X-OriginalArrivalTime: 24 Apr 2006 18:59:12.0006 (UTC) FILETIME=[2C8F6A60:01C667D1]
Content-class: urn:content-classes:message
Subject: Re: better leve triggered IRQ management needed
Date: Mon, 24 Apr 2006 14:59:11 -0400
Message-ID: <Pine.LNX.4.61.0604241456410.24376@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: better leve triggered IRQ management needed
thread-index: AcZn0Sysp5YUG/90Qx60FKxJFWBc/A==
References: <20060424114105.113eecac@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Stephen Hemminger" <shemminger@osdl.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2006, Stephen Hemminger wrote:

> I am seeing repeated problems with misconfigured systems that have shared IRQ
> devices configured for edge-triggered. Also, network devices using NAPI won't
> work reliably on edge-triggered IRQ's.  The kernel IRQ architecture doesn't
> have sufficient information to detect this at boot time.
> We should fail request_irq() if the SA_SHIRQ but the irq is edge-triggered.
>
> Right now the concept of level vs edge triggered is buried in things like ELCR for old
> PIC, and other stuff for IO-APIC.  There is a IRQ_LEVEL flag in the descriptor field
> but nothing sets it or uses it.
>
> Haven't even looked at non i386 arch's but probably even more confusion there.

Well ALL IRQs from the PCI are level so there is no way to misconfigure
it; or have you found some hidden method?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
