Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUE1SWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUE1SWQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 14:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUE1SWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 14:22:16 -0400
Received: from fmr06.intel.com ([134.134.136.7]:62908 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263772AbUE1SWO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 14:22:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CONFIG_IRQBALANCE for AMD64?
Date: Fri, 28 May 2004 11:20:45 -0700
Message-ID: <7F740D512C7C1046AB53446D372001730182BB40@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_IRQBALANCE for AMD64?
thread-index: AcRE3US5bMPta0HKQhu22/+JNEcD3QAAG6ew
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Arjan van de Ven" <arjanv@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "Andrew Morton" <akpm@osdl.org>,
       "Anton Blanchard" <anton@samba.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 May 2004 18:20:47.0066 (UTC) FILETIME=[7F337BA0:01C444E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Arjan van de Ven [mailto:arjanv@redhat.com]
>Sent: Friday, May 28, 2004 10:57 AM
>To: Martin J. Bligh
>Cc: Jeff Garzik; Nakajima, Jun; Andrew Morton; Anton Blanchard; linux-
>kernel@vger.kernel.org
>Subject: Re: CONFIG_IRQBALANCE for AMD64?
>
>On Fri, May 28, 2004 at 10:46:18AM -0700, Martin J. Bligh wrote:
>>
>> Personally, I find the argument that it's hardware-specific control
code
>> a much better reason for it to belong in the kernel.
>
>Is it really hardware specific ??

I think automatic IRQ binding business should belong to the user-level;
it can use generic statistics, application, or platform configuration
knowledge.

The kernel-level should have some simple chipset model, such as lowest
priority delivery mode with finer granularity of control. The kirqd at
this point, is doing automatic IRQ binding business as well today,
although it does not literally bind them. So I think we need to remove
that part of code from kirqd. 

Jun

