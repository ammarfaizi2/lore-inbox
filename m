Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVEEPpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVEEPpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVEEPpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:45:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5092 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262135AbVEEPow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:44:52 -0400
Message-ID: <427A3F6A.6060405@austin.ibm.com>
Date: Thu, 05 May 2005 10:44:42 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: linuxppc64-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
       linux-mm@kvack.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [1/3] add early_pfn_to_nid for ppc64
References: <E1DTQUL-0002WE-D6@pinky.shadowen.org>
In-Reply-To: <E1DTQUL-0002WE-D6@pinky.shadowen.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
> +#define early_pfn_to_nid(pfn)  pa_to_nid(((unsigned long)pfn) << PAGE_SHIFT)
> +#endif

Is there a reason we didn't just use pfn_to_nid() directly here instead 
of pa_to_nid()?  I'm just thinking of having DISCONTIG/NUMA off and 
pfn_to_nid() being #defined to zero for those cases.

