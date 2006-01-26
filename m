Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWAZXBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWAZXBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWAZXBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:01:53 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:39660 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030192AbWAZXBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:01:52 -0500
Message-ID: <43D954D8.2050305@us.ibm.com>
Date: Thu, 26 Jan 2006 15:01:44 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 0/9] Critical Mempools
References: <1138217992.2092.0.camel@localhost.localdomain> <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 25 Jan 2006, Matthew Dobson wrote:
> 
> 
>>Using this new approach, a subsystem can create a mempool and then pass a
>>pointer to this mempool on to all its slab allocations.  Anytime one of its
>>slab allocations needs to allocate memory that memory will be allocated
>>through the specified mempool, rather than through alloc_pages_node() directly.
> 
> 
> All subsystems will now get more complicated by having to add this 
> emergency functionality?

Certainly not.  Only subsystems that want to use emergency pools will get
more complicated.  If you have a suggestion as to how to implement a
similar feature that is completely transparent to its users, I would *love*
to hear it.  I have tried to keep the changes to implement this
functionality to a minimum.  As the patches currently stand, existing slab
allocator and mempool users can continue using these subsystems without
modification.


>>Feedback on these patches (against 2.6.16-rc1) would be greatly appreciated.
> 
> 
> There surely must be a better way than revising all subsystems for 
> critical allocations.

Again, I could not find any way to implement this functionality without
forcing the users of the functionality to make some, albeit very minor,
changes.  Specific suggestions are more than welcome! :)

Thanks!

-Matt
