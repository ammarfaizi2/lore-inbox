Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVEMOx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVEMOx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVEMOx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:53:28 -0400
Received: from smtp-server.carlislefsp.com ([12.28.84.26]:34446 "EHLO
	imail.carlislefsp.com") by vger.kernel.org with ESMTP
	id S262357AbVEMOxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:53:24 -0400
X-Archive-Filename: imail111599598668225587 
X-Qmail-Scanner-Mail-From: steve@friservices.com via imail
X-Qmail-Scanner: 1.24st (Clear:RC:1(10.10.2.206):. Processed in 0.725442 secs Process 25587)
Message-ID: <4284BF66.1050704@friservices.com>
Date: Fri, 13 May 2005 09:53:26 -0500
From: steve <steve@friservices.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm1
References: <20050512033100.017958f6.akpm@osdl.org>
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a bug that appeared after running for about 2 hours:

May 13 09:32:34 localhost kernel: BUG: atomic counter underflow at:
May 13 09:32:34 localhost kernel:  [reiserfs_clear_inode+129/176] 
reiserfs_clear_inode+0x81/0xb0
May 13 09:32:34 localhost kernel:  [clear_inode+228/304] 
clear_inode+0xe4/0x130
May 13 09:32:34 localhost kernel:  [dispose_list+112/304] 
dispose_list+0x70/0x130
May 13 09:32:34 localhost kernel:  [prune_icache+191/432] 
prune_icache+0xbf/0x1b0
May 13 09:32:34 localhost kernel:  [shrink_icache_memory+20/64] 
shrink_icache_memory+0x14/0x40
May 13 09:32:34 localhost kernel:  [shrink_slab+345/416] 
shrink_slab+0x159/0x1a0
May 13 09:32:34 localhost kernel:  [balance_pgdat+695/944] 
balance_pgdat+0x2b7/0x3b0
May 13 09:32:34 localhost kernel:  [kswapd+210/240] kswapd+0xd2/0xf0
May 13 09:32:34 localhost kernel:  [autoremove_wake_function+0/80] 
autoremove_wake_function+0x0/0x50
May 13 09:32:34 localhost kernel:  [ret_from_fork+6/20] 
ret_from_fork+0x6/0x14
May 13 09:32:34 localhost kernel:  [autoremove_wake_function+0/80] 
autoremove_wake_function+0x0/0x50
May 13 09:32:34 localhost kernel:  [kswapd+0/240] kswapd+0x0/0xf0
May 13 09:32:34 localhost kernel:  [kernel_thread_helper+5/24] 
kernel_thread_helper+0x5/0x18


the system still runs fine, just figured i'd let you guys know.

Steve
