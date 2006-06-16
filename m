Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWFPVTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWFPVTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 17:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWFPVTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 17:19:23 -0400
Received: from relay03.pair.com ([209.68.5.17]:42247 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751420AbWFPVTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 17:19:22 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 16 Jun 2006 16:19:20 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Andi Kleen <ak@suse.de>
cc: Brent Casavant <bcasavan@sgi.com>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>, Jes Sorensen <jes@sgi.com>,
       Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
In-Reply-To: <200606161740.18611.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606161615450.23743@turbotaz.ourhouse>
References: <200606140942.31150.ak@suse.de> <200606161656.40930.ak@suse.de>
 <20060616102516.A91827@pkunk.americas.sgi.com> <200606161740.18611.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for the empty reply! Pine over a laggy SSH connection is annoying 
sometimes)

On Fri, 16 Jun 2006, Andi Kleen wrote:

>
>> To this last point, it might be more reasonable to map in a page that
>> contained a new structure with a stable ABI, which mirrored some of
>> the task_struct information, and likely other useful information as
>> needs are identified in the future.  In any case, it would be hard
>> to beat a single memory read for performance.
>
> That would mean making the context switch and possibly other
> things slower.

Well, if every process had a page of its own, what would the context 
switch overhead be?

But, I'm not advocating exporting anything. Though I sort of like the 
vgetcpu() idea because I was working on a user-space slab allocator 
recently and magazines could use vgetcpu() instead of pthread keys.
(Also means if threads > cpus I'd get better results).

Thanks,
Chase
