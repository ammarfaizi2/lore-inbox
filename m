Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUITBSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUITBSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 21:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUITBSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 21:18:25 -0400
Received: from holomorphy.com ([207.189.100.168]:11195 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265230AbUITBSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 21:18:24 -0400
Date: Sun, 19 Sep 2004 18:18:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Modular filesystem using drop_inode would need inode_lock
Message-ID: <20040920011812.GQ9106@holomorphy.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F019FB78F@scsmsx401.amr.corp.intel.com> <20040709220644.GA6945@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709220644.GA6945@infradead.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 02:43:32PM -0700, Luck, Tony wrote:
>> This is mostly a logical inconsistency at the moment (since the
>> only filesystem that has a "drop_inode" function defined in its
>> super_operations is hugetlbfs, and it is unlikely to move out of

On Fri, Jul 09, 2004 at 11:06:44PM +0100, Christoph Hellwig wrote:
> And btw, ->drop_inode usage in hugetlbfs is also a really bad idea,
> it's duplicating large parts of fs/inode.c and is already missing
> all kinds of updates.

I suppose this reply is a bit late, but...

I'd be happy to hear of alternative methods of dealing with hugetlbfs'
operational constraints. The unusability of the core VM function
truncate_inode_pages() on hugetlb pagecache was IIRC be the primary
reason for it, but there also appears to be some inode management going
on there now that it's been disturbed by someone else.


-- wli
