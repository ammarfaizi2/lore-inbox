Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966369AbWK2IfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966369AbWK2IfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966377AbWK2IfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:35:21 -0500
Received: from mga05.intel.com ([192.55.52.89]:1555 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S966369AbWK2IfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:35:20 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,473,1157353200"; 
   d="scan'208"; a="170397285:sNHT20475700"
Message-ID: <456D4648.7000509@linux.intel.com>
Date: Wed, 29 Nov 2006 09:35:20 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] Mark rdtsc as sync only for netburst, not for core2
References: <1164709708.3276.72.camel@laptopd505.fenrus.org>	 <200611281136.29066.ak@suse.de> <1164774239.15257.5.camel@ymzhang>	 <456D372C.9080800@linux.intel.com> <1164787104.2899.7.camel@ymzhang>
In-Reply-To: <1164787104.2899.7.camel@ymzhang>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang, Yanmin wrote:
>> but second of all, the core2 cpus are dual core so.. .what does it 
>> bring you at all?
> 
> When there is only one cpu (or UP), the go backwards issue doesn't exist,

it does exist for single-socket dual core already. And core2 is dual 
core...

> so
> don't use cpuid here for UP. Another function init_amd already does so.
> 
not anymore.. that got fixed very recently...
(but you are right; on AMD the speculation is even bigger so there 
even on single core you need cpuid)
