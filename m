Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbULVOYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbULVOYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 09:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbULVOYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 09:24:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22663 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261840AbULVOYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 09:24:14 -0500
Date: Wed, 22 Dec 2004 09:23:44 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Zou, Nanhai" <nanhai.zou@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       lista4@comhem.se, linux-kernel@vger.kernel.org, mr@ramendik.ru,
       kernel@kolivas.org
Subject: RE: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013CA39@pdsmsx402.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0412220923190.21365@chimarrao.boston.redhat.com>
References: <894E37DECA393E4D9374E0ACBBE7427013CA39@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2004, Zou, Nanhai wrote:

>> That's Marcelo's vm-pageout-throttling.patch, which is one
>> of the essential ingredients in avoiding false OOM kills.
>>
>> I'm waiting on some test results for another two patches
>> that I suspect are also needed ...

> Seems that vmscan-ignore-swap-token-when-in-trouble.patch +
> vm-pageout-throttling.patch dose not fix the problem,
> I ran stress test for 2.6.9 + these 2 patches.
> OOM killer was still triggered.

You need the oneline patch that Andrew Morton posted two
days ago:

Message-Id: <20041219230754.64c0e52e.akpm@osdl.org>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
