Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUKIWIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUKIWIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUKIWIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:08:20 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2759 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261724AbUKIWIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:08:10 -0500
Date: Tue, 09 Nov 2004 14:07:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Brent Casavant <bcasavan@sgi.com>, Andi Kleen <ak@suse.de>,
       "Adam J. Richter" <adam@yggdrasil.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <477220000.1100038041@flay>
In-Reply-To: <Pine.LNX.4.44.0411092056090.5291-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0411092056090.5291-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, November 09, 2004 21:08:11 +0000 Hugh Dickins <hugh@veritas.com> wrote:

> On Tue, 9 Nov 2004, Martin J. Bligh wrote:
>>  
>> > I'm irritated to realize that we can't change the default for SysV
>> > shared memory or /dev/zero this way, because that mount is internal.
>> 
>> Boggle. shmem I can perfectly understand, and have been intending to
>> change for a while. But why /dev/zero ? Presumably you'd always want
>> that local?
> 
> I was meaning the mmap shared writable of /dev/zero, to get memory
> shared between parent and child and descendants, a restricted form
> of shared memory.  I was thinking of them running on different cpus,
> you're suggesting they'd at least be on the same node.  I dare say,
> I don't know.  I'm not desperate to be able to set some other mpol
> default for all of them (and each object can be set in the established
> way), just would have been happier if the possibility of doing so came
> for free with the mount option work.

Oh yeah ... the anon mem allocator trick. Mmmm. Not sure that should
have a different default than normal alloced memory, but either way,
what you're suggesting makes a whole lot more sense to me know than
just straight /dev/zero ;-)

Thanks for the explanation.

M.

