Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSENHVi>; Tue, 14 May 2002 03:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314783AbSENHVh>; Tue, 14 May 2002 03:21:37 -0400
Received: from imladris.infradead.org ([194.205.184.45]:64525 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312938AbSENHVg>; Tue, 14 May 2002 03:21:36 -0400
Date: Tue, 14 May 2002 08:21:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, axboe@suse.de, martin@dalecki.de,
        neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
Message-ID: <20020514082130.A15907@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com, axboe@suse.de,
	martin@dalecki.de, neilb@cse.unsw.edu.au
In-Reply-To: <20020513131339.A4610@infradead.org> <15584.23204.925373.44968@wombat.chubb.wattle.id.au> <3CE071F7.347C78B5@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 07:09:59PM -0700, Andrew Morton wrote:
> 
> I think Christoph's point is that a pagecache index is not a sector
> number.  We agree that we need to plan for taking it to 64 bits, but
> it should be something different. Like pageindex_t, or whatever.

I don't think we want to increase it.  First it grow struct page by 32bits
and second 64bit arithmetic on 32bit plattforms is still very expensive.
I'd rather see PAGE_CACHE_SIZE growing to address the issues.

