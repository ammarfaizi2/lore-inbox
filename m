Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267614AbSLSKXH>; Thu, 19 Dec 2002 05:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbSLSKXG>; Thu, 19 Dec 2002 05:23:06 -0500
Received: from holomorphy.com ([66.224.33.161]:40640 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267614AbSLSKXF>;
	Thu, 19 Dec 2002 05:23:05 -0500
Date: Thu, 19 Dec 2002 02:27:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: David Lang <david.lang@digitalinsight.com>, Robert Love <rml@tech9.net>,
       Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 15000+ processes -- poor performance ?!
Message-ID: <20021219102720.GT31800@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	David Lang <david.lang@digitalinsight.com>,
	Robert Love <rml@tech9.net>, Till Immanuel Patzschke <tip@inw.de>,
	lse-tech <lse-tech@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <1040262178.855.106.camel@phantasy> <Pine.LNX.4.44.0212181743350.7848-100000@dlang.diginsite.com> <20021219020552.GO31800@holomorphy.com> <200212191015.gBJAFss28329@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212191015.gBJAFss28329@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 December 2002 00:05, William Lee Irwin III wrote:
>> Well, a better solution would be a userspace free of /proc/
>> dependency.
>> Or actually fixing the kernel. proc_pid_readdir() wants an
>> efficiently indexable linear list, e.g. TAOCP's 6.2.3 "Linear List
>> Representation". At that point its expense is proportional to the
>> buffer size and "seeking" about the list as it is wont to do is
>> O(lg(processes)).

On Thu, Dec 19, 2002 at 01:05:03PM -0200, Denis Vlasenko wrote:
> A short-time solution: run top d 30 to make it refresh only every 30 seconds.
> This will greatly reduce top's own load skew.

As userspace solutions go your suggestions is just as good. The kernel
still needs to get its act together and with some urgency.


Bill
