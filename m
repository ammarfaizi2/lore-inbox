Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUE1Wrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUE1Wrt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUE1Wrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:47:49 -0400
Received: from fmr06.intel.com ([134.134.136.7]:32451 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263971AbUE1WGj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:06:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CONFIG_IRQBALANCE for AMD64?
Date: Fri, 28 May 2004 15:05:48 -0700
Message-ID: <7F740D512C7C1046AB53446D372001730182BC35@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_IRQBALANCE for AMD64?
thread-index: AcRE/RP61/1Nsw7sTl+6kKs2Gv15GgAACy2g
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andi Kleen" <ak@muc.de>, "Martin J. Bligh" <mbligh@aracnet.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 May 2004 22:05:50.0256 (UTC) FILETIME=[EFBAC300:01C444FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Andi Kleen [mailto:ak@muc.de]
>Sent: Friday, May 28, 2004 2:45 PM
>To: Martin J. Bligh
>Cc: linux-kernel@vger.kernel.org; Nakajima, Jun
>Subject: Re: CONFIG_IRQBALANCE for AMD64?
>
>"Martin J. Bligh" <mbligh@aracnet.com> writes:
>
>> Whatever we do ... all arches are going to need to provide a way to
>direct
>> interrupts to a certain CPU, or group thereof. Can they all do that
>already?
>> I'll confess to not having looked at non-i386 arches. And are others
as
>> brain damaged as the P4? or do they do something round-robin by
default?
>
>I wouldn't really blame the the P4, it's the IO-APICs in the chipsets
>that balance or not balance.
>
>At least the AMD chipsets found in most Opteron boxes need software
>balancing too.

Actually lowest priority delivery works on P4 and AMD (I did not tested
it on AMD, though), if we _update_ TPR. But I don't recommend that,
instead we should implement the similar or optimized behavior in
software because "soft TPR" can be more efficient and scalable. And I
think this is something in my mind, and I think the kernel should do it.

Jun

>
>-Andi
>

