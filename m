Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWHGAin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWHGAin (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 20:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWHGAin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 20:38:43 -0400
Received: from ns2.suse.de ([195.135.220.15]:11999 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750852AbWHGAim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 20:38:42 -0400
From: Neil Brown <neilb@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Date: Mon, 7 Aug 2006 10:38:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17622.35724.43741.529875@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [patch] raid1: allow user to force reads from a specific disk
In-Reply-To: message from Chuck Ebbert on Sunday August 6
References: <200608062018_MC3-1-C74D-B4E9@compuserve.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday August 6, 76306.1226@compuserve.com wrote:
> Allow user to force raid1 to read all data from a given disk.
> This lets users do integrity checking by comparing results
> from reading different disks.  If at any time the system finds
> it cannot read from the given disk it resets the disk number
> to -1, the default, which means to balance reads.

Could say a little bit more about why you want this?

You could get nearly the same situation be setting the other drives to
write-mostly. 

And the more thorough integrity check is available via
   echo check > /sys/block/mdX/md/sync_action

NeilBrown
