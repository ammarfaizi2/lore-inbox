Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSIZOAz>; Thu, 26 Sep 2002 10:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261311AbSIZOAz>; Thu, 26 Sep 2002 10:00:55 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:17681 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261310AbSIZOAy>; Thu, 26 Sep 2002 10:00:54 -0400
Date: Thu, 26 Sep 2002 15:05:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Jakob Oestergaard <jakob@unthought.net>,
       "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: jbd bug(s) (?)
Message-ID: <20020926150557.A18323@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jakob Oestergaard <jakob@unthought.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@zip.com.au>
References: <20020924072117.GD2442@unthought.net> <20020925173605.A12911@redhat.com> <20020926122124.GS2442@unthought.net> <20020926132723.D2721@redhat.com> <20020926125647.GT2442@unthought.net> <20020926134435.GA9400@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020926134435.GA9400@think.thunk.org>; from tytso@mit.edu on Thu, Sep 26, 2002 at 09:44:35AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 09:44:35AM -0400, Theodore Ts'o wrote:
> block size).  So we could add larger block sizes, but it would mean
> adding a huge amount of complexity for minimal gain (and if you really
> want that, you can always use XFS, which pays that complexity cost).

XFS does't support blocksize > PAGE_CACHE_SIZE under linux. In fact the
latest public XFS/Linux release doesn't even support any blocksize other
than PAGE_CACHE_SIZE.  This has changed in the development tree now and
the version merged in 2.5 and the next public 2.4 release will have that
support.  Doing blocksize > PAGE_CACHE_SIZE will difficult if not
impossible due VM locking issues with the 2.4 and 2.5 VM code.

> It'd be nice to get real VM support for this, but that will almost
> certainly have to wait for 2.6.

I don't really see this happening before Halloween..

