Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbUJZJJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbUJZJJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUJZJJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:09:11 -0400
Received: from [69.55.226.176] ([69.55.226.176]:49808 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S261855AbUJZJI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:08:59 -0400
Message-ID: <417E1425.208@drugphish.ch>
Date: Tue, 26 Oct 2004 11:08:53 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 oops (probably I/O congestion/starvation related), already
 solved?
References: <417A4E16.9080505@drugphish.ch> <20041025201436.GA23934@suse.de>
In-Reply-To: <20041025201436.GA23934@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens,

Thanks for your reply.

> Just to be on the safe side, have you reproduced it without?

Nope, I would first like to backup the data since this trace got me 
pretty scared and I care about the data on this disk. So I bought a 
DVD-R burner and I'm now happily doing my 160GB of backup.

> Just
> because nvidia doesn't show up in the trace, doesn't mean it hasn't
> corrupted memory elsewhere.

Fair enough.

> 00200200 is the list deletion poison, double remove of a list and in
> this case the timer base. That's pretty bad news.
> 
> So please do try and reproduce without the nvidia module.

I will try, for sure and I'll post back my results if I can make it oops 
again.. However I don't know how to reproduce it. I showed up once or 
twice during high I/O and while I was writing to and reading from disk 
over ieee1394. Could it also be a bad cable? The I/O is also dog slow 
when writing to disk, reading is like 15 MBytes/s.

> This is also a list related issue:
> 
>         if (!list_empty(&sbi->s_orphan))
>                 dump_orphan_list(sb, sbi);
>         J_ASSERT(list_empty(&sbi->s_orphan));

I'll also try a new firewire cable, since most of the times (in my 
experience) the cable has been the source of all problems. Normally the 
disk gets only remounted RO during deletion of files (this is a really 
irritating thing right now, I can't delete my files over ieee1394) which 
seems to prevent this kind of oops.

Thanks and best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
