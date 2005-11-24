Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVKXPfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVKXPfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVKXPf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:35:29 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:6419 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932141AbVKXPf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:35:29 -0500
Message-ID: <4385DDBE.3040208@argo.co.il>
Date: Thu, 24 Nov 2005 17:35:26 +0200
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
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com> <4384E7F2.2030508@pobox.com> <20051123223007.GA5921@wotan.suse.de> <20051124001700.GC14246@kvack.org> <20051124065037.GZ20775@brahms.suse.de> <4385DB32.7010605@argo.co.il> <20051124152924.GB5921@wotan.suse.de>
In-Reply-To: <20051124152924.GB5921@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2005 15:35:27.0597 (UTC) FILETIME=[B1DE61D0:01C5F10C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>>      
>>>
>>As an example, an NFS server reads some data pages using iSCSI and sends 
>>them using NFS/TCP (or vice versa).
>>    
>>
>
>For TX this can be done zero copy using a sendfile like setup.
>  
>
Yes, or with aio send for anonymous memory.

>For RX it may help - but my point was that most applications
>are not structured in this simple way.
>
>  
>
Agreed. But those that do care, care very much. The data mover 
applications, simply because they don't touch the data, expect very high 
bandwidth.

>>As long as they can be turned off. Not all usespace applications want to 
>>touch the data immediately.
>>    
>>
>
>Perhaps.  And lots of others might. Of course the simple
>network benchmarks don't so the number on them look good.
>
>  
>
There are very real non-benchmark applications that want this.

>Just pointing out that it's not clear it will always be a big help.
>
>  
>
Agree it should default to in-cache.

