Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUAPFVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUAPFVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:21:48 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:4552 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265245AbUAPFVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:21:45 -0500
Message-ID: <400774E0.8020508@kriminell.com>
Date: Fri, 16 Jan 2004 06:21:36 +0100
From: marcel cotta <marcel@kriminell.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: kernel BUG at mm/swapfile.c:806
References: <400751B1.40608@kriminell.com>	<20040115203419.76332f6a.akpm@osdl.org>	<40076B62.9000108@kriminell.com> <20040115204302.2909af64.akpm@osdl.org>
In-Reply-To: <20040115204302.2909af64.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> marcel cotta <marcel@kriminell.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>marcel cotta <marcel@kriminell.com> wrote:
>>>
>>>
>>>>i got this oops after the box swapped like crazy under X for about 5 
>>>>minutes
>>>>while swapping it was nearly unusable (jerky mouse, console switching 
>>>>took 10 seconds)
>>>>the extreme performance drop is always reproducible when swapping starts
>>>>
>>>>
>>>>------------[ cut here ]------------
>>>>kernel BUG at mm/swapfile.c:806!
>>>
>>>
>>>Amazing.  Are you using a swapfile, or are you swapping to a block device?
>>>
>>>
>>>
>>>
>>
>>hehe, hasnt been reported for a while eh ;)
>>
>>i used swapfiles, one static 50mb file and the rest in temp 16MB 
>>blocks managed by swapd
> 
> 
> What is `swapd'?
> 
> 

it checks the remaining free memory every n seconds and creates
swapfiles by n size if needed


the README:

swapd 0.2 (May 21, 2000), copyright Neven Lovric <nlovric@linux.hr>

swapd is a dynamic swapping manager for Linux. It provides the system with
as much swap space (virtual memory) as is required at a particular time by
dynamicly creating swap files. This is more convinient than using
fixed swap
files and/or partitions because they (a) are unused most of the time
and are
just taking up disk space; and (b) provide a limited amount of virtual
memory.

This program is free software released under the terms of the GNU General
Public License. Please refer to file 'COPYING' for more information.

The latest version of this program can be found at
http://cvs.linux.hr/swapd
or at ftp.linux.hr in /pub/swapd.


