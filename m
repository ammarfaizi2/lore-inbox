Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVJBUhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVJBUhK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVJBUhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 16:37:09 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23737 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750936AbVJBUhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 16:37:08 -0400
Date: Mon, 3 Oct 2005 06:35:58 +1000
From: Nathan Scott <nathans@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alexander Nyberg <alexn@telia.com>, Neil Brown <neilb@suse.de>,
       Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20051003063558.A5400701@wobbly.melbourne.sgi.com>
References: <20050902003915.GI3657@stusta.de> <20050902053356.GA20603@taniwha.stupidest.org> <20050902162931.A4496772@wobbly.melbourne.sgi.com> <17175.62454.623678.209697@cse.unsw.edu.au> <20050913080552.GA1815@localhost.localdomain> <20051001225012.GE4212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051001225012.GE4212@stusta.de>; from bunk@stusta.de on Sun, Oct 02, 2005 at 12:50:12AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 12:50:12AM +0200, Adrian Bunk wrote:
> On Tue, Sep 13, 2005 at 10:05:52AM +0200, Alexander Nyberg wrote:
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=5210
> 
> Nathan, can you look into this bug?
> 

OK - looks like a scheduling-while-atomic warning on a metdata
buffer read, then a panic (sometime later?) at do_page_fault
with no useful stack trace (removed by bug reporter? - thats
the one you need...).  The first stack trace (atomic/shedule)
would not be >4K afaict, so thats a red herring I think.

cheers.

-- 
Nathan
