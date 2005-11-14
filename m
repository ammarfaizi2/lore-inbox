Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVKNRhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVKNRhK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVKNRhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:37:10 -0500
Received: from spirit.analogic.com ([204.178.40.4]:21002 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751203AbVKNRhJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:37:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200511150514.jAF5Eli08483@hofr.at>
References: <200511150514.jAF5Eli08483@hofr.at>
X-OriginalArrivalTime: 14 Nov 2005 17:37:07.0772 (UTC) FILETIME=[08FB2FC0:01C5E942]
Content-class: urn:content-classes:message
Subject: Re: schedule_work in net/*
Date: Mon, 14 Nov 2005 12:37:07 -0500
Message-ID: <Pine.LNX.4.61.0511141233430.27653@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: schedule_work in net/*
Thread-Index: AcXpQgkXlSx5vP2SQe+MB185MFexyw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Der Herr Hofrat" <der.herr@hofr.at>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2005, Der Herr Hofrat wrote:

>
> Hi !
>
> while looking for a posibly work queue related problem i noticed
> that the return value of schedule_work/scheule_delayed_work is not
> checked in the networking code (and in other cases aswell) - is there
> a particular reason for this - or has it just been forgotten ?
> Atleast in the network code it looks like events could be silently
> lost. (net/core/link_watch.c ipv4/inet_timewait_sock.c etc.)
>
> thx !
> hofrat

Yes!  Anything inside the IP can be lost. That's how it works in
oper places as well. If the receive queue gets full, packets
are thrown away, etc. It's up to the upper-levels to make
everything work transparently in protocols that require it.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
