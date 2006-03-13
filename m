Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWCMOmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWCMOmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 09:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWCMOmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 09:42:23 -0500
Received: from rtr.ca ([64.26.128.89]:9649 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751154AbWCMOmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 09:42:22 -0500
Message-ID: <441584AD.8060503@rtr.ca>
Date: Mon, 13 Mar 2006 09:41:49 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Marr <marr@flex.com>
Cc: Linda Walsh <lkml@tlinx.org>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()'
 Calls From 2.4 to 2.6 -- VMM Change?)
References: <200602241522.48725.marr@flex.com> <200603121653.30288.marr@flex.com> <44149D6A.7080005@rtr.ca> <200603122336.55701.marr@flex.com>
In-Reply-To: <200603122336.55701.marr@flex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marr wrote:
>
> Anyway, not that it really matters, but I re-did the testing with '-a0' and it 
> didn't help one iota. The 2.6.13 kernel on ReiserFS (without using 
> 'nolargeio=1' as a mount option) still takes about 4m35s to fseek 200,000 
> times on that 4MB file, even with 'hdparm -a0 /dev/hda' in effect.

Does it make a difference when done on the filesystem *partition*
rather than the base drive?  At one time, this mattered, and it may
still work that way today.

Eg.  hdparm -a0 /dev/hda3   rather than   hdparm -a0 /dev/hda

??
