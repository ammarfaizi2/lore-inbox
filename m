Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315233AbSEQATi>; Thu, 16 May 2002 20:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315235AbSEQATh>; Thu, 16 May 2002 20:19:37 -0400
Received: from dsl-213-023-040-248.arcor-ip.net ([213.23.40.248]:46312 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315233AbSEQATe>;
	Thu, 16 May 2002 20:19:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [PATCH] remove 2TB block device limit
Date: Fri, 17 May 2002 02:18:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Peter Chubb <peter@chubb.wattle.id.au>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        axboe@suse.de, akpm@zip.com.au, martin@dalecki.de,
        neilb@cse.unsw.edu.au
In-Reply-To: <15588.18673.317088.198281@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178VRs-0008Va-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 May 2002 02:04, Peter Chubb wrote:
> >>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:
> 
> Daniel> On Tuesday 14 May 2002 03:36, Anton Altaparmakov wrote:
> >> ...And yes at the moment the pagecache limit is also a problem
> >> which we just ignore in the hope that the kernel will have gone to
> >> 64 bits by the time devices grow that large as to start using > 32
> >> bits of blocks/pages...
> 
> Daniel> PAGE_CACHE_SIZE can also grow, so 32 bit architectures are
> Daniel> further away from the page cache limit on than it seems.
> 
> Check out the table on page 2 of
> http://www.scsita.org/statech/01s005r1.pdf 
> 
> The SCSI trade association is predicting 200TB in a high-end server
> within 10 years --- and  2TB in a high-end desktop by 2004.  I'd take
> some of their predictions with a grain of salt, however.

The server definitely won't be running a 32 bit processor, and the high
end desktop probably won't.  In any event, the current 44 bit limitation
(32 bit arch) on the page cache takes us up to 16 TB, and going to a 16 KB 
PAGE_CACHE_SIZE takes us to 64 TB, so I don't think we have to start
slicing and dicing that part of the kernel just now.  Anybody who expects
to run into this limitation should of course raise their hand.

Incidently, the 200 TB high-end servers are a lot closer than you think.

-- 
Daniel
