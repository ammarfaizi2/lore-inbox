Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWCMUBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWCMUBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWCMUBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:01:39 -0500
Received: from flex.com ([206.126.0.13]:25616 "EHLO flex.com")
	by vger.kernel.org with ESMTP id S932411AbWCMUBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:01:38 -0500
From: Marr <marr@flex.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?)
Date: Mon, 13 Mar 2006 15:00:26 -0500
User-Agent: KMail/1.8.2
Cc: Linda Walsh <lkml@tlinx.org>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Andrew Morton <akpm@osdl.org>, marr@flex.com
References: <200602241522.48725.marr@flex.com> <200603122336.55701.marr@flex.com> <441584AD.8060503@rtr.ca>
In-Reply-To: <441584AD.8060503@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131500.26842.marr@flex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 9:41am, Mark Lord wrote:
> Marr wrote:
> > Anyway, not that it really matters, but I re-did the testing with '-a0'
> > and it didn't help one iota. The 2.6.13 kernel on ReiserFS (without using
> > 'nolargeio=1' as a mount option) still takes about 4m35s to fseek 200,000
> > times on that 4MB file, even with 'hdparm -a0 /dev/hda' in effect.
>
> Does it make a difference when done on the filesystem *partition*
> rather than the base drive?  At one time, this mattered, and it may
> still work that way today.
>
> Eg.  hdparm -a0 /dev/hda3   rather than   hdparm -a0 /dev/hda
>
> ??

Unfortunately, it makes no difference. That is, after successfully setting 
'-a0' on the partition in question (instead of the whole HDD device itself), 
the 200,000 random 'fseek()' calls still take about 4m35s on ReiserFS 
(without using 'nolargeio=1' as a mount option) under kernel 2.6.13.

P.S. I've CC:ed you and the others on my reply to Al Boldi's request for the 
'hdparm -I /dev/hda' information, in case it helps at all.

Thanks for your inputs, Mark -- much appreciated!

*** Please CC: me on replies -- I'm not subscribed.

Regards,
Bill Marr
