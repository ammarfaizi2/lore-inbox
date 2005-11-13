Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVKMKla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVKMKla (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 05:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVKMKla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 05:41:30 -0500
Received: from ns2.suse.de ([195.135.220.15]:48815 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932357AbVKMKl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 05:41:29 -0500
From: Neil Brown <neilb@suse.de>
To: "Miro Dietiker, MD Systems" <info@md-systems.ch>
Date: Sun, 13 Nov 2005 21:41:12 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17271.6216.944507.182685@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Locking md device and system for several seconds
In-Reply-To: message from Miro Dietiker, MD Systems on Sunday November 13
References: <014101c5e83d$759c3df0$4001a8c0@MDSYSPORT>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 13, info@md-systems.ch wrote:
> Hi!
> 
> I'm using kernel 2.6.14.2 with md (RAID1 static) as bootable.
> 
> While md synching (initial creation or after marked one as failed,
> removed and re-added) there are some locking problems with the
> complete system/kernel.

Can you check which IO scheduler the drives are using, try different
schedulers, and see if it makes a different.

     grep . /sys/block/*/queue/scheduler

will show you (the one in [brackets] is active). 
Then just echo a new value out to each file.

I've had one report that [anticipatory] causes this problem and [cfq]
removes it.  Could you confirm that?

Thanks,

NeilBrown

