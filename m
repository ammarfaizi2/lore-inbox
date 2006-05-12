Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWELPwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWELPwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWELPwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:52:34 -0400
Received: from spirit.analogic.com ([204.178.40.4]:43274 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932139AbWELPwd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:52:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 12 May 2006 15:52:32.0284 (UTC) FILETIME=[1470F5C0:01C675DC]
Content-class: urn:content-classes:message
Subject: Re: mlock into kernel module
Date: Fri, 12 May 2006 11:52:31 -0400
Message-ID: <Pine.LNX.4.61.0605121148001.9467@chaos.analogic.com>
In-Reply-To: <4464A819.2050706@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mlock into kernel module
Thread-Index: AcZ13BSLJYwamonYRTK4zaOtWKqeWw==
References: <4464A819.2050706@gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "sej.kernel" <sej.kernel@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, sej.kernel wrote:

> Hello,
> I need to use mlock and munlock function into a kernel module. How so
> I call this system call from my module ?
> I need to do this because I must use mlock in my software, but I can't
> use root or suser to start it. So mlock alwaays fail.
> Regards,
> sej

You don't call mlock from a module. You can lock down pages inside
your module by using non-paged RAM. This can be accessed from user-space
by implimenting mmap() in your module so that the user-code can
memory-map it. That way, the page(s) you have allocated in the
kernel are never swapped.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
