Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262759AbSJGUWU>; Mon, 7 Oct 2002 16:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262762AbSJGUWU>; Mon, 7 Oct 2002 16:22:20 -0400
Received: from dsl-213-023-021-129.arcor-ip.net ([213.23.21.129]:7852 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262759AbSJGUWT>;
	Mon, 7 Oct 2002 16:22:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0  -  (NUMA))
Date: Mon, 7 Oct 2002 22:22:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0210071222340.10168-100000@penguin.transmeta.com> <E17ye5U-0003ul-00@starship> <3DA1EB1F.C992353@digeo.com>
In-Reply-To: <3DA1EB1F.C992353@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17yeOy-0003uv-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 22:14, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > This is easy to verify: say you have 100 MB of kernel source stored in, say,
> > 50 different clumps on disk.
> 
> Disks use segmentation on their readahead buffers.  Typically four-way.
> So they will only buffer four different chunks of disk at a time.
> 
> If you're reading from 50 different places on disk, the disk keeps
> invalidating readahead at the segment level.

Sure, and kernel-based physical readahead would not have that problem.
(Kernel-based physical readahead has its own problems, for example: how
do you determine that a given physical block is already cached in an
inode and so should be ignored as a readahead candidate?)

-- 
Daniel
