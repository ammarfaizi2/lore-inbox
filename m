Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbULaMIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbULaMIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 07:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbULaMHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 07:07:34 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:33759 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261868AbULaMFz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 07:05:55 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-ac1
Date: Fri, 31 Dec 2004 07:05:52 -0500
User-Agent: KMail/1.7
Cc: Jan Dittmer <jdittmer@ppp0.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1104103881.16545.2.camel@localhost.localdomain> <200412302006.19872.gene.heskett@verizon.net> <41D52275.8030100@ppp0.net>
In-Reply-To: <41D52275.8030100@ppp0.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412310705.52976.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.52.185] at Fri, 31 Dec 2004 06:05:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 December 2004 04:57, Jan Dittmer wrote:
>Gene Heskett wrote:
>> On Thursday 30 December 2004 18:38, Alan Cox wrote:
>>
>> Thanks for the reply Alan, I appreciate it.
>>
>>>On Iau, 2004-12-30 at 05:05, Gene Heskett wrote:
>>>>some sort of an error message that looks like it may be memory
>>>>related.  There's a pair of half giggers in here, running at 333
>>>>fsb, but they are supposedly rated for a 400 mhz fsb. Thats
>>>>presumably because I have turned on the MCE stuffs.
>>>
>>>MCE's generally come from the processor. To decode it you need to
>>>know what CPU and then get the manuals out and decode the bits.
>
>Here is a tool for it: (parsemce.c)
>
>http://www.kernel.org/pub/linux/kernel/people/davej/tools/
>
>Though I do not know for which processors it is supposed to work.
>
>Jan

Well, I've played with it some, but it doesn't seem to see the MCE 
events that are in fact in /var/log/messages.
[root@coyote root]# parsemce -i </var/log/messages
This file contains no MCE dump
[root@coyote root]# parsemce -f /var/log/messages
This file contains no MCE dump

If I feed it the lines with the numbers it reports something about an 
invalid IP on restart.

[root@coyote root]# parsemce -e Bank 2: d40040000000017a -b Bank 2: -s 
d40040000000017a
Status: (ba) Error IP valid
Restart IP invalid.

The exact same output is obtained from the Bank 1 message & numbers 
too.

So I think I do not know how to use it.  Or the severeity of the 
report isn't high enough.  The logfile is currently about 1.27 megs 
but that doesn't seem to be a problem.  I haven't seen any more of 
them since I turned off the nonfatal exceptions in .config.  The 
logfile has several hundred K of samba errors from the plain 2.6.10 
kernel.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
