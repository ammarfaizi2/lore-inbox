Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265631AbUEZPzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbUEZPzB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 11:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbUEZPzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 11:55:01 -0400
Received: from fmr05.intel.com ([134.134.136.6]:17281 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265631AbUEZPy7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 11:54:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.7-rc1-bk: SMT scheduler bug / crashes on kernel boot
Date: Wed, 26 May 2004 08:54:46 -0700
Message-ID: <7F740D512C7C1046AB53446D372001730182B346@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.7-rc1-bk: SMT scheduler bug / crashes on kernel boot
thread-index: AcRDFunMKzCoKooYR9uKzbfsdSf6zgAIZFQQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Anton Altaparmakov" <aia21@cam.ac.uk>
Cc: <mingo@elte.hu>, "lkml" <linux-kernel@vger.kernel.org>,
       "Zwane Mwaikambo" <zwane@zwane.ca>
X-OriginalArrivalTime: 26 May 2004 15:54:47.0793 (UTC) FILETIME=[C570FE10:01C44339]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Nick Piggin [mailto:nickpiggin@yahoo.com.au]
>Sent: Wednesday, May 26, 2004 4:45 AM
>To: Anton Altaparmakov
>Cc: mingo@elte.hu; lkml; Zwane Mwaikambo; Nakajima, Jun
>Subject: Re: 2.6.7-rc1-bk: SMT scheduler bug / crashes on kernel boot
>
>Anton Altaparmakov wrote:
>> On Wed, 2004-05-26 at 12:28, Nick Piggin wrote:
>>
>
>The problem is smp_num_siblings is set to 2, but phys_proc_id
>doesn't seem to be set up right (or it could be cpu_callout_map).
>That would cause the sched-domains to get set up wrong, sure. Maybe
>we should just go bug in this case? Or try to fix up?
>
>Anyone have any idea why this is happening?
>
Does this happen when you run the kernel on top of VMWare, as far as I
understand? If so, it is likely that VMWare is not simulating the
behavior of cpuid regarding HT support (especially, mapping between
logical and processor package). Then, you should get the same result
even when you run 2.6.6 kernel. Do you have dmesg output from some older
kernel or 2.6.6?

Jun

