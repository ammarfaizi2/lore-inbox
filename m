Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUDXEE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUDXEE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 00:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUDXEE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 00:04:58 -0400
Received: from [81.219.144.6] ([81.219.144.6]:13581 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261900AbUDXEEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 00:04:55 -0400
Message-ID: <4089E761.5050708@pointblue.com.pl>
Date: Sat, 24 Apr 2004 05:04:49 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: ncunningham@linuxmail.com
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
References: <4089DC36.5020806@pointblue.com.pl> <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au>
In-Reply-To: <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

> Hi.
>
> Can we assume you've tried running mkswap again? Could you also show  
> /proc/meminfo prior to suspending?

Looking into code, quite frankly I can assume that my computer would 
have to eat up 900MB of swap. Very unquite as whole thing hangs whem 
swap usage is twice memory. Simply due to slow HD, wait times are far 
too long for him to cope with it.

with swap redone (swapoff /dev/hda1 && mkswap -v1 /dev/hda1 && swapon 
/dev/hda1), still the same happends.


meminfo:

nalesnik:~# cat /proc/meminfo
MemTotal:       109568 kB
MemFree:         36544 kB
Buffers:         15576 kB
Cached:          30360 kB
SwapCached:          0 kB
Active:          36464 kB
Inactive:        19436 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       109568 kB
LowFree:         36544 kB
SwapTotal:     1172704 kB
SwapFree:      1172704 kB
Dirty:              16 kB
Writeback:           0 kB
Mapped:          16632 kB
Slab:            10672 kB
Committed_AS:    22584 kB
PageTables:        512 kB
VmallocTotal:   925656 kB
VmallocUsed:      4784 kB
VmallocChunk:   920548 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB


