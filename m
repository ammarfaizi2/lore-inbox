Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbVKIWX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbVKIWX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbVKIWX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:23:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:46025 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030451AbVKIWX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:23:57 -0500
From: Neil Brown <neilb@suse.de>
To: Chris Boot <bootc@bootc.net>
Date: Thu, 10 Nov 2005 09:23:36 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17266.30440.930561.902428@cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-mm1 RAID-1 in D< state
In-Reply-To: message from Chris Boot on Wednesday November 9
References: <4371FA5B.6030900@bootc.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 9, bootc@bootc.net wrote:
> Hi all,
> 
> I haven't noticed this until today...but my load average has been 
> skyrocketing past 3.00 since Monday, which is when I upgraded to 
> 2.6.14-mm1. I've got 3 Software RAID-1 arrays across 4 SATA disks, and 
> all 3 processes are locked in an uninterruptible sleep.
> 
> What's interesting, though, is I haven't noticed a degradation of 
> performance at all, and all the arrays work absolutely fine. They aren't 
> rebuilding or doing anything strange that I can see.
> 
> Any ideas?

Can you
  echo t > /proc/sysrq-trigger
  dmesg > /tmp/log
and post the log created, possibly removing everything before
   SysRq : Show State

If you can't find the 'Show State', then maybe your log buffer isn't
big enough.  use 'dmesg -s ...' to make it bigger and try again.

NeilBrown
