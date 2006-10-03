Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWJCQps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWJCQps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWJCQps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:45:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60075 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932281AbWJCQpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:45:47 -0400
Date: Tue, 3 Oct 2006 12:45:37 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Eric Sandeen <sandeen@sandeen.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
       Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@ucw.cz>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061003164537.GC23492@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Eric Sandeen <sandeen@sandeen.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
	Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@ucw.cz>
References: <20061002194711.GA1815@redhat.com> <20061003052219.GA15563@redhat.com> <4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org> <20061003064030.GA23492@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003064030.GA23492@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 02:40:30AM -0400, Dave Jones wrote:
 
 >  > > > ----------- [cut here ] --------- [please bite here ] ---------
 >  > > > Kernel BUG at fs/buffer.c:2791
 >  > > 
 >  > > I had thought/hoped that this was fixed by Jan's patch at 
 >  > > http://lkml.org/lkml/2006/9/7/236 from the thread started at 
 >  > > http://lkml.org/lkml/2006/9/1/149, but it seems maybe not.  Dave hit this bug 
 >  > > first by going through that new codepath....
 >  > 
 >  > Yes, Jan's patch is supposed to fix that !buffer_mapped() assertion.  iirc,
 >  > Badari was hitting that BUG and was able to confirm that Jan's patch
 >  > (3998b9301d3d55be8373add22b6bc5e11c1d9b71 in post-2.6.18 mainline) fixed
 >  > it.
 > 
 > Ok, this afternoon I was definitly running a kernel with that patch in it,
 > and managed to get a trace (It was the one from the top of this thread
 > that unfortunatly got truncated).
 > 
 > Now, I can't reproduce it on a plain 2.6.18+that patch.
 > I'll leave the stress test running overnight, and see if anything
 > falls out in the morning.
 
Been chugging away for 10 hrs now without repeating that incident. Hmm.
That patch looks like good -stable material. I'll keep digging to
see if I can somehow reproduce the problem I saw with the patch applied,
but in absense of something better, I think we should go with it.

One thing that did happen in the 10hrs was fsx-over-NFS spewed some
nasty looking trace. I'll post that separately next.

	Dave

-- 
http://www.codemonkey.org.uk
