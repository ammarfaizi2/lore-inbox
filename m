Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVLEQrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVLEQrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbVLEQrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:47:10 -0500
Received: from spirit.analogic.com ([204.178.40.4]:8203 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751386AbVLEQrJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:47:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43946ACE.9040405@argo.co.il>
X-OriginalArrivalTime: 05 Dec 2005 16:47:02.0907 (UTC) FILETIME=[849DECB0:01C5F9BB]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
Date: Mon, 5 Dec 2005 11:46:46 -0500
Message-ID: <Pine.LNX.4.61.0512051138400.4353@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] CPU frequency display in /proc/cpuinfo
Thread-Index: AcX5u4Snlm9xwvo4Sh6BHr8PQ65raQ==
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de> <20051204183239.GE14247@wotan.suse.de> <1133725767.19768.12.camel@mindpipe> <20051205011611.GA12664@redhat.com> <43946ACE.9040405@argo.co.il>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Avi Kivity" <avi@argo.co.il>
Cc: "Dave Jones" <davej@redhat.com>, "Lee Revell" <rlrevell@joe-job.com>,
       "Andi Kleen" <ak@suse.de>,
       "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>,
       "Andrew Morton" <akpm@osdl.org>, "cpufreq" <cpufreq@www.linux.org.uk>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Dec 2005, Avi Kivity wrote:

> Dave Jones wrote:
>
>> I can't think of a single valid reason why a program would want
>> to know the MHz rating of a CPU. Given that it's a) approximate,
>> b) subject to change due to power management, c) completely nonsensical
>> across CPU vendors, and d) only one of many variables regarding CPU
>> performance, any program that bases any decision on the values found
>> by parsing that field of /proc/cpuinfo is utterly broken beyond belief.
>>
>>
> Sometimes you need extremely low overhead time measurements, which need
> not be too accurate. One way to do this is to dump rdtsc measurements
> into some array, and later scale it using the cpu frequency.
>
> I've done exactly this. The processes were pinned to their processors,
> and there was no frequency scaling in effect. It worked very well.

Also humans might need to know if the botherboard is set up properly,
or can even be set up properly to be able to run the CPU at its
expected speed. FYI, I tested an expensive "blade" server that
was not configurable to anything near its advertised specifications.
The contents of /proc/cpuinfo was one of the nails I used for
the vendor's coffin.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
