Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbUCNQOK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 11:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbUCNQOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 11:14:10 -0500
Received: from fmr06.intel.com ([134.134.136.7]:10414 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263386AbUCNQOF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 11:14:05 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.4-mm1
Date: Sun, 14 Mar 2004 08:13:54 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173FEBA33@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.4-mm1
Thread-Index: AcQJnr2i1HbzpmaqQw6anCvIZoE4lQAPJ4UQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <subodh@btopenworld.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Mar 2004 16:13:55.0398 (UTC) FILETIME=[594FDE60:01C409DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see any problem after the modification as far as I tested. I
tested both UP and SMP kernel with CONFIG_PCI_USE_VECTOR = Y or N (with
ACPI enabled). 

Jun
>-----Original Message-----
>From: Andrew Morton [mailto:akpm@osdl.org]
>Sent: Sunday, March 14, 2004 12:31 AM
>To: Nakajima, Jun
>Cc: subodh@btopenworld.com; linux-kernel@vger.kernel.org
>Subject: Re: 2.6.4-mm1
>
>"Nakajima, Jun" <jun.nakajima@intel.com> wrote:
>>
>> I checked and tried several things, and I think CONFIG_PCI_USE_VECTOR
is
>>  a red herring. 2.6.4-mm1 did boot with CONFIG_PCI_USE_VECTOR = Y or
N as
>>  long as kernel preemption is disabled. It did not boot regardless of
>>  CONFIG_PCI_USE_VECTOR if kernel preemption is enabled. I see the
>>  complaints
>>    bad: scheduling while atomic!
>>  at various spots.
>
>Please delete the spin_unlock_irq(&mapping->tree_lock); five lines from
the
>end of fs/mpage.c.
>
>I assume Subodh did that, but all we know is that it "doesn't boot".

