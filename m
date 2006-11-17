Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933756AbWKQVFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933756AbWKQVFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755912AbWKQVBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:01:37 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:50548 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1755906AbWKQVBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nREwlR8nIWniOwOybe29+FQ2TCoxXaPaUBerQT786mr35unV4nan4HmDxogPSLaGXtqF0xzL1ThSp3NJh16i0zSHHFFTX/7OM9WJaGffZFASoecEdqwwzxYTMdPNzasQ07FI3gGojYQpK/LGFdKPN7A5cP+81vlUed7jaxxGLhI=
Message-ID: <38b2ab8a0611171301pe16229ch441ec24c538b1998@mail.gmail.com>
Date: Fri, 17 Nov 2006 22:01:33 +0100
From: "Francis Moreau" <francis.moro@gmail.com>
To: a.p.zijlstra@chello.nl
Subject: Re : vm: weird behaviour when munmapping
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[me moving to Gmail 'cause yahoo sucks !]

On Fri, 2006-11-17 at 14:12 +0000, moreau francis wrote:
> Peter Zijlstra wrote:
>
> The new object is the one allocated using:
>	new = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
>

Of course but at this point the choice of the new VMA is already made
by the caller. So in our case do_munmap() decided that B is the new
one as you said. But I still don't see why...

And as I said previously it will end up by calling consecutively:

        vma->vm_ops->open(B)
        vma->vm_ops->close(B)


> Please read Mel Gorman's book on memory management to gain a better
> understanding.
>
> http://www.phptr.com/bookstore/product.asp?isbn=0131453483&rl=1

thanks for the link, but I don't expect to find out the answer to this
very specific question in it.

Francis
