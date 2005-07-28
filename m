Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVG1Idu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVG1Idu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVG1Idt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:33:49 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:36735 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261336AbVG1IcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:32:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=o9yGwrtI+AzgUktb/838hPc+kI+hwYrOUYFEHalDNNCxWNdPrPeVNDolRtNBnyT2kkWS/PP5tXLEQHzeg7XpF+etZaJDXPAqJHFVTHUASzb5ZzKfchtSlYDrIcRHH2SgCZEpRAOgte/w8lo2IeVehhvyxXze83Ja7o1Bf0VXNwU=  ;
Message-ID: <42E897FD.6060506@yahoo.com.au>
Date: Thu, 28 Jul 2005 18:31:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Ingo Molnar <mingo@elte.hu>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
References: <10613.1122538148@kao2.melbourne.sgi.com>
In-Reply-To: <10613.1122538148@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Thu, 28 Jul 2005 09:41:18 +0200,
> Ingo Molnar <mingo@elte.hu> wrote:

>>i'm wondering, is the switch_stack at the same/similar place as
>>next->thread_info? If yes then we could simply do a
>>prefetch(next->thread_info).
> 
> 
> No, they can be up to 30K apart.  See include/asm-ia64/ptrace.h.
> thread_info is at ~0xda0, depending on the config.  The switch_stack
> can be as high as 0x7bd0 in the kernel stack, depending on why the task
> is sleeping.
> 

Just a minor point, I agree with David: I'd like it to be called
prefetch_task(), because some architecture may want to prefetch other
memory.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
