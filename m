Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbVKBVc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbVKBVc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbVKBVc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:32:59 -0500
Received: from spirit.analogic.com ([204.178.40.4]:18181 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S965257AbVKBVc6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:32:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <110220052106.23704.43692A6C000AA6AE00005C98215876675598079D0C9B@att.net>
References: <110220052106.23704.43692A6C000AA6AE00005C98215876675598079D0C9B@att.net>
X-OriginalArrivalTime: 02 Nov 2005 21:32:56.0929 (UTC) FILETIME=[FD943510:01C5DFF4]
Content-class: urn:content-classes:message
Subject: Re: No sharing IRQ broken board problem
Date: Wed, 2 Nov 2005 16:32:56 -0500
Message-ID: <Pine.LNX.4.61.0511021627140.20674@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: No sharing IRQ broken board problem
Thread-Index: AcXf9P2uA+Micn8ERVOECrhahsSv7Q==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <tcrix@att.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Nov 2005 tcrix@att.net wrote:

> I have a pci board in development that works but..
> it can not share the interrupt line.
>

It's on the PCI bus. It needs to be an "open collector" type.
Sharing or not is really not a software issue! The only
kind of hardware problem that could cause "shared interrupt"
line problems is the designer fails to provide the correct
kind of interface driver. In that case, just "dead-bug" a
FET (or two) on the board, near the connector, to convert
the driven bit to an open-collector (drain) bit.

> Has someone hacked through the problem of reserving one of the inta, intb,
> .. 's for a single device?  I would love to see how you did so I could
> continue on with my driver while I wait for the !@$#!@ hardware guys to fix
> the board.
>
> Thanks for the help,
> Tom Rix
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
