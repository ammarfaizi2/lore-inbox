Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUIQRTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUIQRTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 13:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUIQRTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 13:19:47 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:5612 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S268884AbUIQRTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 13:19:45 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: journal aborted, system read-only
Date: Fri, 17 Sep 2004 13:19:43 -0400
User-Agent: KMail/1.7
Cc: Valdis.Kletnieks@vt.edu, "Stephen C. Tweedie" <sct@redhat.com>
References: <200409121128.39947.gene.heskett@verizon.net> <200409160936.01539.gene.heskett@verizon.net> <200409171630.i8HGUF92007463@turing-police.cc.vt.edu>
In-Reply-To: <200409171630.i8HGUF92007463@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409171319.43806.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.58.242] at Fri, 17 Sep 2004 12:19:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 September 2004 12:30, Valdis.Kletnieks@vt.edu wrote:
>On Thu, 16 Sep 2004 09:36:01 EDT, Gene Heskett said:
>> >This happened about 4 minutes into a 'tar cf - | (cd && tar xf
>> > -)' pipeline to clone a work copy of the -rc1-mm5 source tree
>> > (it got about 408M through the 543M before it blew up)....
>>
>> Humm, it happened to me while amdump was running, and amdump uses
>> tar. My tar version is 1.13-25.
>
>I don't think "tar" is anything more than an enabler here - it's
> just that on my laptop it's one of the more abusive things I can do
> to the file system (especially when source and dest directories are
> on the same file system).  I've had the problem pop up while
> reading down my e-mail, which is another "lots of little files"
> scenario (500+ lines of procmailrc, passing stuff to/from
> spamassassin, and storing in the MH "one message per file"
> format)....

Thats the same conclusion I've since come to, Valdis.  And, now that 
I've moved my /var to its own partition on another disk, that may 
have reduced the thrashing of that drive enough to stop the problem.  
At least I've had no more such occurances since I moved /var off 
of /.  About 30.5 hours now according to the uptime display in 
gkrellm.

>I'm about to start building -rc2-mm1 - I'm probably going to
> liberally sprinkle some strategic printk's so we have a chance of
> flushing out why it's failing...

I've been thinking about it too, but I found a bug in one of the 
amanda utilities thats had my attention the last day or so & just 
fixed in the last half hour.  If you can make a patch out of those 
printk's against rc2-mm1, send it along and I'll taste-test for the 
arsenic in the desert too maybe.  The More Eyeballs theory & all that 
rot.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
