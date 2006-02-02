Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWBBVcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWBBVcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWBBVcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:32:16 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:45320 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932284AbWBBVcO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:32:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.44L0.0602021607100.5016-100000@iolanthe.rowland.org>
X-OriginalArrivalTime: 02 Feb 2006 21:32:12.0487 (UTC) FILETIME=[2117E570:01C62840]
Content-class: urn:content-classes:message
Subject: Re: Question about memory barriers
Date: Thu, 2 Feb 2006 16:32:12 -0500
Message-ID: <Pine.LNX.4.61.0602021626260.22302@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question about memory barriers
Thread-Index: AcYoQCE0VIrtQ7B/Sq2k2b9fqopH8A==
References: <Pine.LNX.4.44L0.0602021607100.5016-100000@iolanthe.rowland.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: "Kernel development list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Feb 2006, Alan Stern wrote:

> The kernel's documentation about memory barriers is rather skimpy.  I
> gather that rmb() guarantees that all preceding reads will have completed
> before any following reads are made, and wmb() guarantees that all
> preceding writes will have completed before any following writes are made.
> I also gather that mb() is essentially the same as rmb() and wmb() put
> together.
>
> But suppose I need to prevent a read from being moved past a write?  It
> doesn't look like either rmb() or wmb() will do this.  And if mb() is the
> same as "rmb(); wmb();" then it won't either.  So what's the right thing
> to do?
>
> Alan Stern

If you use the correct macros for device I/O (in other words
the operations are upon volatile objects), there can never
be any re-ordering of any associated code.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_
To unsubscribe


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
