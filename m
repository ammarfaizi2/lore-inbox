Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUDATFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbUDATFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:05:38 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:55787 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S263045AbUDATFg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:05:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: kernel BUG at kernel/timer.c:370!
Date: Thu, 1 Apr 2004 11:05:22 -0800
Message-ID: <0320111483D8B84AAAB437215BBDA526847F9B@NAEX01.na.qualcomm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel BUG at kernel/timer.c:370!
Thread-Index: AcQXbXP/5EjDnXmAQOig9nmMFjaUGgArobyA
From: "Craig, Dave" <dwcraig@qualcomm.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <list@noduck.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Apr 2004 19:05:23.0154 (UTC) FILETIME=[48BA5B20:01C4181C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It could be hardware, but it would be hardware negatively interacting
with the kernel preemption feature.  The failure does not occur when
that feature is disabled.

	Dave

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Wednesday, March 31, 2004 2:16 PM
To: Craig, Dave
Cc: list@noduck.net; linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!

"Craig, Dave" <dwcraig@qualcomm.com> wrote:
>
> Sure thing.
> 
> 7ecb001b A __crc___per_cpu_offset
> c033a510 r __kcrctab___per_cpu_offset
> c033c462 r __kstrtab___per_cpu_offset
> c03366c4 r __ksymtab___per_cpu_offset
> c040bd90 A __per_cpu_end
> c040c020 B __per_cpu_offset
> c04090a0 A __per_cpu_start
> 
> It is a dual processor and the processors are hyperthreaded.

OK.  We're consistently seeing a single-bit difference and there's no
simple power-of-two stride in the things which that pointer points at. 
Most likely you have a hardware problem.


