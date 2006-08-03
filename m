Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWHCSgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWHCSgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWHCSgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:36:39 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:5294 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030184AbWHCSgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:36:39 -0400
Message-ID: <44D24236.305@vmware.com>
Date: Thu, 03 Aug 2006 11:36:38 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <44D217A7.9020608@redhat.com>
In-Reply-To: <44D217A7.9020608@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> Zachary Amsden wrote:
>
>> And by NO circumstances, is it required to be a CLOSED source binary
>> blob. In fact, why can't it be open?  In the event of a firmware bug,
>> in fact, it is very desirable to have this software be open so that
>> it can be fixed
>
> You're making a very good argument as to why we should probably
> require that the code linking against such an interface, if we
> decide we want one, should be required to be open source.

Personally, I don't feel a strong requirement that it be open source, 
because I don't believe it violates the intent of the GPL license by 
crippling free distribution of the kernel, requiring some fee for use, 
or doing anything unethical.  There have been charges that the VMI layer 
is deliberately designed as a GPL circumvention device, which I want to 
stamp out now before we try to get any code for integrating to it 
upstreamed.


>> I think you will see why our VMI layer is quite similar to a
>> traditional ROM, and very dissimilar to an evil GPL-circumvention
>> device.
>
>> (?) There are only two reasonable objections I can see to open
>> sourcing the binary layer. 
>
> Since none of the vendors that might use such a paravirtualized
> ROM for Linux actually have one of these reasons for keeping their
> paravirtualized ROM blob closed source, I say we might as well
> require that it be open source.

I think saying require at this point is a bit preliminary for us -- I'm 
trying to prove we're not being evil and subverting the GPL, but I'm 
also not guaranteeing yet that we can open-source the code under a 
specific license.  Sorry about having to doublespeak here - but we have 
not yet got a green light to open source the VMI layer under the GPL.  
Perhaps there are some other issues I haven't conceived of.  We still 
have some source separation issues with creating a build environment due 
to entangled header files - that is being sorted out, but we're 
certainly not ready to distribute an open source buildable VMI layer for 
ESX today.  I sincerely hope we will be very soon.

>
> As for the evilness of a binary interface - the interface between
> kernel and userland is a stable binary interface and is decidedly
> non-evil.  I could see a similar use for a stable paravirtualization
> interface, to make compatibility between Linux and various hypervisor
> versions easier.
>
> As long as it's open source so the thing can be debugged :)

Unfortunately, inlining and patching code will break CFI debug 
information!  I haven't thought of a way to fix this yet other than 
using frame pointers.  At least the possibility of debugging exists.

Zach

