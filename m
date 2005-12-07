Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbVLGTBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbVLGTBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbVLGTBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:01:25 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:64522 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751762AbVLGTBY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:01:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.63.0512071345210.17172@cuia.boston.redhat.com>
X-OriginalArrivalTime: 07 Dec 2005 19:01:22.0626 (UTC) FILETIME=[9D68F220:01C5FB60]
Content-class: urn:content-classes:message
Subject: Re: Load-on-demand. How does the kernel locate the pages on secondary storage?
Date: Wed, 7 Dec 2005 14:01:22 -0500
Message-ID: <Pine.LNX.4.61.0512071352160.9463@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Load-on-demand. How does the kernel locate the pages on secondary storage?
Thread-Index: AcX7YJ2Hfo4fe2QCRMWNJoeI0l4tMQ==
References: <afd776760512061938w7647b155r28a9eef8fdcfb640@mail.gmail.com> <Pine.LNX.4.63.0512071345210.17172@cuia.boston.redhat.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Rik van Riel" <riel@redhat.com>
Cc: "Mohamed El Dawy" <msdawy@gmail.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Dec 2005, Rik van Riel wrote:

> On Tue, 6 Dec 2005, Mohamed El Dawy wrote:
>
>>  Assume we have a process running, not all the pages of the process
>> are in main memory. Some are swapped, and some are just not loaded
>> yet.
>> How does the kernel locate those pages on disk? Is there a pointer in
>> the page table? or is there some place else? Any pointers to source
>> code in the kernel would be greatly appreciated.
>
> http://linux-mm.org/PageFaultHandling
>
> --
> All Rights Reversed

Look at /usr/src/linux-`uname -r`/mm/swapfile.c scan_swap_map()
for a hint. They are indexed using cluster numbers and it's an easy
index because the swap i/o is in pages.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
