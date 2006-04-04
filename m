Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWDDUZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWDDUZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 16:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWDDUZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 16:25:21 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:8607 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750837AbWDDUZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 16:25:20 -0400
Message-ID: <4432D6D4.2020102@tmr.com>
Date: Tue, 04 Apr 2006 16:28:04 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060330 SeaMonkey/1.5a
MIME-Version: 1.0
To: Vishal Patil <vishpat@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com> <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com>
In-Reply-To: <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Patil wrote:
> Maintain two queues which will be sorted in ascending order using Red
> Black Trees. When a disk request arrives and if the block number it
> refers to is greater than the block number of the current request
> being served add (merge) it to the first sorted queue or else add
> (merge) it to the second sorted queue. Keep on servicing the requests
> from the first request queue until it is empty after which switch over
> to the second queue and now reverse the roles of the two queues.
> Simple and Sweet. Many thanks for the awesome block I/O layer in the
> 2.6 kernel.
> 
Why both queues sorting in ascending order? I would think that one 
should be in descending order, which would reduce the seek distance 
between the last i/o on one queue and the first on the next.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
