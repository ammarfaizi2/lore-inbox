Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbUDBCVz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbUDBCVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:21:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:26282 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263092AbUDBCVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:21:31 -0500
Date: Thu, 1 Apr 2004 18:21:27 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401182122.Y21045@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040402011804.GL18585@dualathlon.random> <20040401173014.Z22989@build.pdx.osdl.net> <20040402013547.GM18585@dualathlon.random> <20040401180441.B22989@build.pdx.osdl.net> <20040402021323.GP18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040402021323.GP18585@dualathlon.random>; from andrea@suse.de on Fri, Apr 02, 2004 at 04:13:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> that has nothing to do with freeing the page, that's just releasing 1
> refcount, because you dropped the pte mapping, the page is still there
> healthy in the pagecache ready for somebody else to shmat. If you were
> right then a shmdt+shmat would corrupt the SGA.

Ah, yes I see what you are saying.  This is the same issue with normal
pages and SHM_LOCK that I mentioned earlier, I believe.  I don't see the
best solution, because once you detach w/out any destroy, there could be
nobody to assign the accounting to.  Do you agree?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
