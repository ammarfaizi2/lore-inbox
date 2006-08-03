Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWHCSrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWHCSrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWHCSrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:47:23 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:65188 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030208AbWHCSrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:47:22 -0400
Message-ID: <44D244B9.907@vmware.com>
Date: Thu, 03 Aug 2006 11:47:21 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Antonio Vargas <windenntw@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com>	 <1154603822.2965.18.camel@laptopd505.fenrus.org>	 <69304d110608030516y16f7d1fdiaccfbe4ecca3084a@mail.gmail.com>	 <44D23924.9040704@vmware.com> <69304d110608031129t5b39e581x3862d8a3dad407f6@mail.gmail.com>
In-Reply-To: <69304d110608031129t5b39e581x3862d8a3dad407f6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:
> I've been fishing in my mail archive and was unable to get any
> discussion about abstract mmu... do you know where I can get more info
> on that?

Here's one useful link:

http://lwn.net/Articles/124961/

>> - but there can be no progress until there is some kind of consensus on
>> what those are, and having an interface in the kernel is a requirement
>> for any deeper level of paravirtualization.
>>
>> Zach
>
> Here I'd like to say that I mentioned both mol and the sun T1 because
> so far we haven't had any discussion on whether any of their
> interfaces are worth copying for the x86 case. Also worth looking at
> would be the work done by IBM for ppc64 and s390, especially the last
> one is prone to be very optimised since their hypervisor work has been
> proven to work for a very long time.
>
> I sure don't mean to diss out both vmware and xen work on the field,
> given the rocky nature of the x86 architecture, but maybe taking a
> look at preexisting work can be a good idea if it hasn't been done
> earlier

Almost nothing from any other architecture makes sense for x86.  X86 is 
not a virtualizable architecture.  It has both classical problems - 
sensitive instructions, and also non-reversible CPU state.  Hardware 
virtualization is now making that easier, but simplifying the OS to 
avoid these problems is actually simpler and more efficient.  PPC64 and 
S390 had the benefit of being designed with virtualization in mind, and 
they still have "paravirtualized" kernel architectures when you look at 
the lower layers.

Zach
