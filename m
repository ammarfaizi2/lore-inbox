Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVDAIqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVDAIqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDAIqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:46:09 -0500
Received: from pcsmail.patni.com ([203.124.139.197]:9900 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP id S261595AbVDAIpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:45:55 -0500
Message-ID: <000f01c53697$3a328c40$5e91a8c0@patni.com>
Reply-To: "lk" <linux_kernel@patni.com>
From: "lk" <linux_kernel@patni.com>
To: "Josef E. Galea" <josefeg@euroweb.net.mt>, <linux-kernel@vger.kernel.org>
References: <424C09B0.2080502@euroweb.net.mt>
Subject: Re: Linux virtual memory manager
Date: Fri, 1 Apr 2005 00:45:59 -0800
Organization: Patni
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The try_to_swap_out( ) function attempts to free a given page frame, either
discarding or swapping out its contents. It will add the page to swap and
remove the entry from page table of page cache.

In 2.6.x series you can look into shrink_list() function which is called
from kswapd daemon. The function you are trying to look for an
equivalent of try_to_swap_out() is add_to_swap() and after that
try_to_unmap() which will add the page of page cache to swap cache
and remove entry from the page table respectively.

regards
lk

----- Original Message ----- 
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, March 31, 2005 6:31 AM
Subject: Linux virtual memory manager


> Hi,
>
> Can someone point me to a document explaining the differences between
> the 2.4 and the 2.6 virtual memory manager. Particularly I am looking
> for the function/s that replaces the try_to_swap_out() in the 2.6.x
> series of kernels.
>
> Thanks
> Josef
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


