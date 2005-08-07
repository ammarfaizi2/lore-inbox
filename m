Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbVHGKkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbVHGKkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 06:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbVHGKkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 06:40:09 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:63751 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751449AbVHGKkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 06:40:08 -0400
Message-ID: <42F5E4D4.4080700@vmware.com>
Date: Sun, 07 Aug 2005 03:39:16 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, ak@suse.de, linux-kernel@vger.kernel.org,
       riel@redhat.com, chrisw@osdl.org, pratap@vmware.com
Subject: Re: [PATCH] 8/8 Create MMU 2/3 level accessors in the sub-arch layer
 (i386)
References: <42F46558.9010202@vmware.com.suse.lists.linux.kernel>	<p73wtmz1ekk.fsf@bragg.suse.de>	<20050806115619.GA1560@infradead.org>	<20050806115836.GN8266@wotan.suse.de>	<20050806120141.GA1827@infradead.org>	<42F5016A.2020900@vmware.com> <20050806155832.28f77c37.akpm@osdl.org>
In-Reply-To: <20050806155832.28f77c37.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Aug 2005 10:39:31.0860 (UTC) FILETIME=[4B992D40:01C59B3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Zachary Amsden <zach@vmware.com> wrote:
>  
>
>>>Yeah, I said ugly ones specificly.  There's been some nice previous ones,
>>>      
>>>
>> >but most in this series (all the move of stuff to subarches) are rather
>> >horrible and lack lots of explanation.
>> >  
>> >
>>
>> All of my previous patches have been aimed at fixing bugs, improving 
>> performance, reliability and maintinability of the i386 architecture.  
>>    
>>
>
>Yup, with one or two semi-exceptions, all the patches up to this series
>seem to be good general cleanups - certainly it's good to move all those
>open-coded asm statements into single-site inlines and macros: people keep
>on screwing them up.
>
>We do need to wake the Xen poeple up, make sure that these changes suit
>them as well, or at least don't screw them over (hard to see how it could
>though).
>  
>

This patch in particular is still quite controversial.  I know at least 
Andi has objections (quite valid) to the way PAE/non-PAE was dissected, 
and I would definitely like to address these concerns.  Although I have 
no objection to you committing it to the mm tree right now, please be 
advised that Chris Wright and I will have to converge quite a bit on 
this patch, and will likely be doing a substantial amount of rework here 
to work out Xen compatibilty issues as well as general cleanliness.  If 
it is more convenient for you to live without that churn, by all means 
feel free to, and we can update the patch once everyone is happy.

Zach
