Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVGHFoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVGHFoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 01:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVGHFoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 01:44:19 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:12441 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262613AbVGHFlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 01:41:46 -0400
Message-ID: <42CE12D0.7060601@jp.fujitsu.com>
Date: Fri, 08 Jul 2005 14:44:49 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David.Mosberger@acm.org
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.13-rc1 07/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com> <42CB6961.2060508@jp.fujitsu.com> <ed5aea4305070721373480591d@mail.gmail.com>
In-Reply-To: <ed5aea4305070721373480591d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david mosberger wrote:
>>   - could anyone write same barrier for intel compiler?
>>     Tony or David, could you help me?
> 
> I think it might be best to make ia64_mca_barrier() a proper
> subroutine written in assembly code.  Yes, that costs some time, but
> we're talking about wasting 1,000+ cycles just to consume the value
> read via readX(), so the call-overhead is actually overlapped and
> completely trivial.

Yes, of course speed is worth, but in some situations it can happen
that the data integrity is better than the speed.
(sounds crazy but fact)

I'm not familiar with assembly code for intel compiler. So David,
could you write another macro of ia64_mca_barrier() or a proper
subroutine instead?

Thanks,
H.Seto

