Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWDKOAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWDKOAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 10:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWDKOAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 10:00:53 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:11027 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750819AbWDKOAw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 10:00:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <1cafb3070604110627v3bddeb7frc2b63c3004a6a6b2@mail.gmail.com>
x-originalarrivaltime: 11 Apr 2006 14:00:50.0747 (UTC) FILETIME=[573550B0:01C65D70]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] asm-i386/atomic.h: local_irq_save should be used instead of local_irq_disable
Date: Tue, 11 Apr 2006 10:00:50 -0400
Message-ID: <Pine.LNX.4.61.0604110958430.29479@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] asm-i386/atomic.h: local_irq_save should be used instead of local_irq_disable
Thread-Index: AcZdcFdUBURfCGOvTlu0+iep4QgKLQ==
References: <20060411130024.GA3364@gsy2.lepton.home> <Pine.LNX.4.61.0604110907060.29348@chaos.analogic.com> <1cafb3070604110627v3bddeb7frc2b63c3004a6a6b2@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "lepton" <ytht.net@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Apr 2006, lepton wrote:

> I think irq is disbaled in local_irq_save, am I right?
>
> /* For spinlocks etc */
> #define local_irq_save(x)       __asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
>

Yes, with the CLI in the code. The macro-name was not correct and implied
only a save of the flags..



Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
