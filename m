Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263469AbUCTQan (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUCTQan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:30:43 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59605
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263472AbUCTQal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:30:41 -0500
Date: Sat, 20 Mar 2004 17:31:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Message-ID: <20040320163132.GV9009@dualathlon.random>
References: <20040318164253.GO2246@dualathlon.random> <Pine.LNX.4.44.0403181144290.16728-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403181144290.16728-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 11:49:52AM -0500, Rik van Riel wrote:
> It's in the RHEL3 kernel, a patch named linux-2.4.21-mlock.patch.
> 
> Basically it allows any normal process to have up to its
> current->rlim[RLIMIT_MEMLOCK].rlim_cur memory locked.
> Root can configure, in /etc/security/limits.conf, how much 
> memory the processes of each user are allowed to mlock.
> 
> Processes with CAP_IPC_LOCK set can mlock as much as they
> want, unrestricted by the limit.
> 
> Last year at the kernel summit, Linus seemed pretty happy
> with this approach.  I think Wim Coekaerts at Oracle has
> ported the patch to 2.6 already...
> 
> I suspect the security paranoid will like this patch too,
> because it allows gnupg to mlock the memory it wants to
> have locked.

I agree.

> Now it just needs to be submitted to Andrew and Linus ;)

could somebody submit it to me too? ;) otherwise I'll have to search for
some big rpm.

what I was thinking about was more basic without checking the rlimits,
certainly I agree using the rlimits is a very nice bonus (though the
code is a bit more complicated, and it won't be a one liner in
remap_file_pages as I was hoping for ;).
