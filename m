Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWA0Iea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWA0Iea (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 03:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWA0Ie3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 03:34:29 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:16332 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751228AbWA0Ie3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 03:34:29 -0500
Message-ID: <43D9DB12.20706@us.ibm.com>
Date: Fri, 27 Jan 2006 00:34:26 -0800
From: Sridhar Samudrala <sri@us.ibm.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 0/9] Critical Mempools
References: <1138217992.2092.0.camel@localhost.localdomain> <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com> <43D954D8.2050305@us.ibm.com> <Pine.LNX.4.62.0601261516160.18716@schroedinger.engr.sgi.com> <43D95BFE.4010705@us.ibm.com> <20060127000304.GG10409@kvack.org>
In-Reply-To: <20060127000304.GG10409@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Thu, Jan 26, 2006 at 03:32:14PM -0800, Matthew Dobson wrote:
>   
>>> I thought the earlier __GFP_CRITICAL was a good idea.
>>>       
>> Well, I certainly could have used that feedback a month ago! ;)  The
>> general response to that patchset was overwhelmingly negative.  Yours is
>> the first vote in favor of that approach, that I'm aware of.
>>     
>
> Personally, I'm more in favour of a proper reservation system.  mempools 
> are pretty inefficient.  Reservations have useful properties, too -- one 
> could reserve memory for a critical process to use, but allow the system 
> to use that memory for easy to reclaim caches or to help with memory 
> defragmentation (more free pages really helps the buddy allocator).
>
>   
>>> Gfp flag? Better memory reclaim functionality?
>>>       
>> Well, I've got patches that implement the GFP flag approach, but as I
>> mentioned above, that was poorly received.  Better memory reclaim is a
>> broad and general approach that I agree is useful, but will not necessarily
>> solve the same set of problems (though it would likely lessen the severity
>> somewhat).
>>     
>
> Which areas are the priorities for getting this functionality into?  
> Networking over particular sockets?  A GFP_ flag would plug into the current 
> network stack trivially, as sockets already have a field to store the memory 
> allocation flags.
>   
Yes, i have posted patches that use this exact approach last month that 
use a critical page pool with
GFP_CRITICAL flag.
      http://lkml.org/lkml/2005/12/14/65
      http://lkml.org/lkml/2005/12/14/66

Thanks
Sridhar

