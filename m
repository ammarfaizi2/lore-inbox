Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWJCGks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWJCGks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 02:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWJCGkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 02:40:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31393 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964828AbWJCGkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 02:40:47 -0400
Date: Tue, 3 Oct 2006 02:40:30 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sandeen <sandeen@sandeen.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
       Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@ucw.cz>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061003064030.GA23492@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Eric Sandeen <sandeen@sandeen.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
	Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@ucw.cz>
References: <20061002194711.GA1815@redhat.com> <20061003052219.GA15563@redhat.com> <4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002231945.f2711f99.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 11:19:45PM -0700, Andrew Morton wrote:
 > On Tue, 03 Oct 2006 00:43:01 -0500
 > Eric Sandeen <sandeen@sandeen.net> wrote:
 > 
 > > Dave Jones wrote:
 > > 
 > > > So I managed to reproduce it with an 'fsx foo' and a
 > > > 'fsstress -d . -r -n 100000 -p 20 -r'. This time I grabbed it from
 > > > a vanilla 2.6.18 with none of the Fedora patches..
 > > > 
 > > > I'll give 2.6.18-git a try next.
 > > > 
 > > > 		Dave
 > > > 
 > > > ----------- [cut here ] --------- [please bite here ] ---------
 > > > Kernel BUG at fs/buffer.c:2791
 > > 
 > > I had thought/hoped that this was fixed by Jan's patch at 
 > > http://lkml.org/lkml/2006/9/7/236 from the thread started at 
 > > http://lkml.org/lkml/2006/9/1/149, but it seems maybe not.  Dave hit this bug 
 > > first by going through that new codepath....
 > 
 > Yes, Jan's patch is supposed to fix that !buffer_mapped() assertion.  iirc,
 > Badari was hitting that BUG and was able to confirm that Jan's patch
 > (3998b9301d3d55be8373add22b6bc5e11c1d9b71 in post-2.6.18 mainline) fixed
 > it.

Ok, this afternoon I was definitly running a kernel with that patch in it,
and managed to get a trace (It was the one from the top of this thread
that unfortunatly got truncated).

Now, I can't reproduce it on a plain 2.6.18+that patch.
I'll leave the stress test running overnight, and see if anything
falls out in the morning.

	Dave

-- 
http://www.codemonkey.org.uk
