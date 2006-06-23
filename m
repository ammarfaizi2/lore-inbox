Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWFWRec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWFWRec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWFWRec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:34:32 -0400
Received: from spirit.analogic.com ([204.178.40.4]:32274 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751811AbWFWReb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:34:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 23 Jun 2006 17:34:30.0418 (UTC) FILETIME=[487B9F20:01C696EB]
Content-class: urn:content-classes:message
Subject: Re: 2.6.11: spinlock problem
Date: Fri, 23 Jun 2006 13:34:30 -0400
Message-ID: <Pine.LNX.4.61.0606231331310.16810@chaos.analogic.com>
In-Reply-To: <200606231651.k5NGpbYr008153@firewall.reed.wattle.id.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11: spinlock problem
thread-index: AcaW60iV6qbBK7Q3TQaTlMoj95ac7A==
References: <200606231651.k5NGpbYr008153@firewall.reed.wattle.id.au>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Darren Reed" <darrenr@reed.wattle.id.au>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2006, Darren Reed wrote:

> Hi,
>
> I'm seeing a spinlock held panic with a kernel stack like this:
>
> spinlock - panic, lock already held
> ..
> __do_softirq
> do_softirq
> =========
> do_IRQ
> common_interrupt
> spinlock/spinunlock
> ..
>
> when I load up the system in testing.
> The code protected by the spinlock is quite small - counter increment.
>
> I'm using 2.6.11-1.1369_FC4 #1, installed inside of vmware,
> running as a guest on a Windows XP box.
>
> Is this
> (a) linux allowing the IRQ too early
> (b) vmware not doing something right
> (c) enivitable
> (d) somehow my fault
> (e) something else?
>
> Thanks,
> Darren

Where's the code? Also, did you initialize the spin-lock variable
before use?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
