Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWA3S5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWA3S5k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWA3S5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:57:40 -0500
Received: from amdext4.amd.com ([163.181.251.6]:8358 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S964874AbWA3S5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:57:39 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Brian Twichell" <tbrian@us.ibm.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Mon, 30 Jan 2006 12:46:24 -0600
User-Agent: KMail/1.8
cc: "Hugh Dickins" <hugh@veritas.com>, "Dave McCracken" <dmccr@us.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com>
 <43DAA3C9.9070105@us.ibm.com>
In-Reply-To: <43DAA3C9.9070105@us.ibm.com>
MIME-Version: 1.0
Message-ID: <200601301246.27455.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 30 Jan 2006 18:57:07.0826 (UTC)
 FILETIME=[F7D80D20:01C625CE]
X-WSS-ID: 6FC0BE090BO1435296-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 January 2006 16:50, Brian Twichell wrote:
<snip>

>
> Hi,
>
> We collected more granular performance data for the ppc64/hugepage case.
>
> CPI decreased by 3% when shared pagetables were used.  Underlying this was
> a 7% decrease in the overall TLB miss rate.  The TLB miss rate for
> hugepages decreased 39%.  TLB miss rates are calculated per instruction
> executed.
>

Interesting.

Do you know if Dave's patch supports sharing of pte's for 2 MB pages on 
X86_64?

Was there a corresponding improvement in overall transaction throughput for 
the hugetlb, shared pte case?    That is, did the 3% improvement in CPI 
translate to a measurable improvement in the overall OLTP benchmark score?

(I'm assuming your 25-50% improvement measurements, as mentioned in a previous 
note, was for small pages.)

> We didn't collect a profile per se, as we would expect a CPI improvement
> of this nature to be spread over a significant number of functions,
> mostly in user-space.
>
> Cheers,
> Brian
>
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

