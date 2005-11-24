Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbVKXPYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVKXPYi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVKXPYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:24:37 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:43794 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751371AbVKXPYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:24:37 -0500
Message-ID: <4385DB32.7010605@argo.co.il>
Date: Thu, 24 Nov 2005 17:24:34 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Benjamin LaHaise <bcrl@kvack.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Grover <andrew.grover@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com> <4384E7F2.2030508@pobox.com> <20051123223007.GA5921@wotan.suse.de> <20051124001700.GC14246@kvack.org> <20051124065037.GZ20775@brahms.suse.de>
In-Reply-To: <20051124065037.GZ20775@brahms.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2005 15:24:34.0905 (UTC) FILETIME=[2CD57C90:01C5F10B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>Don't forget that there are benefits of not polluting the cache with the 
>>traffic for the incoming skbs.
>>    
>>
>
>Is that a general benefit outside benchmarks? I would expect
>most real programs to actually do something with the data
>- and that usually involves needing it in cache.
>
>  
>
As an example, an NFS server reads some data pages using iSCSI and sends 
them using NFS/TCP (or vice versa).

>>In the I/O AT case it might make sense to do a few prefetch()es of the 
>>userland data on the return-to-userspace code path.  
>>    
>>
>
>Some prefetches for user space might be a good idea yes
>
>  
>
As long as they can be turned off. Not all usespace applications want to 
touch the data immediately.



