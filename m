Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263476AbTJBUf1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 16:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTJBUf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 16:35:27 -0400
Received: from [205.180.85.17] ([205.180.85.17]:58007 "EHLO mail.fastclick.net")
	by vger.kernel.org with ESMTP id S263476AbTJBUfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 16:35:17 -0400
Message-ID: <3F7C8BCB.70605@fastclick.com>
Date: Thu, 02 Oct 2003 13:34:19 -0700
From: Brett <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Getting total memory used by processes
References: <Pine.LNX.4.44.0310021544330.25860-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310021544330.25860-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I tried to be sneaky but you caught me! :D I should have said 
that I'm seeing the same thing with both the -rmap and stock kernel, the 
data I collected was from a stock kernel.

Here's the data from an 2.4.22 -rmap kernel:

# getmem.pl
Total size = 4967032

# cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  1056083968 1047187456  8896512        0 12722176 592035840
Swap: 1077501952 88113152 989388800
MemTotal:      1031332 kB
MemFree:          8688 kB
MemShared:           0 kB
Buffers:         12424 kB
Cached:         519428 kB
SwapCached:      58732 kB
Active:         696796 kB
ActiveAnon:     335180 kB
ActiveCache:    361616 kB
Inact_dirty:        76 kB
Inact_laundry:  147524 kB
Inact_clean:     22068 kB
Inact_target:   173292 kB
HighTotal:      131072 kB
HighFree:         1112 kB
LowTotal:       900260 kB
LowFree:          7576 kB
SwapTotal:     1052248 kB
SwapFree:       966200 kB

maps file:

# cat /proc/21234/maps
08048000-080f3000 r-xp 00000000 03:04 293805     /usr/bin/perl
080f3000-080fb000 rw-p 000aa000 03:04 293805     /usr/bin/perl
080fb000-0d423000 rwxp 00000000 00:00 0
40000000-40013000 r-xp 00000000 03:04 81603      /lib/ld-2.2.5.so
40013000-40014000 rw-p 00013000 03:04 81603      /lib/ld-2.2.5.so
40015000-40017000 r-xp 00000000 03:04 539158 
/usr/lib/perl5/site_perl/5.6.1/i386-linux/auto/Time/HiRes/HiRes.so
40017000-40018000 rw-p 00001000 03:04 539158 
/usr/lib/perl5/site_perl/5.6.1/
...

Rik van Riel wrote:

> On Thu, 2 Oct 2003, Brett wrote:
> 
> 
>>I patched the kernel with rmap and i2c,
> 
> 
>># cat /proc/meminfo
>>Active:         813644 kB
>>Inactive:       582436 kB
> 
> 
> This isn't -rmap.  I would like to help you debug your
> problem, but it would be nice if you could at least
> record your debugging info running the kernel you want
> to have debugged ;)
> 


