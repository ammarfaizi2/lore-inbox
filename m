Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbSJHSlC>; Tue, 8 Oct 2002 14:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJHSkL>; Tue, 8 Oct 2002 14:40:11 -0400
Received: from thunk.org ([140.239.227.29]:34243 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261455AbSJHSjz>;
	Tue, 8 Oct 2002 14:39:55 -0400
Date: Tue, 8 Oct 2002 14:45:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 2/4] Add extended attributes to ext2/3
Message-ID: <20021008184534.GB8174@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E17yymE-00021l-00@think.thunk.org> <20021008192306.B12912@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008192306.B12912@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 07:23:06PM +0100, Christoph Hellwig wrote:
> 
> The code doesn't really make ?ny sense outside ext2/ext3. I'd suggest you
> move it there instead of bloating every kernel with it unconditionally.

The code is general enough that it can be used for a variety of
purposes, not just ext2/ext3, although granted at the moment only ext2
and ext3 are using it.  Also, having two copies of the code bewteen
the ext2 and ext3 directories is undeseriable.

Probably the right thing to do is to add the appropriate logic in
fs/Config.in so it's only enabled when necessary.

> 
> __mb_cache_entry_in_lru() is buggy and can't work anymore now that akpm removed
> some list_head debugging.

Oops.  Nice catche.  I didn't notice since it's only used in the
mb_assert code, which I hadn't enabled.

> And please get rid of the LINUX_VERSION_CODE checks..

Thanks.  Missed those....

					- Ted
