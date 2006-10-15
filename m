Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWJOTRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWJOTRw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWJOTRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:17:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:54734 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030249AbWJOTRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:17:51 -0400
Date: Sun, 15 Oct 2006 12:19:31 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ipslinux@adaptec.com, LKML <linux-kernel@vger.kernel.org>,
       Jack Hammer <jack_hammer@adaptec.com>
Subject: Re: ips: scheduling while atomic in 2.6.18
Message-ID: <20061015191931.GH10744@us.ibm.com>
References: <20061014015244.GC10744@us.ibm.com> <453251A4.7060706@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453251A4.7060706@yahoo.com.au>
X-Operating-System: Linux 2.6.18 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2006 [01:20:04 +1000], Nick Piggin wrote:
> Nishanth Aravamudan wrote:
> >Hi all,
> >
> >A server I administer just dumped three scheduling while atomics before
> >(sort of) hanging hard. Still responds to ping, but ssh is now dead and
> >the serial console stopped logging.
> >
> >8-way PIII, 2.6.18 with the 3:1 split. Wanted to get my report out there
> >before I reset the box, though.
> 
> Thanks for the report. The messages are caused by this commit (cc'ed 
> author):
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=15084a4a63bc300c18b28a8a9afac870c552abce
> 
> Not sure whether they are the cause of your hang, but the from the
> changelog it doesn't look like the commit was strictly a bugfix so you
> could try changing msleep calls in the driver back to MDELAY.

Ah yes, that was what I was going to try next, if I didn't hear back
from anyone :)

I'll let you know if that changes anything. This box has been hanging
for a little while now, on an inconsistent basis -- this was just the
first time I was able to grab these traces. And by hanging hard, I mean
no console, serial or physical, no SysRq, nothing. It's all rather odd.

Will keep you posted.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
