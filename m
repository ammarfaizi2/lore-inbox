Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312894AbSDSUjW>; Fri, 19 Apr 2002 16:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312895AbSDSUjV>; Fri, 19 Apr 2002 16:39:21 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:32248 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312894AbSDSUjV>; Fri, 19 Apr 2002 16:39:21 -0400
Date: Fri, 19 Apr 2002 14:37:44 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Mel <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documenation/vm/numa
Message-ID: <1972720000.1019252264@flay>
In-Reply-To: <m1n0vz4er5.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Note that there are two possible ways to define a pfn, in my mind.
>> One would be page_phys_addr >> PAGE_SHIFT. The other would be the
>> offset of the struct page for that page within the mythical mem_map
>> array. I prefer the former, though it probably contradicts everyone
>> else ;-) It's useful to have some way to pass around a 36 bit address
>> inside a 32 bit field.
> 
> A page frame number (pfn) is definitely the former 
> (page_phys_addr >> PAGE_SHIFT).

That's how I'd conceptually define it ... unfortunately the latter
definition
also matches for non-discontigmem machines, and it's easy to think of
it that way. I guess it's just everything that says "mapnr" in it that needs
killing then ... I'm off to make some patches.

M.

