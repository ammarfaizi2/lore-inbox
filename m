Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933721AbWKQQqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721AbWKQQqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933722AbWKQQqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:46:05 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:21267 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S933721AbWKQQqD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:46:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 17 Nov 2006 16:46:00.0224 (UTC) FILETIME=[DC988200:01C70A67]
Content-class: urn:content-classes:message
Subject: Re: diabling interrupts on pentium 4 processor
Date: Fri, 17 Nov 2006 11:45:59 -0500
Message-ID: <Pine.LNX.4.61.0611171141180.24086@chaos.analogic.com>
In-Reply-To: <6844644e0611170710j28e96e66yfb91fa5b97e2cb8f@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: diabling interrupts on pentium 4 processor
thread-index: AccKZ9y3qLSj9UCtSg2br0X7Bdye1w==
References: <20061116112312.43293.qmail@web27402.mail.ukl.yahoo.com> <6844644e0611170710j28e96e66yfb91fa5b97e2cb8f@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "ranjith kumar" <ranjit_kumar_b4u@yahoo.co.uk>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On 11/16/06, ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk> wrote:
> Hi,
>     How to disable interrupts on pentium 4 (or any
> i386)
>     machine?
>
>      I tried to include "cli" instruction in a kernel
> module. But got runtime error.

In a module, "cli" should not be an illegal opcode, but in user-mode
code it is. But, you should not be using 'cli' anywhere. Instead, you
should use a spin-lock to protect a critical section. Check the coding
in any network drivers to see how it is done.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
