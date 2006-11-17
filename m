Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424370AbWKQISE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424370AbWKQISE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 03:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424383AbWKQISE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 03:18:04 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:58489 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1424370AbWKQISB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 03:18:01 -0500
Message-ID: <455D7034.1070503@qumranet.com>
Date: Fri, 17 Nov 2006 10:17:56 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       uril@qumranet.com
Subject: Re: [PATCH 3/3] KVM: Expose MSRs to userspace
References: <455CA70C.9060307@qumranet.com>	<20061116180422.0CC9325015E@cleopatra.q>	<20061116170214.b7785bd0.akpm@osdl.org>	<455D62D1.6040203@qumranet.com> <20061117001510.58f01b3c.akpm@osdl.org>
In-Reply-To: <20061117001510.58f01b3c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Nov 2006 08:18:00.0819 (UTC) FILETIME=[E5746430:01C70A20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 17 Nov 2006 09:20:49 +0200
> Avi Kivity <avi@qumranet.com> wrote:
>
>   
>>>> +out_vcpu:
>>>> +	vcpu_put(vcpu);
>>>> +
>>>> +	return rc;
>>>> +}
>>>>     
>>>>         
>>> This function returns no indication of how many msrs it actually did set. 
>>> Should it?
>>>   
>>>       
>> It can't hurt.  Is returning the number of msrs set in the return code 
>> (ala short write) acceptable, or do I need to make this a read/write ioctl?
>>
>>     
>
> I'd have thought that you'd just copy the number written into msrs->nmsrs via
>
> 	msrs->nmsrs = num_entries;
>
> like kvm_dev_ioctl_set_msrs() does.  Dunno...
>   

It means making it an _IOWR() ioctl, but no matter.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

