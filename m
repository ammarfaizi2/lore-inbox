Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbSIZOU0>; Thu, 26 Sep 2002 10:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSIZOU0>; Thu, 26 Sep 2002 10:20:26 -0400
Received: from thunk.org ([140.239.227.29]:18848 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261294AbSIZOUZ>;
	Thu, 26 Sep 2002 10:20:25 -0400
Date: Thu, 26 Sep 2002 10:25:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>,
       Jakob Oestergaard <jakob@unthought.net>,
       "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: jbd bug(s) (?)
Message-ID: <20020926142504.GC9400@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>,
	Jakob Oestergaard <jakob@unthought.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@zip.com.au>
References: <20020924072117.GD2442@unthought.net> <20020925173605.A12911@redhat.com> <20020926122124.GS2442@unthought.net> <20020926132723.D2721@redhat.com> <20020926125647.GT2442@unthought.net> <20020926134435.GA9400@think.thunk.org> <20020926150557.A18323@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020926150557.A18323@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 03:05:57PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 26, 2002 at 09:44:35AM -0400, Theodore Ts'o wrote:
> > block size).  So we could add larger block sizes, but it would mean
> > adding a huge amount of complexity for minimal gain (and if you really
> > want that, you can always use XFS, which pays that complexity cost).
> 
> XFS does't support blocksize > PAGE_CACHE_SIZE under linux. In fact the
> latest public XFS/Linux release doesn't even support any blocksize other
> than PAGE_CACHE_SIZE.  This has changed in the development tree now and
> the version merged in 2.5 and the next public 2.4 release will have that
> support.  Doing blocksize > PAGE_CACHE_SIZE will difficult if not
> impossible due VM locking issues with the 2.4 and 2.5 VM code.

My mistake.  At one point I was talking to Mark Lord and I had gotten
the impression they had some Irix-VM-to-Linux-VM mapping layer which
would make blocksize > PAGE_SIZE possible.

						- Ted
