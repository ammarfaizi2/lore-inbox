Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUDBA76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUDBA76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:59:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:18657 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263472AbUDBA7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:59:48 -0500
Date: Thu, 1 Apr 2004 16:59:44 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401165944.X22989@build.pdx.osdl.net>
References: <20040401223619.GB18585@dualathlon.random> <Pine.LNX.4.44.0404011807350.5589-100000@chimarrao.boston.redhat.com> <20040401232603.GE18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040401232603.GE18585@dualathlon.random>; from andrea@suse.de on Fri, Apr 02, 2004 at 01:26:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> On Thu, Apr 01, 2004 at 06:08:18PM -0500, Rik van Riel wrote:
> > Oracle seems to be using it just fine in a certain 2.4
> > based kernel, so why exactly do you think it would be
> > useless for the problem you want to solve ?
> > 
> > Also, what would need to be fixed in order for it to
> > not be useless ? ;)
> 
> tell me how to call shmget(SHM_HUGETLB) without having the CAP_IPC_LOCK
> with the rlimit patch.

Account for the equivalent "locked" huge pages on shmget.  I did something
like this when porting the mlock patch to 2.6 a month or so ago.  I also
recall finding a couple problems along the way, but it's been a while.
I'll dig up what I have and send it in.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
