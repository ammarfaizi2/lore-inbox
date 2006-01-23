Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWAWX63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWAWX63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWAWX63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:58:29 -0500
Received: from amdext4.amd.com ([163.181.251.6]:49879 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S964986AbWAWX62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:58:28 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Dave McCracken" <dmccr@us.ibm.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Mon, 23 Jan 2006 17:58:08 -0600
User-Agent: KMail/1.8
cc: "Robin Holt" <holt@sgi.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <20060117235302.GA22451@lnx-holt.americas.sgi.com>
In-Reply-To: <20060117235302.GA22451@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Message-ID: <200601231758.08397.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 23 Jan 2006 23:58:09.0637 (UTC)
 FILETIME=[DCA17150:01C62078]
X-WSS-ID: 6FCBB21B0BO266540-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 17:53, Robin Holt wrote:
> Dave,
>
> This appears to work on ia64 with the attached patch.  Could you
> send me any test application you think would be helpful for me
> to verify it is operating correctly?  
<snip>

Dave,

Like Robin, I would appreciate a test application, or at least a description 
of how to write one, or some other trick to figure out if this is working.

I scanned through this thread looking for a test application, and didn't see 
one.   Is it sufficient just to create a large shared read-only mmap'd file 
and share it across a bunch of process to get this code invoked?   How large 
of a file is needed (on x86_64), assuming that we just turn on the pte level 
of sharing?   And what kind of alignment constraints do we end up under in 
order to make the sharing happen?   (My guess would be that there aren't any 
such constraints (well, page alignment.. :-)  if we are just sharing pte's.)

I turned on the PT_DEBUG stuff, but thus far have found no evidence of pte 
sharing actually occurring in a normal system boot.  I'm surprised by that as 
I (naively?) would have expected shared libraries to use shared ptes.

Best Regards,
-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

