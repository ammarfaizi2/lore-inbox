Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbTGJBC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 21:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266231AbTGJBC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 21:02:58 -0400
Received: from fmr04.intel.com ([143.183.121.6]:15096 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266214AbTGJBCz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 21:02:55 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] idle using PNI monitor/mwait
Date: Wed, 9 Jul 2003 18:17:32 -0700
Message-ID: <763EDB03559AA1428E4D41045B43F17B0304D8C4@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] idle using PNI monitor/mwait
Thread-Index: AcNF5rmwks3FEkufR7CiqX6po3VAcAAmhhSw
From: "Saxena, Sunil" <sunil.saxena@intel.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 10 Jul 2003 01:17:32.0913 (UTC) FILETIME=[0A01EE10:01C34681]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal advantages may be there and like "pause" they would be
implementation specific.

Thanks
Sunil

-----Original Message-----
From: Zwane Mwaikambo [mailto:zwane@arm.linux.org.uk] 
Sent: Tuesday, July 08, 2003 11:42 PM
To: Nakajima, Jun
Cc: Linus Torvalds; linux-kernel@vger.kernel.org; Saxena, Sunil;
Mallick, Asit K; Pallipadi, Venkatesh
Subject: RE: [PATCH] idle using PNI monitor/mwait

On Tue, 8 Jul 2003, Nakajima, Jun wrote:

> That's right. If we have a lot of high-contention locks in the kernel,
> we need to fix the code first, to get benefits for the other
> architectures. 
> 
> "mwait" granularity (64-byte, for example) is given by the cpuid
> instruction, and we did not use it because 1) it's unlikely that the
> other fields of the task structure are modified when it's idle, 2) the
> processor needs to check the flag after mwait anyway, to avoid waking
up
> with a false signal caused by other break events (i.e. mwait is a
hint).

It could still be very handy for polling loops of the form;

while (!ready)
	__asm__ ("pause;");

Jun would there be any thermal advantages over using poll and pause ?

Thanks,
	Zwane
-- 
function.linuxpower.ca
