Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268207AbUHFSov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268207AbUHFSov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268208AbUHFSov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:44:51 -0400
Received: from [195.23.16.24] ([195.23.16.24]:51360 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268207AbUHFSot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:44:49 -0400
Message-ID: <4113D19F.8060608@grupopie.com>
Date: Fri, 06 Aug 2004 19:44:47 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Charbonnel <thomas@undata.org>
Cc: Ingo Molnar <mingo@redhat.com>, Shane Shrybman <shrybman@aei.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
References: <1091459297.2573.10.camel@mars>	 <Pine.LNX.4.58.0408031019090.20420@devserv.devel.redhat.com> <1091815684.7586.28.camel@localhost>
In-Reply-To: <1091815684.7586.28.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.63; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Charbonnel wrote:
>....
> While accessing the file system (this one is very frequent):
> 
> Aug  2 15:32:24 satellite (bash/5298): 1095us non-preemptible critical
> section violated 1000 us preempt threshold starting at
> search_by_key+0x120/0x1140 and ending at voluntary_resched+0x1a/0x70
> Aug  2 15:32:24 satellite [<c010574e>] dump_stack+0x1e/0x30
> Aug  2 15:32:24 satellite [<c01171a6>] touch_preempt_timing+0x36/0x50
> Aug  2 15:32:24 satellite [<c042856a>] voluntary_resched+0x1a/0x70
> Aug  2 15:32:24 satellite [<c0158c44>] __getblk+0x44/0x70
> Aug  2 15:32:24 satellite [<c01ae348>] search_by_key+0x78/0x1140
> Aug  2 15:32:24 satellite [<c01af4bc>]
> search_for_position_by_key+0xac/0x3f0
> Aug  2 15:32:24 satellite [<c019e0c4>]
> reiserfs_allocate_blocks_for_region+0x354/0x15b0
> Aug  2 15:32:24 satellite [<c01a0c4c>] reiserfs_file_write+0x61c/0x8d0
                                          ^^^^^^^^
I remember some discussion on a "voluntary preempt" thread, about 
reiserfs being bad for latency.

You might search the archives for this, but as far as I remember, ext3 
was a better alternative, latency-wise.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"
