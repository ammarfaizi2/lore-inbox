Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161421AbWHDWjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161421AbWHDWjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161428AbWHDWjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:39:31 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:27290 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1161421AbWHDWjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:39:31 -0400
Message-ID: <44D3CCA1.1040503@vmware.com>
Date: Fri, 04 Aug 2006 15:39:29 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       James.Bottomley@steeleye.com, pazke@donpac.ru
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060804183448.GE11244@sequoia.sous-sol.org> <44D3B0F0.2010409@vmware.com> <200608050001.52535.ak@suse.de>
In-Reply-To: <200608050001.52535.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> In the Xen case, 
>> they may want to run a dom-0 hypervisor which is compiled for an actual 
>> hardware sub-arch, such as Summit or ES7000. 
>>     
>
> There is no reason Summit or es7000 or any other subarchitecture 
> would need to do different  virtualization. In fact these subarchitectures 
> are pretty much obsolete by the generic subarchitecture and could be fully
> done by runtime switching.
>   

For privileged domains that have hardware privileges and need to send 
IPIs or something it might make sense.  Othewsie, there is no issue.

>> I would expect to see these new sub-architectures 
>> begin to grow like a rash. 
>>     
>
> I hope not. The i386 subarchitecture setup is pretty bad already
> and mostly obsolete for modern systems.
>   

Yes, I hope not too.

>   
>> I'm now talking lightyears into the future
>>     
>
> tststs - please watch your units.
>   

I realized after I wrote it ;)

> I don't fully agree to move everything into paravirt ops. IMHO
> it should be only done for stuff which is performance critical
> or cannot be virtualized.

Yes, this is all just a crazy idea, not an actual proposal.

> And it's unlikely PCI will be ever a good fit for a Quantum computer @)
>   

Hmm, a quantum bus would only allow one reader of each quantum bit.  So 
you couldn't broadcast without daisy chaining everything.  Could be an 
issue.

>> Maybe someday Xen and VMware can share the same ABI interface and both 
>> use a VMI like layer. 
>>     
>
> The problem with VMI is that while it allows hypervisor side evolution
> it doesn't really allow Linux side evolution with its fixed spec.
>   

It doesn't stop Linux from using the provided primitives in any way is 
sees fit.  So it doesn't top evolution in that sense.  What it does stop 
is having the Linux hypervisor interface grow antlers and have new 
hooves grafted onto it.  What it sorely needed in the interface is a way 
to probe and detect optional features that allow it to grow independent 
of one particular hypervisor vendor.

Zach
