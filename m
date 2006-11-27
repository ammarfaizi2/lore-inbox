Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758210AbWK0Nqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210AbWK0Nqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 08:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758211AbWK0Nqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 08:46:46 -0500
Received: from il.qumranet.com ([62.219.232.206]:23002 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758210AbWK0Nqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 08:46:46 -0500
Message-ID: <456AEC43.40307@qumranet.com>
Date: Mon, 27 Nov 2006 15:46:43 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Avi Kivity <avi@qumranet.com>,
       kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 19/38] KVM: Make __set_efer() an arch operation
References: <456AD5C6.1090406@qumranet.com> <20061127122938.0518325015E@cleopatra.q> <20061127133944.GA4155@infradead.org>
In-Reply-To: <20061127133944.GA4155@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Nov 27, 2006 at 12:29:38PM -0000, Avi Kivity wrote:
>   
>>  #ifdef __x86_64__
>> -	__set_efer(vcpu, sregs->efer);
>> +	kvm_arch_ops->set_efer(vcpu, sregs->efer);
>>  #endif
>>     
>
> I think it would be much better to make ->set_efer a noop for 32bit,
> and have different operation vectors for 32 vs 64 bit.
>
>   

Okay.  I'll submit an incremental patch as part of a larger cleanup I'm 
planning.


>>  #ifdef __x86_64__
>> -	__set_efer(vcpu, 0);
>> +	vmx_set_efer(vcpu, 0);
>>  #endif
>>     
>
> Similarly vmx_set_efer should just become a noop on 32bit.
>   

Ok.

-- 
error compiling committee.c: too many arguments to function

