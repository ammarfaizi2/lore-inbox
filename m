Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWHCWuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWHCWuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 18:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWHCWuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 18:50:18 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:56751 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751050AbWHCWuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 18:50:16 -0400
Message-ID: <44D27D8E.8070702@vmware.com>
Date: Thu, 03 Aug 2006 15:49:50 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> <44D26D87.2070208@vmware.com> <1154644383.23655.142.camel@localhost.localdomain> <20060803223035.GA26366@kroah.com>
In-Reply-To: <20060803223035.GA26366@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> And the PowerPC hypervisor interface :)
>
> Have you discussed this with those two groups to make sure you aren't
> doing something that would merely duplicate what they have already done?
>   

I haven't personally.

There's nothing anybody has done that can be considered sufficient to 
address virtualizing i386.  Most of these other architectures have a 
prom / lpar / hypervisor support layer already, which is what we are 
trying to create for i386.  And it is just about 100% architecture 
specific because of the weird non-virtualizable parts of x86.  Page 
tables are completely different beasts when you are using a hashed page 
table scheme versus hardware page tables, so there is not even common 
ground in the MMU.  About the only common ground would be the cede / 
prod for remote notifications, but it is all so architecture dependent 
that I really think any idea of creating a common cross architecture 
hypervisor layer is just impossible at this time.

We need to focus on establishing that lower layer interface for i386 
instead of trying to come up with the grand unified hypervisor 
interface, which could be years away.  For now, I think it's fair to say 
there is about zero duplication, and any that we find along the way can 
go into common Linux interfaces.

Zach
