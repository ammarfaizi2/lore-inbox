Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUHWXCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUHWXCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUHWW4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:56:15 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:63361 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S267989AbUHWWy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:54:28 -0400
Date: Mon, 23 Aug 2004 14:54:26 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops during mkfs, SMP Opteron, 2.6.8.1 / -mm4
Message-ID: <20040823225426.GE2519@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040823181204.GB2519@iarc.uaf.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823181204.GB2519@iarc.uaf.edu>
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

* Christopher Swingley <cswingle@iarc.uaf.edu> [2004-Aug-23 10:12 AKDT]:
> Unable to handle kernel paging request at 0000000000200e6f RIP:
> <ffffffff80157081>{kmem_getpages+129}
> PML4 1fdcd9067 PGD 1fe351067 PMD 0
> Oops: 0000 [1] SMP
> CPU 1
> Modules linked in: 8139too mii crc32 tg3
> Pid: 1719, comm: mkfs.ext3 Not tainted 2.6.8.1

I know it's bad form to reply to one's own posting, but I suspect that 
more information is probably useful here.

Since posting this, I've tried a single processor version of the 2.6.8.1 
kernel (even though it's a dual Opteron) and I didn't get the oops.  
I've also tried an SMP kernel without CONFIG_K8_NUMA, and the oops also 
disappears.

So the issue appears to be related to the K8_NUMA stuff, and I'll 
continue on with a non-NUMA SMP 2.6.8.1 and see if the system stays up 
and running.

Thanks,

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu (work)
Intl. Arctic Research Center            cswingle@gmail.com (personal)
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

