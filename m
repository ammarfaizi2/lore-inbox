Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290886AbSASAa7>; Fri, 18 Jan 2002 19:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290887AbSASAau>; Fri, 18 Jan 2002 19:30:50 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:58612 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290886AbSASAal>; Fri, 18 Jan 2002 19:30:41 -0500
Message-Id: <200201190030.g0J0UYq11751@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: "Randy.Dunlap" <rddunlap@osdl.org>, Robert Love <rml@tech9.net>
Subject: Re: how many cpus can linux support for SMP?
Date: Fri, 18 Jan 2002 16:30:33 -0800
X-Mailer: KMail [version 1.3.1]
Cc: Barry Wu <wqb123@yahoo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0201171141110.13155-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0201171141110.13155-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 January 2002 11:43 am, Randy.Dunlap wrote:
> On 17 Jan 2002, Robert Love wrote:
> | On Thu, 2002-01-17 at 01:59, Barry Wu wrote:
> | > I am new to this mail list. I do not know how many CPUs linux can
> | > support well using SMP. If some one knows, please give me
> | > a reply. Thanks.
> |
> | 32.
> |
> | "well" though may mean many things and the answer depends on your
> | workload.
>
> On x86, using APICs, Pentium III maximum is 15 due to APIC addressing.
> The IBM multiquad patch uses different APIC addressing (physical vs.
> logical), so it goes beyond 15.

Minor nitpick:  multiquad uses clustered logical (aka hierarchal) mode.

> Pentium 4 APICs have addressing up to 255 IIRC, so they can do more
> than P-III's 15.

Yup.  xAPICs (and SAPICs for IA64) are the only ones that can get beyond 14 
(0x0F is the broadcast ID) using physical addressing.  I'm kicking around 
some patches that use physical mode on a xAPIC NUMA box.

-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com

