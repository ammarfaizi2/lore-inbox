Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVHYR02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVHYR02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVHYR02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:26:28 -0400
Received: from ns.suse.de ([195.135.220.2]:13732 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751233AbVHYR01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:26:27 -0400
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] x86_64 Avoid some atomic operations during address space destruction
Date: Thu, 25 Aug 2005 19:26:09 +0200
User-Agent: KMail/1.8
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pratap Subrahmanyam <pratap@vmware.com>, Andrew Morton <akpm@osdl.org>
References: <42F5FB9A.5000708@vmware.com> <200508251854.10060.ak@suse.de> <430DFC14.50906@vmware.com>
In-Reply-To: <430DFC14.50906@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508251926.11219.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 August 2005 19:12, Zachary Amsden wrote:
> Andi Kleen wrote:
> >On Sunday 07 August 2005 14:16, Zachary Amsden wrote:
> >
> >
> >FYI I have queued it, but cannot apply it because the necessary generic
> >code support is still not in mainline.
>
> Here's the patch for generic / i386 support; it's already in the -mm tree.

I'll probably not put that into my tree because I try to avoid generic
patches of other people - i assume it's queued for mainline.

If you want you can include the x86-64 patch with that submission too
(it's fine for me), alternatively I'll submit it later when I do the next 
merge from i386 (that might take some time though) or remember about it 
for some other reason. 

>
> >Do you have any other optimizations pending for x86-64?
> >
> >There is still the iopl optimization that you did that is on my TODO list
> > to add. Anything else.
>
> I started porting the IOPL work, but got confused in my tree and end up
> patching asm-i386 with x86-64 code.  The joy of  unenforced source control!

Ok. When you don't get around to it I'll eventually.

>
> I have some other MMU optimizations pending that will hopefully be a win
> for all architectures; still measuring which alternative is best there.

Ok.  Thanks. Please keep me updated on that.

-Andi
