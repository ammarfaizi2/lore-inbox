Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVHHHnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVHHHnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVHHHnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 03:43:01 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:33809 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750750AbVHHHnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 03:43:00 -0400
Message-ID: <42F70D01.2060908@vmware.com>
Date: Mon, 08 Aug 2005 00:42:57 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fawad Lateef <fawadlateef@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Highmemory Problem with RHEL3 .... 2.4.21-5.ELsmp
References: <1e62d137050807205047daf9e0@mail.gmail.com>	 <42F6EB73.3030104@vmware.com> <1e62d13705080800329114fdd@mail.gmail.com>
In-Reply-To: <1e62d13705080800329114fdd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Aug 2005 07:42:11.0546 (UTC) FILETIME=[AFE3DBA0:01C59BEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fawad Lateef wrote:

>	if ((unsigned long)(page - mem_map) > 0x80000) {
>		SetPageReserved(page);
>		set_bit(PG_highmem, &page->flags);
>		atomic_set(&page->count, 0xC4);
>  
>

That seems like a hackish thing to do.  Could you mistake other pages 
with the same count as pages you have reserved?

>After this in my module, i simply use kmap_atomic to map the page
>reserved by me and tried to use that ........ its working perfect in
>both 2.4.x series and also working in 2.6.x .....
>  
>

This suggests a problem with RHEL3.  If it works fine on a vanilla 2.4 
kernel, then by all means try to get support from your vendor.  If it 
works fine on the latest 2.4.X and 2.6.X linux-kernel is probably not 
the best place to look for help, although I can't blame you for trying.  
Maybe someone here already knows the answer, but unfortunately, it is 
not me.

Sorry if I missed context from your earlier posts.

Zach
