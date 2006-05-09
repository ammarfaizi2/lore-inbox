Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWEIQbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWEIQbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWEIQbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:31:44 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:35847 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750762AbWEIQbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:31:42 -0400
Message-ID: <4460C3D5.1060905@shadowen.org>
Date: Tue, 09 May 2006 17:31:17 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Michael Ellerman <michael@ellerman.id.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kravetz@us.ibm.com
Subject: Re: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
References: <20060509070343.57853679F2@ozlabs.org>	 <44609A7B.7010103@shadowen.org>  <4460A6F3.5060303@shadowen.org> <1147192006.23893.6.camel@localhost.localdomain>
In-Reply-To: <1147192006.23893.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Tue, 2006-05-09 at 15:28 +0100, Andy Whitcroft wrote:		
> 
>>+/*
>>+ * During early boot we need to record the nid from which we will
>>+ * later allocate the section mem_map.  Encode this into the section
>>+ * pointer.  Overload the section_mem_map with this information.
>>+ */ 
> 
> 
> Andy, this all looks pretty good.  Although, it might be nice to
> document this a bit more. 
> 
> First, can you update the mem_section definition comment?  It has a nice
> explanation of how we use section_mem_map, and it would be a shame to
> miss this use.
> 
> Also, your comment says when we _record_ the nid information, but not
> that it is only _used_ during early boot.  I think this is what Mike K.
> missed, and it might be good to clarify.
> 
> How about something like this:
> 
> /*
>  * During early boot, before section_mem_map is used for an actual
>  * mem_map, we use section_mem_map to store the section's NUMA
>  * node.  This keeps us from having to use another data structure.  The
>  * node information is cleared just before we store the real mem_map.
>  */

Yep sounds very sane.  Will update and resend -- best wait and see if it
fixes Michael find its works for him too :).

Thanks.

-apw
