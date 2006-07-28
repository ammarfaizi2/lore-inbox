Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWG1GPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWG1GPc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 02:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWG1GPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 02:15:31 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:55133 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751065AbWG1GPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 02:15:31 -0400
Message-ID: <44C9AB78.8060104@de.ibm.com>
Date: Fri, 28 Jul 2006 08:15:20 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/2] CPU hotplug compatible alloc_percpu
References: <1153761414.2986.136.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060727091843.c2192bbc.pj@sgi.com>
In-Reply-To: <20060727091843.c2192bbc.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Martin wrote:
>> +static inline int percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
>> +				       int cpu)
>> +{
> 
> It seems odd to me that this signature of percpu_populate_mask()
> has its last argument 'int cpu' for the !CONFIG_SMP case, but
> the SMP signatures have 'cpumask_t mask'.
> 
> Shouldn't this function signature be the same for all CONFIG's?

Looks like a mistake. Luckily, it won't cause any harm, though.
I will send a patch.

Thank you for reviewing.

Martin


