Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVLVSWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVLVSWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbVLVSWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:22:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14292 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030227AbVLVSWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:22:31 -0500
Message-ID: <43AAEDCC.4080909@redhat.com>
Date: Thu, 22 Dec 2005 13:17:48 -0500
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: William Cohen <wcohen@redhat.com>, Stephane Eranian <eranian@hpl.hp.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: quick overview of the perfmon2 interface
References: <20051219113140.GC2690@frankl.hpl.hp.com> <20051220025156.a86b418f.akpm@osdl.org> <20051222115632.GA8773@frankl.hpl.hp.com> <20051222120558.GA31303@infradead.org> <43AAC854.6020608@redhat.com> <20051222172303.GC6038@infradead.org>
In-Reply-To: <20051222172303.GC6038@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Dec 22, 2005 at 10:37:56AM -0500, William Cohen wrote:
> 
>>Both OProfile and PAPI are open source and could use such an performance 
>>monitoring interface.
>>
>>One of the problems right now is there is a patchwork of performance 
>>monitoring support. Each instrumentation system has its own set of 
>>drivers/patches. Few have support integrated into the kernel, e.g. 
>>OProfile. However, the OProfile driver provides only a subset of the 
>>performance monitoring support, system-wide sampling. The OProfile 
>>driver doesn't allow per-thread monitoring or stopwatch style 
>>measurement, which can be very useful for some performance monitoring 
>>applications.
> 
> 
> What about improving oprofile then?  Unlike the vtune or perfoman people
> the oprofile authors have shown they actually are able to design sensible
> interfaces, and oprofile has broad plattform support over most support
> architectures.

At what point would adding interfaces to OProfile turn it into perfmon? 
Some of the additions like per-thread monitoring would require signicant 
changes in the kernel that perfmon already implements. The IA64 OProfile 
already uses the perfmon support in the kernel.

Perfmon2 has support for ia64, p6, pentium4, x86_64, ppc, and mips, so 
there is multiple architectures support. OProfile currently supports 
more architectures: alpha,  arm,  i386 (p6/pentium4/athlon),  ia64, 
mips,  ppc,  ppc64,  x86-64, and a fall-back timer mechanisms.

-Will
