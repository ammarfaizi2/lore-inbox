Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTJMVjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 17:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTJMVjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 17:39:49 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:35804 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261957AbTJMVjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 17:39:47 -0400
Message-ID: <3F8B1BA1.4020800@wmich.edu>
Date: Mon, 13 Oct 2003 17:39:45 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: linux-kernel@vger.kernel.org, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] EXT3 extents against 2.6.0-test7
References: <20031013222747.37f5ee7b.alex@clusterfs.com>
In-Reply-To: <20031013222747.37f5ee7b.alex@clusterfs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
> changes since last publication:
> 1) few bugs fixed: they caused extents tree corruption
> 2) several asserts added
> 3) binary search used to find an extent
> 4) last found entry is cached: this allows to skip tree
>    traversal and saves cpu a bit
> 5) truncate_sem is used to serialize get_block()/trucate()
> 
> 
> with best wishes, Alex
> 
> 


I've been using extents since the patch was introduced.  I haven't seen 
any corruption when using it with large files (ie. multimedia only).  In 
short, has there been any progress with getting fsck support? I'm 100% 
in support of this patch going into mainline kernel as a non-default 
option.  It's perfect for partitions that deal with large files, but 
still want ext3's fs corruption protection.  I average 10700 blocks an 
extent and see an extreme increase in performance over non-extents ext3 
doing operations on files of the same size.   I guess it's about time to 
update.

